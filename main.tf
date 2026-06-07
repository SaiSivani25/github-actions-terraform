module "storage" {
  source      = "./modules/storage"
  bucket_name = var.bucket_name
  location    = "US"
}

module "artifact_registry" {
  source        = "./modules/artifact_registry"
  region        = var.region
  repository_id = "calculator-repo-ga"
}

module "cloud_run" {
  source       = "./modules/cloud_run"
  project_id   = var.project_id
  region       = var.region
  service_name = "calculator-app-ga"
  image        = "${var.region}-docker.pkg.dev/${var.project_id}/calculator-repo-ga/calculator:latest"
}