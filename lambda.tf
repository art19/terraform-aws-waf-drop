resource "aws_lambda_function" "waf" {
  s3_bucket     = "awswaf.us-east-1"
  s3_key        = "waf-reputation-lists/lambda.zip"

  role          = "${aws_iam_role.lambda.arn}"

  function_name = "${var.function_name}"
  description   = "Updates AWS WAF IPSets with the latest IPs from Spamhaus DROP and EDROP lists."
  handler       = "index.handler"

  memory_size   = 512
  timeout       = 60
}
