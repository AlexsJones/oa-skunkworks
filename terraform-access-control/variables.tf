variable "cluster_name" {
  description = "Cluster name"
  default     = "terraform"
}

variable "credentials_path" {
  description = "Path to service account credentials"
}

variable "gcp_region" {
  description = "GCP region, e.g. us-east1"
  default     = "us-east1"
}

variable "gcp_zone" {
  description = "GCP zone, e.g. us-east1-b (which must be in gcp_region)"
  default     = "us-east1-b"
}

variable "gcp_project" {
  description = "GCP project name"
}
