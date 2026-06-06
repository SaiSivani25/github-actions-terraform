terraform {
  backend "gcs" {
    bucket = "hr-management-terraform-state"
    prefix = "github-actions/state"
  }
}