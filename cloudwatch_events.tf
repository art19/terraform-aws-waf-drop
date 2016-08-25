# Create a rule that is triggered on a schedule
resource "aws_cloudwatch_event_rule" "waf" {
  name                = "execute_${lower(replace(var.name, "-", "_"))}_update_waf_drop_list"
  description         = "Executes the ${lower(replace(var.name, "-", "_"))}_update_waf_drop_list Lambda function on a schedule to update WAF reputation lists. Updated by Terraform."
  schedule_expression = "${var.schedule}"
}

# Make the Lambda function the target of the CloudWatch event rule
resource "aws_cloudwatch_event_target" "lambda" {
  rule = "${aws_cloudwatch_event_rule.waf.name}"
  arn  = "${aws_lambda_function.waf.arn}"

  input = <<EOF
{
  "lists": [
    { "url": "https://www.spamhaus.org/drop/drop.txt" },
    { "url": "https://www.spamhaus.org/drop/edrop.txt" }
  ],
  "ipSetIds": [
    "${aws_cloudformation_stack.waf-ipsets-and-rules.outputs["WAFIPSet1"]}",
    "${aws_cloudformation_stack.waf-ipsets-and-rules.outputs["WAFIPSet2"]}"
  ]
}
EOF
}

# Grant CloudWatch Events the ability to execute the Lambda function.
resource "aws_lambda_permission" "cloudwatch-events" {
  statement_id  = "${lower(replace(var.name, "-", "_"))}_update_waf_drop_list_cwevents_invokefunction"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.waf.arn}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.waf.arn}"
}
