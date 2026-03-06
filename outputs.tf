output "group_id" {
  value       = datadog_sensitive_data_scanner_group.this.id
  description = "The ID of the Sensitive Data Scanner group."
}

output "rule_ids" {
  value       = { for k, v in datadog_sensitive_data_scanner_rule.rules : k => v.id }
  description = "A map of standard pattern names to rule IDs."
}

output "monitor_critical_id" {
  description = "The ID of the critical severity Sensitive Data Scanner monitor, or null if monitors are disabled."
  value       = var.enable_monitors ? datadog_monitor.sds_critical[0].id : null
}

output "monitor_high_id" {
  description = "The ID of the high severity (PII) Sensitive Data Scanner monitor, or null if monitors are disabled."
  value       = var.enable_monitors ? datadog_monitor.sds_high[0].id : null
}
