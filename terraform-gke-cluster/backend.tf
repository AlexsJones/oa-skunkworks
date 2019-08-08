terraform {
  backend "gcs" {
    bucket = "terraform-state-management"
    prefix = "gke-cluster/state"
  }
}
