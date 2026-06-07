# Storage Bucket
resource "google_storage_bucket" "my_bucket" {
  name     = var.bucket_name
  location = "US"
}

# Artifact Registry
resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = "calculator-repo-ga"
  format        = "DOCKER"
}

# Cloud Run
resource "google_cloud_run_v2_service" "calculator" {
  name     = "calculator-app-ga"
  location = var.region

  template {
    containers {
      image = "${var.region}-docker.pkg.dev/${var.project_id}/calculator-repo-ga/calculator:latest"
    }
  }
}

# Make Cloud Run public
resource "google_cloud_run_v2_service_iam_member" "public" {
  project  = var.project_id
  location = var.region
  name     = google_cloud_run_v2_service.calculator.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}