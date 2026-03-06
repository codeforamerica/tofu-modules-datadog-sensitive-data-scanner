locals {
  credentials_query_filter = join(" ", concat(
    ["sensitive_data:true sensitive_data_category:credentials"],
    [for tag in var.credentials_monitor_excluded_tags : "-${tag}"]
  ))
  pii_query_filter = join(" ", concat(
    ["sensitive_data:true sensitive_data_category:pii"],
    [for tag in var.pii_monitor_excluded_tags : "-${tag}"]
  ))
}

resource "datadog_monitor" "sds_critical" {
  count = var.enable_monitors ? 1 : 0

  name    = "${var.group_name}: Critical Sensitive Data Detected (Credentials)"
  type    = "log alert"
  message = <<-EOT
    Sensitive Data Scanner detected credentials or secrets in logs.

    Group: ${var.group_name}
    Category: credentials/secrets/keys

    Investigate immediately to prevent unauthorized access.

    ${join("\n", var.notification_targets)}
  EOT

  query = "logs(\"${local.credentials_query_filter}\").index(\"*\").rollup(\"count\").by(\"@service\").last(\"${var.monitor_evaluation_window}\") > 0"

  monitor_thresholds {
    critical = 0
  }

  priority          = 1
  notify_no_data    = false
  include_tags      = true
  renotify_interval = var.monitor_renotify_interval

  tags = [
    "managed_by:opentofu",
    "module:sensitive-data-scanner",
    "sds_group:${var.group_name}",
    "sensitive_data_category:credentials",
  ]
}

resource "datadog_monitor" "sds_high" {
  count = var.enable_monitors ? 1 : 0

  name    = "${var.group_name}: High Severity Sensitive Data Detected (PII)"
  type    = "log alert"
  message = <<-EOT
    Sensitive Data Scanner detected PII (Personally Identifiable Information) in logs.

    Group: ${var.group_name}
    Category: pii

    Review findings and ensure compliance with data privacy policies.

    ${join("\n", var.notification_targets)}
  EOT

  query = "logs(\"${local.pii_query_filter}\").index(\"*\").rollup(\"count\").by(\"@service\").last(\"${var.monitor_evaluation_window}\") > 0"

  monitor_thresholds {
    critical = 0
  }

  priority          = 2
  notify_no_data    = false
  include_tags      = true
  renotify_interval = var.monitor_renotify_interval

  tags = [
    "managed_by:opentofu",
    "module:sensitive-data-scanner",
    "sds_group:${var.group_name}",
    "sensitive_data_category:pii",
  ]
}
