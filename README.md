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

| Name                           | Description                                                                    | Type           | Default                    | Required |
|--------------------------------|--------------------------------------------------------------------------------|----------------|----------------------------|----------|
| `group_name`                   | The name of the Sensitive Data Scanner group.                                  | `string`       | `"Default Scanning Group"` | no       |
| `group_description`            | The description of the Sensitive Data Scanner group.                           | `string`       | `"Managed by OpenTofu"`    | no       |
| `filter_query`                 | The filter query to determine which logs/spans/events are scanned.             | `string`       | `"*"`                      | no       |
| `product_list`                 | List of products to scan (e.g., logs, apm, rum).                               | `list(string)` | `["logs", "apm"]`          | no       |
| `product_samplings`            | Map of product to sampling rate (0 to 100).                                    | `map(number)`  | `{}`                       | no       |
| `is_enabled`                   | Whether the scanning group is enabled.                                         | `bool`         | `true`                     | no       |
| `standard_patterns`            | List of standard Scanning Rules Library rules to enable.                       | `list(string)` | `[...]`                    | no       |
| `redaction_replacement_string` | The string to use for redaction if type is replacement_string.                 | `string`       | `"[REDACTED]"`             | no       |

## Outputs

| Name       | Description                                    | Type          |
|------------|------------------------------------------------|---------------|
| `group_id` | The ID of the Sensitive Data Scanner group.    | `string`      |
| `rule_ids` | A map of standard pattern names to rule IDs.   | `map(string)` |

## Contributing

Follow the [contributing guidelines][contributing] to contribute to this
repository.

[badge-release]: https://img.shields.io/github/v/release/codeforamerica/tofu-modules-datadog-sensitive-data-scanner?logo=github&label=Latest%20Release
[contributing]: CONTRIBUTING.md
[latest-release]: https://github.com/codeforamerica/tofu-modules-datadog-sensitive-data-scanner/releases/latest
[tofu-modules]: https://github.com/codeforamerica/tofu-modules
