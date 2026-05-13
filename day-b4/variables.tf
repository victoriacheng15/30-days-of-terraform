variable "filename" {
  type        = string
  default     = "drift_test.txt"
  description = "The name of the file to manage"
}

variable "desired_content" {
  type        = string
  default     = "This is the authorized content managed by OpenTofu."
  description = "The content that should be in the file"
}
