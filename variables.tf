variable "lambda_function_bucket" {
  description = "The bucket to find the Lambda deployment package in"
  default = "awswaf.us-east-1"
}

variable "lambda_function_key" {
  description = "The bucket key to find the Lambda deployment package in"
  default = "waf-reputation-lists/lambda.zip"
}

variable "name" {
  description = "A unique name for this instance of this module. [A-Za-z0-9-_] only please. Example: Staging-API"
}

variable "max_descriptors_per_ip_set" {
  description = "The maximum number of descriptors per IP set (if the Lambda function supports changing this value)"
  default = 1000
}

variable "max_descriptors_per_ip_set_update" {
  description = "The maximum number of descriptors per IP set update (if the Lambda function supports changing this value)"
  default = 1000
}

variable "schedule" {
  description = "When to run the Lambda function"
  default = "rate(8 hours)"
}
