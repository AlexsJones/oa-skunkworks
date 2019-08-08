resource "google_container_cluster" "cluster" {
  name                     = "${var.cluster_name}"
  location                 = "${var.gcp_region}"
  remove_default_node_pool = true
  initial_node_count       = 1
  node_locations           = "${var.gcp_zones}"
  master_auth {
    username = "${var.master_username}"
    password = "${var.master_password}"

    client_certificate_config {
      issue_client_certificate = false
    }
  }
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${var.cluster_name} --region=${var.gcp_region}"
  }
}
