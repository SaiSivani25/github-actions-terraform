# Notification channel - email
resource "google_monitoring_notification_channel" "email" {
  display_name = "Email Alerts - ${var.environment}"
  type         = "email"
  project      = var.project_id

  labels = {
    email_address = var.alert_email
  }
}

# Uptime check
resource "google_monitoring_uptime_check_config" "http" {
  display_name = "Uptime Check - ${var.service_name}"
  timeout      = "10s"
  period       = "300s"
  project      = var.project_id

  http_check {
    path         = "/"
    port         = 443
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = var.project_id
      host       = trimprefix(var.cloud_run_url, "https://")
    }
  }
}

# Alert policy
resource "google_monitoring_alert_policy" "uptime_alert" {
  display_name = "Uptime Alert - ${var.service_name}"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "Uptime check failed"
    condition_threshold {
      filter          = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" AND resource.type=\"uptime_url\" AND metric.label.check_id=\"${google_monitoring_uptime_check_config.http.uptime_check_id}\""
      duration        = "60s"
      comparison      = "COMPARISON_LT"
      threshold_value = 1
      aggregations {
        alignment_period     = "300s"
        per_series_aligner   = "ALIGN_NEXT_OLDER"
        cross_series_reducer = "REDUCE_COUNT_FALSE"
        group_by_fields      = ["resource.label.host"]
      }
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.email.name
  ]

  alert_strategy {
    auto_close = "1800s"
  }
}