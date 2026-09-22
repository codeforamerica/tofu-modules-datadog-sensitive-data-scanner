locals {
  # Stable Datadog standard pattern IDs, preferred over name lookups.
  #
  # The provider's `filter` argument is a case-insensitive substring match, so a
  # pattern whose name is contained in another pattern's name can't be selected
  # by name at all (e.g. "Bearer Token Scanner" also matches "Twitter Bearer
  # Token Scanner"). IDs are identical in every organization and survive Datadog
  # renaming a pattern.
  #
  # Names absent from this table still resolve by filter, so callers passing
  # patterns we don't know about keep working.
  #
  # Refresh with:
  #   GET /api/v2/sensitive-data-scanner/config/standard-patterns
  default_standard_pattern_ids = {
    "ABA Routing Transit Number Scanner"       = "SSd2bBTOrvB5j8ii6qT1XV"
    "AWS Access Key ID Scanner"                = "OfGqX8R9TRqAcorxenl2fQ"
    "AWS Secret Access Key Scanner"            = "iZeqWOvYThWJ7DWMwIQoRg"
    "Bearer Token Scanner"                     = "mZy8XjZLReC9smpERXWnnw"
    "Datadog API Key Scanner"                  = "Pus1fLRQXer1olidwu7Lvc"
    "Doppler Access Token Scanner"             = "A7pxoLSo5xyL5lv2DKY1vR"
    "Github Access Token Scanner"              = "5rjXkBMvQ3GbbYrpVP_HdQ"
    "Github Refresh Token Scanner"             = "OMuUuImtTFCzF-duF0HxDQ"
    "Google Client Secret Scanner"             = "ImRYNVtxWdgncOnAr9y5wG"
    "Heroku API Key Scanner"                   = "5W01LmhRSx6eTFEUxmUjCA"
    "Intercom Access Token Scanner"            = "4ZszOKHZ0qFQMczSUWwWU6"
    "JIRA API Token Scanner"                   = "70ZmrD75Q36PDbxaBVfT-A"
    "Mailgun API Key Scanner"                  = "bBJ6S21qTGyc3XL5ZV6-ag"
    "Mailgun API Key v2 Scanner"               = "VMiPXWxbOT1Tpynj95Ll6v"
    "Okta API Token Scanner"                   = "wUOrv44TR6ibU9Na3kplUw"
    "PagerDuty API Token Scanner"              = "H1jpmrcVDpWl6jnBLDDD6N"
    "PGP Private Key Scanner"                  = "7gPGTneLSaK9xCbvtRIP2Q"
    "RSA Private Key Scanner"                  = "hH0QoqerTWSDsqk2QLgQpg"
    "SendGrid API Key Scanner"                 = "la8TI0NQT9Gi-NnTjgHsnw"
    "Slack Access Token Scanner"               = "ozSqFSGnQaur3HfiS3BTaQ"
    "Slack Webhook Secret Scanner"             = "wE1yJHDMRfqK91asu9uvaw"
    "SSH Key Scanner"                          = "A0fNRj-TQ06KnRznwcQpdQ"
    "Standard Email Address Scanner"           = "PuXiVTCkTHOtj0Yad1ppsw"
    "Standard IBAN Code Scanner"               = "8VS2RKxzR8a_95L5fuwaXQ"
    "Stripe Secret API Key Scanner"            = "S0j4p-aLSMmV2Qd6q53_jA"
    "Twilio Access Token Scanner"              = "oBdSo1I6cC57hJkDOcV6mD"
    "Twilio API Key Scanner"                   = "cFGYTn4pTIiF7tUCCDhw4A"
    "Twilio API Secret Scanner"                = "UG5FYp26S9eY6wLilTAscC"
    "Twilio Auth Token Scanner"                = "ISo3JMCfnkfftIPXH749qu"
    "US Passport Scanner"                      = "d962f7ddb3f55041e39195a60ff79d4814a7c331"
    "US Social Security Number Scanner"        = "PIIXqwUljp4BaqIHDBBLNn"
    "US Vehicle Identification Number Scanner" = "ac6d683cbac77f6e399a14990793dd8fd0fca333"
  }

  standard_pattern_ids = merge(
    local.default_standard_pattern_ids,
    var.standard_pattern_ids,
  )

  # Pattern name => stable ID, or null when the name must be resolved by filter.
  resolved_patterns = {
    for name in toset(var.standard_patterns) :
    name => lookup(local.standard_pattern_ids, name, null)
  }
}
