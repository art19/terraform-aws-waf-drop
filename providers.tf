provider "aws" {
  # Configuration comes from the environment for everything but region
  region = "us-east-1"
}

# Allow us to get the current account ID
data "aws_caller_identity" "current" {}
