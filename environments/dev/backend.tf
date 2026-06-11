terraform {
  backend "gcs" {
    bucket = "hr-management-terraform-state"
    prefix = "environments/dev/state"
  }
}