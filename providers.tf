provider "aws" {
  # Configuration comes from the environment for everything but region
  region = "us-east-1"
  alias = "terraform-aws-waf-drop" # so we don't conflict with the user's provider
}

# Allow us to get the current account ID
data "aws_caller_identity" "current" {
  provider = "aws.terraform-aws-waf-drop"
}
