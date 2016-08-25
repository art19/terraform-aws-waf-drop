{
  "Resources": {
    "waf-ipset-1": {
      "Type": "AWS::WAF::IPSet",
      "Properties": {
        "Name": "${name} DROP/EDROP IP List 1"
      }
    },
    "waf-ipset-2": {
      "Type": "AWS::WAF::IPSet",
      "Properties": {
        "Name": "${name} DROP/EDROP IP List 2"
      }
    },
    "waf-rule-1": {
      "Type": "AWS::WAF::Rule",
      "Properties": {
        "Name": "${name} DROP/EDROP Rule 1",
        "MetricName": "${metric_name}DropRule1",
        "Predicates": [
          { "DataId": { "Ref": "waf-ipset-1" }, "Type": "IPMatch", "Negated": "false" }
        ]
      }
    },
    "waf-rule-2": {
      "Type": "AWS::WAF::Rule",
      "Properties": {
        "Name": "${name} DROP/EDROP Rule 2",
        "MetricName": "${metric_name}DropRule2",
        "Predicates": [
          { "DataId": { "Ref": "waf-ipset-2" }, "Type": "IPMatch", "Negated": "false" }
        ]
      }
    }
  },
  "Outputs": {
    "WAFIPSet1": {
      "Description": "ID of the IPSet we created",
      "Value": { "Ref": "waf-ipset-1" }
    },
    "WAFIPSet2": {
      "Description": "ID of the IPSet we created",
      "Value": { "Ref": "waf-ipset-2" }
    },
    "WAFRule1": {
      "Description": "ID of the Rule we created",
      "Value": { "Ref": "waf-rule-1" }
    },
    "WAFRule2": {
      "Description": "ID of the Rule we created",
      "Value": { "Ref": "waf-rule-2" }
    }
  }
}
