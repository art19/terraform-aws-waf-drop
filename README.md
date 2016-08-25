# terraform-aws-waf-drop

Terraform module that keeps AWS WAF IP sets up to date with the latest IPs from Spamhaus's DROP and EDROP lists.

This module utilizes the [Reputation Lists AWS WAF sample](https://github.com/awslabs/aws-waf-sample/tree/master/waf-reputation-lists) Lambda function.

## Notes

At the time of this writing, Terraform doesn't support AWS WAF, so we use CloudFormation to create the WAF IPSets and Rules. Since WAF has a limit on the number of IPs that can be in an IPSet, and Rules don't support `OR`ing predicates together, we have to create more than one IPSet and more than one Rule. There is a cost associated with creating rules.

Also, we run everything in `us-east-1`. PRs welcome if this is something you want to change.

## Resources Created

* CloudFormation template
* CloudWatch Events rule
* CloudWatch Events target
* Lambda function
* IAM policy
* IAM role
* WAF IP set
* WAF rule

## Configuration

* `name`: A unique name for this instance of this module. [A-Za-z0-9-_] only please. Example: Staging-API
* `schedule` (default `rate(8 hours)`): When to run the Lambda function

## Outputs

* `waf_ipset_1_id`: The ID of the IPSet we create.
* `waf_ipset_2_id`: The ID of the IPSet we create.
* `waf_rule_1_id`: The ID of the Rule we create.
* `waf_rule_2_id`: The ID of the Rule we create.
