provider "google" {
  project = var.project_id
  region  = var.region
}

# Read email from Secret Manager
data "google_secret_manager_secret_version" "alert_email" {
  secret  = "alert-email"
  project = var.project_id
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
  deletion_protection = false
  environment         = var.environment
}

module "monitoring" {
  source       = "../../modules/monitoring"
  project_id   = var.project_id
  region       = var.region
  service_name = "calculator-app-${var.environment}"
  alert_email  = data.google_secret_manager_secret_version.alert_email.secret_data
  environment  = var.environment
  cloud_run_url = module.cloud_run.service_url
}