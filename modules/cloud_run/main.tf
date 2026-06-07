resource "google_cloud_run_v2_service" "calculator" {
  name     = var.service_name
  location = var.region

  template {
    containers {
      image = var.image
    }
  }
}

resource "google_cloud_run_v2_service_iam_member" "public" {
  project  = var.project_id
  location = var.region
  name     = google_cloud_run_v2_service.calculator.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}