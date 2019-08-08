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

variable "gcp_zones" {
  description = "GCP zone, e.g. us-east1-b (which must be in gcp_region)"
}

variable "gcp_project" {
  description = "GCP project name"
}

variable "initial_node_count" {
  description = "Number of worker VMs to initially create"
  default     = 1
}

variable "master_username" {
  description = "Username for accessing the Kubernetes master endpoint"
  default     = "k8smaster"
}

variable "master_password" {
  description = "Password for accessing the Kubernetes master endpoint"
  default     = "k8smasterk8smaster"
}
//Node Pool 0
variable "node_pool_0_name" {
  description = "GKE node pool name"
  default     = "np1"
}
variable "node_pool_0_machine_type" {
  description = "GKE machine type"
  default     = "n1-standard-1"
}
variable "node_pool_0_machine_count" {
  description = "GKE machine count"
  default     = 3
}
