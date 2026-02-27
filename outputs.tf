output "group_id" {
  value       = datadog_sensitive_data_scanner_group.this.id
  description = "The ID of the Sensitive Data Scanner group."
}

output "rule_ids" {
  value       = { for k, v in datadog_sensitive_data_scanner_rule.rules : k => v.id }
  description = "A map of standard pattern names to rule IDs."
}
