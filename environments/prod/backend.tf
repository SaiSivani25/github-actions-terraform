terraform {
  backend "gcs" {
    bucket = "hr-management-terraform-state"
    prefix = "environments/prod/state"
  }
}