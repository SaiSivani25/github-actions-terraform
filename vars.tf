variable "project_id" {
  default     = "hr-management-2025"
  description = "GCP Project ID"
}

variable "region" {
  default     = "us-central1"
  description = "GCP Region"
}

variable "bucket_name" {
  default     = "hr-automation-terraform-bucket-002"
  description = "Name of the GCS bucket"
}