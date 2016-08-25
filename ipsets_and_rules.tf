# Get the CloudFormation stack template by building a Terraform template. #someta
data "template_file" "waf-ipsets-and-rules" {
  template = "${file("${path.module}/templates/ipsets_and_rules_cftemplate.json.tpl")}"

  variables {
    name = "${var.name}"
    metric_name = "${replace(var.name, "/[^A-Za-z0-9]/", "")}"
  }
}

# Create IPSets and rules. Since Terraform does not support WAF right now, do this via CloudFormation.
resource "aws_cloudformation_stack" "waf-ipsets-and-rules" {
  name = "${var.name}-waf-drop-ipsets-and-rules"
  template_body = "${data.template_file.waf-ipsets-and-rules.rendered}"

  tags {
    Name = "${var.name}-waf-drop-ipsets-and-rules"
  }
}
