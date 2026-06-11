terraform {
  backend "gcs" {
    bucket = "hr-management-terraform-state"
    prefix = "environments/stage/state"
  }
}