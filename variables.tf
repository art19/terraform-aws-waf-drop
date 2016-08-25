variable "function_name" {
  description = "The function name to assign to the Lambda function"
}

variable "schedule" {
  description = "When to run the Lambda function"
  default = "rate(8 hours)"
}

variable "waf_ipset_1_id" {
  description = "The ID of an IPSet to use with the Lambda function"
}

variable "waf_ipset_2_id" {
  description = "The ID of an IPSet to use with the Lambda function"
}
