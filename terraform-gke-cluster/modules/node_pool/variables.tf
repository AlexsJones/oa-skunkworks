variable "node_pool_name" {
  description = "GKE node pool name"
  default     = "np1"
}
variable "node_pool_machine_type" {
  description = "GKE machine type"
  default     = "n1-standard-1"
}
variable "node_pool_machine_count" {
  description = "GKE machine count"
}
variable "gcp_region" {
  description = "GCP region, e.g. us-east1"
}
variable "cluster_name" {
  description = "GKE cluster name"

}
