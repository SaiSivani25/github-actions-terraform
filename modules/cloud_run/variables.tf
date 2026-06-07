variable "service_name" {
  description = "Name of the Cloud Run service"
  type        = string
}

variable "region" {
  description = "Region for Cloud Run"
  type        = string
}

variable "image" {
  description = "Docker image URL"
  type        = string
}

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}