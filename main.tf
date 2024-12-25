terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.12.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
  }
}

# Retrieve an access token as the Terraform runner
data "google_client_config" "provider" {}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Enable Required PIs
resource "google_project_service" "required_apis" {
  for_each = toset([
    "compute.googleapis.com",   # Required for VPC and Subnet
    "container.googleapis.com", # Required for GKE
    "iam.googleapis.com"        # Required for Service Accounts
  ])
  project = var.project_id
  service = each.key

  disable_on_destroy = false # Prevent disabling services
}

module "network" {
  source               = "./modules/network"
  region               = var.region
  network_name         = var.network_name
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}



module "gke_cluster" {
  source = "./modules/gke"

  cluster_name = "devops-gke-cluster-02"
  region       = var.region
  network_name = module.network.vpc_id
  # cluster_secondary_range_name = "gke-secondary-range"
  # services_secondary_range_name = "gke-services-secondary-range"
  private_subnet_1  = module.network.private_subnets_name[1]
  private_subnet_2  = module.network.private_subnets_name[0]
  node_pool_1_count = 1
  # node_pool_2_count = 2
  disk_size_gb = 100
  providers = {
    helm = helm
    kubernetes = kubernetes
  }
  depends_on = [
    module.network.public_subnets
  ]
}

# resource "random_id" "default" {
#   byte_length = 8
# }

# resource "google_storage_bucket" "default" {
#   name = "${random_id.default.hex}-terraform-remote-backend"
#   project = var.project_id
#   location = var.region
#   force_destroy = true
#   public_access_prevention = "enforced"
#   uniform_bucket_level_access = true
#   depends_on = [ module.network ]
#   versioning {
#     enabled = true
#   }
# }

# resource "local_file" "default" {
#   file_permission = "0644"
#   filename        = "${path.module}/backend.tf"
  
#   content = <<EOF
#     terraform {
#       backend "gcs" {
#         bucket = "${google_storage_bucket.default.name}"
#       }
#     }
#   EOF
#   depends_on = [google_storage_bucket.default]
# }
