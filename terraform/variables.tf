
variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "gcp_region_1" {
  type        = string
  description = "GCP Region"
}

# define GCP zone
variable "gcp_zone_1" {
  type        = string
  description = "GCP Zone"
}

variable "app_name" {
  type        = string
  description = "Application Name"
}

variable "external_image" {
  type        = string
  description = "External Image ID"
}

variable "internal_image" {
  type        = string
  description = "Internal Image ID"
}

variable "SERVER" {
  type        = string
  description = "SERVER URL"
}