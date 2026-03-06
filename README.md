# Datadog Sensitive Data Scanner Module

[![GitHub Release][badge-release]][latest-release]

This module creates a configurable Sensitive Data Scanner group in Datadog for monitoring log data.

## Usage

Add this module to your `main.tf` (or appropriate) file and configure the inputs
to match your desired configuration. For example:

```hcl
module "sensitive_data_scanner" {
  source = "github.com/codeforamerica/tofu-modules-datadog-sensitive-data-scanner?ref=v1.0.0"

  group_name   = "Production Logs Scanning"
  filter_query = "env:production"
  product_list = ["logs", "apm"]
}
```

Make sure you re-run `tofu init` after adding the module to your configuration.

```bash
tofu init
tofu plan
```

To update the source for this module, pass `-upgrade` to `tofu init`:

```bash
tofu init -upgrade
```

## Inputs

| Name                                  | Description                                                                                                   | Type           | Default                    | Required |
|---------------------------------------|---------------------------------------------------------------------------------------------------------------|----------------|----------------------------|----------|
| `credentials_monitor_excluded_tags`   | Tags to exclude from the credentials monitor query (e.g., `["env:dev"]`). Each entry is negated in the query. | `list(string)` | `[]`                       | no       |
| `enable_monitors`                     | Whether to create Datadog monitors for Sensitive Data Scanner findings.                                       | `bool`         | `false`                    | no       |
| `filter_query`                        | The filter query to determine which logs/spans/events are scanned.                                            | `string`       | `"*"`                      | no       |
| `group_description`                   | The description of the Sensitive Data Scanner group.                                                          | `string`       | `"Managed by OpenTofu"`    | no       |
| `group_name`                          | The name of the Sensitive Data Scanner group.                                                                 | `string`       | `"Default Scanning Group"` | no       |
| `is_enabled`                          | Whether the scanning group is enabled.                                                                        | `bool`         | `true`                     | no       |
| `monitor_evaluation_window`           | Time window for monitor query evaluation. Valid values: `5m`, `10m`, `15m`, `30m`, `1h`, `2h`, `4h`, `1d`.    | `string`       | `"1d"`                     | no       |
| `monitor_renotify_interval`           | Minutes between re-notifications when a monitor stays in alert state. Set to `0` to disable re-notification.  | `number`       | `1440`                     | no       |
| `notification_targets`                | List of notification targets for monitors (e.g., `"@slack-channel"`, `"@pagerduty-service"`).                 | `list(string)` | `[]`                       | no       |
| `pii_monitor_excluded_tags`           | Tags to exclude from the PII monitor query (e.g., `["env:dev"]`). Each entry is negated in the query.         | `list(string)` | `[]`                       | no       |
| `product_list`                        | List of products to scan (e.g., logs, apm, rum).                                                              | `list(string)` | `["logs", "apm"]`          | no       |
| `product_samplings`                   | Map of product to sampling rate (0 to 100).                                                                   | `map(number)`  | `{}`                       | no       |
| `redaction_replacement_string`        | The string to use for redaction if type is replacement_string.                                                | `string`       | `"[REDACTED]"`             | no       |
| `standard_patterns`                   | List of standard Scanning Rules Library rules to enable.                                                      | `list(string)` | `[...]`                    | no       |

## Outputs

| Name                  | Description                                                                             | Type          |
|-----------------------|-----------------------------------------------------------------------------------------|---------------|
| `group_id`            | The ID of the Sensitive Data Scanner group.                                             | `string`      |
| `monitor_critical_id` | The ID of the critical severity Sensitive Data Scanner monitor, or `null` if disabled.  | `string`      |
| `monitor_high_id`     | The ID of the high severity (PII) Sensitive Data Scanner monitor, or `null` if disabled.| `string`      |
| `rule_ids`            | A map of standard pattern names to rule IDs.                                            | `map(string)` |

## Contributing

## Development setup

This repository uses [pre-commit](https://pre-commit.com) to enforce code
style checks before each commit. Install it once after cloning:

**1. Install pre-commit**

```sh
brew install pre-commit
```

**2. Install the git hook**

```sh
pre-commit install
```

This symlinks the hook into `.git/hooks/pre-commit`. The checks will now run
automatically on every `git commit`. To run them manually against all files:

```sh
pre-commit run --all-files
```

Follow the [contributing guidelines][contributing] to contribute to this
repository.

[badge-release]: https://img.shields.io/github/v/release/codeforamerica/tofu-modules-datadog-sensitive-data-scanner?logo=github&label=Latest%20Release
[contributing]: CONTRIBUTING.md
[latest-release]: https://github.com/codeforamerica/tofu-modules-datadog-sensitive-data-scanner/releases/latest
[tofu-modules]: https://github.com/codeforamerica/tofu-modules
