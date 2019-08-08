terraform {
  backend "gcs" {
    bucket = "terraform-state-management"
    prefix = "iam-control/state"
  }
}
