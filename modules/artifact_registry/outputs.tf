output "repository_id" {
  description = "ID of the created repository"
  value       = google_artifact_registry_repository.repo.repository_id
}

output "repository_url" {
  description = "URL of the created repository"
  value       = "${google_artifact_registry_repository.repo.location}-docker.pkg.dev/${google_artifact_registry_repository.repo.project}/${google_artifact_registry_repository.repo.repository_id}"
}