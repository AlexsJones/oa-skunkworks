cluster_name       = "oa-development-cluster"
credentials_path   = "../serviceaccounts/serviceaccount.json"
gcp_region         = "us-east4-a"
gcp_zones          = ["us-east4-b", "us-east4-c"]
gcp_project        = "oa-development-248412"
initial_node_count = 0
master_username    = "k8smaster"
master_password    = "k8smasterk8smaster"


node_pool_0_name          = "np1"
node_pool_0_machine_type  = "n1-standard-1"
node_pool_0_machine_count = 1
