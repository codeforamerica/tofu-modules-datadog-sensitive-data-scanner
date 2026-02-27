resource "datadog_sensitive_data_scanner_group" "this" {
  name        = var.group_name
  description = var.group_description
  is_enabled   = var.is_enabled
  product_list = var.product_list

  filter {
    query = var.filter_query
  }

  dynamic "samplings" {
    for_each = var.product_list
    content {
      product = samplings.value
      rate    = lookup(var.product_samplings, samplings.value, 100)
    }
  }
}

data "datadog_sensitive_data_scanner_standard_pattern" "patterns" {
  for_each = toset(var.standard_patterns)
  filter   = each.value
}

resource "datadog_sensitive_data_scanner_rule" "rules" {
  for_each = data.datadog_sensitive_data_scanner_standard_pattern.patterns

  name                = each.key
  description         = "Redaction rule for ${each.key}"
  group_id            = datadog_sensitive_data_scanner_group.this.id
  standard_pattern_id = each.value.id
  is_enabled          = true

  text_replacement {
    type               = "replacement_string"
    replacement_string = var.redaction_replacement_string
  }

  lifecycle {
    # Use this meta-argument to avoid disabling the group when modifying the
    # `included_keyword_configuration` field
    create_before_destroy = true
  }
}
