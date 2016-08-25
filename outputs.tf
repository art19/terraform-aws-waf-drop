output "waf_ipset_1_id" {
  value = "${aws_cloudformation_stack.waf-ipsets-and-rules.outputs.WAFIPSet1}"
}

output "waf_ipset_2_id" {
  value = "${aws_cloudformation_stack.waf-ipsets-and-rules.outputs.WAFIPSet2}"
}

output "waf_rule_1_id" {
  value = "${aws_cloudformation_stack.waf-ipsets-and-rules.outputs.WAFRule1}"
}

output "waf_rule_2_id" {
  value = "${aws_cloudformation_stack.waf-ipsets-and-rules.outputs.WAFRule2}"
}
