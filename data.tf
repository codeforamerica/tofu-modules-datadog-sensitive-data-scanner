data "datadog_sensitive_data_scanner_standard_pattern" "patterns" {
  for_each = local.resolved_patterns

  # Prefer the stable ID when known. Exactly one of these may be set, and
  # OpenTofu omits null attributes from the provider config, so the unused
  # argument is absent rather than empty.
  standard_pattern_id = each.value
  filter              = each.value == null ? each.key : null
}
