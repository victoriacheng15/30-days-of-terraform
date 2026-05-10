variable "lab_name" {
  description = "A simple value stored in the null resource triggers map."
  type        = string
  default     = "day-b1-state-and-providers-change-this"
}

variable "environment" {
  description = "The environment label for the lab."
  type        = string
  default     = "Dev"
}
