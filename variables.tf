variable "name" {
  description = "A unique name for this instance of this module. [A-Za-z0-9-_] only please. Example: Staging-API"
}

variable "schedule" {
  description = "When to run the Lambda function"
  default = "rate(8 hours)"
}
