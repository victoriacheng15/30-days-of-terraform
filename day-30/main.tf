terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
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

provider "azurerm" {
  features {}
}

provider "aws" {
  region = var.aws_region
}

locals {
  tags = merge(
    {
      environment = var.environment
      project     = "30-days-of-opentofu"
      day         = "30"
      cloud       = "multicloud"
    },
    var.common_tags
  )

  azure_web_app_name = "${var.azure_webapp_name_prefix}-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_resource_group" "tm" {
  name     = var.resource_group_name
  location = var.azure_location
  tags     = local.tags
}

resource "azurerm_service_plan" "app" {
  name                = "asp-day30-${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.tm.name
  location            = azurerm_resource_group.tm.location
  os_type             = "Linux"
  sku_name            = var.azure_app_service_sku
  tags                = local.tags
}

resource "azurerm_linux_web_app" "primary" {
  name                = local.azure_web_app_name
  resource_group_name = azurerm_resource_group.tm.name
  location            = azurerm_resource_group.tm.location
  service_plan_id     = azurerm_service_plan.app.id
  https_only          = false
  tags                = local.tags

  site_config {}
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default_vpc" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_security_group" "web" {
  name        = "day30-web-sg-${random_string.suffix.result}"
  description = "Day 30 EC2 web security group"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allowed_http_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}

resource "aws_instance" "secondary" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = var.aws_instance_type
  subnet_id                   = data.aws_subnets.default_vpc.ids[0]
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = true

  user_data = <<-EOT
    #!/bin/bash
    dnf -y update
    dnf -y install nginx
    systemctl enable nginx
    systemctl start nginx
    cat > /usr/share/nginx/html/index.html <<'EOF'
    <html>
    <body>
    <h1>Day 30: AWS Secondary Endpoint</h1>
    <p>Multi-cloud failover target from OpenTofu capstone.</p>
    </body>
    </html>
    EOF
  EOT

  tags = merge(
    local.tags,
    {
      Name = "day30-ec2-secondary"
    }
  )
}

resource "azurerm_traffic_manager_profile" "global" {
  name                   = var.traffic_manager_profile_name
  resource_group_name    = azurerm_resource_group.tm.name
  traffic_routing_method = "Priority"
  tags                   = local.tags

  dns_config {
    relative_name = "${var.traffic_manager_dns_prefix}-${random_string.suffix.result}"
    ttl           = 30
  }

  monitor_config {
    protocol = "HTTP"
    port     = 80
    path     = "/"
  }
}

resource "azurerm_traffic_manager_azure_endpoint" "azure_primary" {
  name               = "azure-primary"
  profile_id         = azurerm_traffic_manager_profile.global.id
  target_resource_id = azurerm_linux_web_app.primary.id
  priority           = 1
  weight             = 100
}

resource "azurerm_traffic_manager_external_endpoint" "aws_secondary" {
  name       = "aws-secondary"
  profile_id = azurerm_traffic_manager_profile.global.id
  target     = aws_instance.secondary.public_dns
  priority   = 2
  weight     = 100
}

resource "aws_route53_record" "traffic_manager_cname" {
  count = var.create_route53_record ? 1 : 0

  zone_id = var.route53_zone_id
  name    = var.route53_record_name
  type    = "CNAME"
  ttl     = 60
  records = [azurerm_traffic_manager_profile.global.fqdn]
}
