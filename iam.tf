# Policy granting Lambda the ability to assume the role we're creating
data "iam_policy_document" "lambda-assume-role-policy" {
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
data "iam_policy_document" "lambda-role-policy" {
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
      "arn:aws:waf::${data.aws_caller_identity.current.account_id}:ipset/${var.waf_ipset_1_id}",
      "arn:aws:waf::${data.aws_caller_identity.current.account_id}:ipset/${var.waf_ipset_2_id}"
    ]
  }
}

resource "aws_iam_role" "lambda" {
  name_prefix        = "aws_waf_drop_updater_"
  assume_role_policy = "${data.iam_policy_document.lambda-assume-role-policy.json}"
}

resource "aws_iam_role_policy" "lambda" {
  name   = "aws_waf_drop_updater_lambda_policy"
  role   = "${aws_iam_role.lambda.arn}"
  policy = "${data.iam_policy_document.lambda-role-policy.json}"
}
