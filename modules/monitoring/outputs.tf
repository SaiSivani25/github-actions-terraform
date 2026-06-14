output "notification_channel" {
  description = "Email notification channel name"
  value       = google_monitoring_notification_channel.email.name
}

output "uptime_check_id" {
  description = "Uptime check ID"
  value       = google_monitoring_uptime_check_config.http.uptime_check_id
}

output "alert_policy_name" {
  description = "Alert policy name"
  value       = google_monitoring_alert_policy.uptime_alert.name
}