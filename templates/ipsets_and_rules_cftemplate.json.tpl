{
  "Resources": {
    "WAFIPSet1": {
      "Type": "AWS::WAF::IPSet",
      "Properties": {
        "Name": "${name} DROP/EDROP IP List 1"
      }
    },
    "WAFIPSet2": {
      "Type": "AWS::WAF::IPSet",
      "Properties": {
        "Name": "${name} DROP/EDROP IP List 2"
      }
    },
    "WAFRule1": {
      "Type": "AWS::WAF::Rule",
      "Properties": {
        "Name": "${name} DROP/EDROP Rule 1",
        "MetricName": "${metric_name}DropRule1",
        "Predicates": [
          { "DataId": { "Ref": "WAFIPSet1" }, "Type": "IPMatch", "Negated": "false" }
        ]
      }
    },
    "WAFRule2": {
      "Type": "AWS::WAF::Rule",
      "Properties": {
        "Name": "${name} DROP/EDROP Rule 2",
        "MetricName": "${metric_name}DropRule2",
        "Predicates": [
          { "DataId": { "Ref": "WAFIPSet2" }, "Type": "IPMatch", "Negated": "false" }
        ]
      }
    }
  },
  "Outputs": {
    "WAFIPSet1": {
      "Description": "ID of the IPSet we created",
      "Value": { "Ref": "WAFIPSet1" }
    },
    "WAFIPSet2": {
      "Description": "ID of the IPSet we created",
      "Value": { "Ref": "WAFIPSet2" }
    },
    "WAFRule1": {
      "Description": "ID of the Rule we created",
      "Value": { "Ref": "WAFRule1" }
    },
    "WAFRule2": {
      "Description": "ID of the Rule we created",
      "Value": { "Ref": "WAFRule2" }
    }
  }
}
