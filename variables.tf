variable "credentials_monitor_excluded_tags" {
  type        = list(string)
  description = <<-EOT
    Tags to exclude from the credentials monitor query. Each entry is negated and
    appended to the base query. Useful for suppressing noisy but expected findings.

    Examples:
      ["env:dev"]
      ["@sensitive_data.matches.rule_name:Bearer Token Scanner", "env:staging"]
  EOT
  default     = []
}

variable "enable_monitors" {
  type        = bool
  description = "Whether to create Datadog monitors for Sensitive Data Scanner findings."
  default     = false
}

variable "filter_query" {
  type        = string
  description = "The filter query to determine which logs/spans/events are scanned."
  default     = "*"
}

variable "group_description" {
  type        = string
  description = "The description of the Sensitive Data Scanner group."
  default     = "Managed by OpenTofu"
}

variable "group_name" {
  type        = string
  description = "The name of the Sensitive Data Scanner group."
  default     = "Default Scanning Group"
}

variable "is_enabled" {
  type        = bool
  description = "Whether the scanning group is enabled."
  default     = true
}

variable "monitor_evaluation_window" {
  type        = string
  description = "The time window for monitor query evaluation. Valid values: 5m, 10m, 15m, 30m, 1h, 2h, 4h, 1d."
  default     = "1d"
}

variable "monitor_renotify_interval" {
  type        = number
  description = "Minutes between re-notifications when a monitor stays in alert state. Defaults to 1440 (once per day). Set to 0 to disable re-notification."
  default     = 1440
}

variable "notification_targets" {
  type        = list(string)
  description = "List of notification targets for monitors (e.g., \"@slack-channel\", \"@pagerduty-service\")."
  default     = []
}

variable "pii_monitor_excluded_tags" {
  type        = list(string)
  description = <<-EOT
    Tags to exclude from the PII monitor query. Each entry is negated and
    appended to the base query.

    Examples:
      ["env:dev"]
      ["service:analytics-pipeline"]
  EOT
  default     = []
}

variable "product_list" {
  type        = list(string)
  description = "List of products to scan (e.g., logs, apm, rum)."
  default     = ["logs", "apm"]
}

variable "product_samplings" {
  type        = map(number)
  description = "Map of product to sampling rate (0 to 100). Defaults to 100 for each product in product_list if not specified."
  default     = {}
}

variable "redaction_replacement_string" {
  type        = string
  description = "The string to use for redaction if type is replacement_string."
  default     = "[REDACTED]"
}

variable "standard_patterns" {
  type        = list(string)
  description = "List of standard Scanning Rules Library rules to enable. See https://app.datadoghq.com/sensitive-data-scanner/configuration/telemetry/library"
  default     = [
      "Standard Email Address Scanner",
      "US Passport Scanner",
      "US Social Security Number Scanner",
      "US Vehicle Identification Number Scanner",
      "ABA Routing Transit Number Scanner",
      "Standard IBAN Code Scanner",
      "AWS Access Key ID Scanner",
      "AWS Secret Access Key Scanner",
      "Bearer Token Scanner",
      "Datadog API Key Scanner",
      "Doppler Access Token Scanner",
      "Github Access Token Scanner",
      "Github Refresh Token Scanner",
      "Google Client Secret Scanner",
      "Heroku API Key Scanner",
      "Intercom Access Token Scanner",
      "JIRA API Token Scanner",
      "Mailgun API Key Scanner",
      "Mailgun API Key v2 Scanner",
      "Okta API Token Scanner",
      "PagerDuty API Token Scanner",
      "PGP Private Key Scanner",
      "RSA Private Key Scanner",
      "SendGrid API Key Scanner",
      "Slack Access Token Scanner",
      "Slack Webhook Secret Scanner",
      "SSH Key Scanner",
      "Stripe Secret API Key Scanner",
      "Twilio Access Token Scanner",
      "Twilio API Key Scanner",
      "Twilio API Key Scanner",
      "Twilio API Secret Scanner",
      "Twilio Auth Token Scanner"
  ]
}
