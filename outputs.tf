output "bucket_name" {
  description = "Name of the created bucket"
  value       = module.storage.bucket_name
}

output "bucket_url" {
  description = "URL of the created bucket"
  value       = module.storage.bucket_url
}

output "repository_url" {
  description = "URL of the Artifact Registry"
  value       = module.artifact_registry.repository_url
}

output "calculator_url" {
  description = "URL of the Calculator app"
  value       = module.cloud_run.service_url
}