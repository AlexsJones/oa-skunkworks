provider "google" {
  credentials = "${var.credentials_path}"
  project     = "${var.gcp_project}"
  region      = "${var.gcp_region}"
}
terraform {
  required_version = ">= 0.11.11"
}
provider "helm" {

}
