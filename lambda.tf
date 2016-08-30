resource "aws_lambda_function" "waf" {
  s3_bucket     = "${var.lambda_function_bucket}"
  s3_key        = "${var.lambda_function_key}"

  role          = "${aws_iam_role.lambda.arn}"

  function_name = "${lower(replace(var.name, "-", "_"))}_update_waf_drop_list"
  description   = "Updates AWS WAF IPSets with the latest IPs from Spamhaus DROP and EDROP lists."
  handler       = "index.handler"

  memory_size   = 512
  timeout       = 60
}
