terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# 1. Networking (Self-contained for the lab)
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = merge(var.tags, { Name = "day-a3-vpc" })
}

resource "aws_subnet" "db_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.3.1.0/24"
  availability_zone = "${var.aws_region}a"
  tags              = merge(var.tags, { Name = "day-a3-db-subnet-a" })
}

resource "aws_subnet" "db_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.3.2.0/24"
  availability_zone = "${var.aws_region}b"
  tags              = merge(var.tags, { Name = "day-a3-db-subnet-b" })
}

resource "aws_db_subnet_group" "main" {
  name       = "day-a3-db-subnet-group"
  subnet_ids = [aws_subnet.db_a.id, aws_subnet.db_b.id]
  tags       = var.tags
}

# 2. Security: DB Security Group
resource "aws_security_group" "db" {
  name        = "day-a3-db-sg"
  description = "Allow DB traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 4. Secrets: Store DB credentials in Secrets Manager
resource "random_password" "db_password" {
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret" "db_credentials" {
  name = "day-a3-db-credentials-${random_string.suffix.result}"
  tags = merge(var.tags, { Name = "day-a3-db-secret" })
}

resource "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = "tofuadmin"
    password = random_password.db_password.result
    engine   = "postgres"
    host     = aws_db_instance.main.address
    port     = 5432
    dbname   = "tofudb"
  })
}

# 5. Data: AWS RDS (PostgreSQL)
resource "aws_db_instance" "main" {
  identifier             = "day-a3-db-${random_string.suffix.result}"
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = "db.t3.micro"
  db_name                = "tofudb"
  username               = "tofuadmin"
  password               = random_password.db_password.result
  parameter_group_name   = "default.postgres15"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db.id]

  tags = var.tags
}

# 6. Storage: S3 with Versioning
resource "aws_s3_bucket" "main" {
  bucket = "day-a3-data-${random_string.suffix.result}"
  tags   = var.tags
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 7. Observability: CloudWatch Alarm
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "day-a3-rds-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors RDS cpu utilization"
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.main.id
  }
}
