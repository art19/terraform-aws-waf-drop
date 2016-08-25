# terraform-aws-waf-drop

Terraform module that keeps AWS WAF IP sets up to date with the latest IPs from Spamhaus's DROP and EDROP lists.

This module utilizes the [Reputation Lists AWS WAF sample](https://github.com/awslabs/aws-waf-sample/tree/master/waf-reputation-lists) Lambda function.

## Notes

At the time of this writing, Terraform doesn't support AWS WAF, so you'll need to create some resources on the command line. Additionally, because AWS WAF has a limit on the number of IPs that can be in an IPSet, you need to provide more than one IPSet (which means you need more than one rule).

Also, we run everything in `us-east-1`. PRs welcome if this is something you want to change.

## Configuration

* `function_name`: The function name to assign to the Lambda function
* `schedule` (default `rate(8 hours)`): When to run the Lambda function
* `waf_ipset_1_id`: The ID of an IPSet to use with the Lambda function
* `waf_ipset_2_id`: The ID of an IPSet to use with the Lambda function
