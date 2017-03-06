resource "aws_waf_ipset" "WAFIPSet1" {
  name = "WAFIPSet1"
  ip_set_descriptors {
    type = "IPV4"
    value = "10.10.10.10/32"
  }
}

resource "aws_waf_ipset" "WAFIPSet2" {
  name = "WAFIPSet2"
  ip_set_descriptors {
    type = "IPV4"
    value = "10.10.10.10/32"
  }
}

resource "aws_waf_rule" "WAFRule1" {
  depends_on = ["aws_waf_ipset.WAFIPSet1"]
  name = "WAFRule1"
  metric_name = "WAFRule1"
  predicates {
    data_id = "${aws_waf_ipset.WAFIPSet1.id}"
    negated = false
    type = "IPMatch"
  }
}

resource "aws_waf_rule" "WAFRule2" {
  depends_on = ["aws_waf_ipset.WAFIPSet2"]
  name = "WAFRule2"
  metric_name = "WAFRule2"
  predicates {
    data_id = "${aws_waf_ipset.WAFIPSet2.id}"
    negated = false
    type = "IPMatch"
  }
}
