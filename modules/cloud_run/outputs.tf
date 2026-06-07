output "service_url" {
  description = "URL of the Cloud Run service"
  value       = google_cloud_run_v2_service.calculator.uri
}

output "service_name" {
  description = "Name of the Cloud Run service"
  value       = google_cloud_run_v2_service.calculator.name
}
