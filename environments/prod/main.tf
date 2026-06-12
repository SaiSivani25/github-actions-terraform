provider "google" {
  project = var.project_id
  region  = var.region
}

module "artifact_registry" {
  source        = "../../modules/artifact_registry"
  region        = var.region
  repository_id = "calculator-repo-${var.environment}"
}

module "cloud_run" {
  source              = "../../modules/cloud_run"
  project_id          = var.project_id
  region              = var.region
  service_name        = "calculator-app-${var.environment}"
  image               = "${var.region}-docker.pkg.dev/${var.project_id}/calculator-repo-${var.environment}/calculator:latest"
  deletion_protection = true
  environment        = var.environment
}