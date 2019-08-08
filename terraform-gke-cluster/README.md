# terraform-gke-cluster

A simple terraform GKE cluster example.

## Setup

- Install terraform 0.11.11 or higher
- Grab a GCP service account json file and have the path ready. (Usually Owner role is required for full capabilities)
- Have your project name available.
- `terraform plan`
- You need to have option to add a state bucket that matches the `backend.tf` naming
