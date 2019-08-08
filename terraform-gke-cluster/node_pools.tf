module "node_pool_0" {
  source                  = "./modules/node_pool"
  node_pool_name          = "${var.node_pool_0_name}"
  node_pool_machine_type  = "${var.node_pool_0_machine_type}"
  node_pool_machine_count = "${var.node_pool_0_machine_count}"
  cluster_name            = "${google_container_cluster.cluster.name}"
  gcp_region              = "${var.gcp_region}"
}
