# Create a rule that is triggered on a schedule
resource "aws_cloudwatch_event_rule" "waf" {
  name                = "execute_${var.function_name}"
  description         = "Executes the ${var.function_name} Lambda function on a schedule to update WAF reputation lists. Updated by Terraform."
  schedule_expression = "${var.schedule}"
}

# Make the Lambda function the target of the CloudWatch event rule
resource "aws_cloudwatch_event_target" "lambda" {
  rule = "${aws_cloudwatch_event_rule.waf.arn}"
  arn  = "${aws_lambda_function.waf.arn}"

  input = <<EOF
{
  "lists": [
    { "url": "https://www.spamhaus.org/drop/drop.txt" },
    { "url": "https://www.spamhaus.org/drop/edrop.txt" }
  ],
  "ipSetIds": ["${var.waf_ipset_1_id}", "${var.waf_ipset_2_id}"]
}
EOF
}

# Grant CloudWatch Events the ability to execute the Lambda function.
resource "aws_lambda_permission" "cloudwatch-events" {
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.waf.arn}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.waf.arn}"
}
