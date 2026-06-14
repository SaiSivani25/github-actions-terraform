variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "service_name" {
  description = "Cloud Run service name to monitor"
  type        = string
}

variable "alert_email" {
  description = "Email address for alerts"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}