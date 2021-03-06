# Policy granting Lambda the ability to assume the role we're creating
data "aws_iam_policy_document" "lambda-assume-role-policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# Policy attached to the IAM role we're creating
data "aws_iam_policy_document" "lambda-role-policy" {
  # Permit the Lambda function to write to CloudWatch Logs
  statement {
    sid       = "AllowCloudWatchLogs"
    effect    = "Allow"
    actions   = ["logs:*"]
    resources = ["*"]
  }

  # Permit the Lambda function to get a WAF change token
  statement {
    sid       = "AllowWAFGetChangeToken"
    effect    = "Allow"
    actions   = ["waf:GetChangeToken"]
    resources = ["*"]
  }

  # Permit the Lambda function to update IP sets
  statement {
    sid       = "AllowGetUpdateWAFIPSet"
    effect    = "Allow"
    actions   = ["waf:GetIPSet", "waf:UpdateIPSet"]
    resources = [
      "arn:aws:waf::${data.aws_caller_identity.current.account_id}:ipset/${aws_cloudformation_stack.waf-ipsets-and-rules.outputs["WAFIPSet1"]}",
      "arn:aws:waf::${data.aws_caller_identity.current.account_id}:ipset/${aws_cloudformation_stack.waf-ipsets-and-rules.outputs["WAFIPSet2"]}"
    ]
  }
}

resource "aws_iam_role" "lambda" {
  provider = "aws.terraform-aws-waf-drop"

  name_prefix        = "aws_waf_drop_updater_"
  assume_role_policy = "${data.aws_iam_policy_document.lambda-assume-role-policy.json}"
}

resource "aws_iam_role_policy" "lambda" {
  provider = "aws.terraform-aws-waf-drop"

  name   = "aws_waf_drop_updater_lambda_policy"
  role   = "${aws_iam_role.lambda.id}"
  policy = "${data.aws_iam_policy_document.lambda-role-policy.json}"
}
