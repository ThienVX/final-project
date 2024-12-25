variable "project_id" {
  description = "GCP project ID"
  type        = string
  default = "amazing-math-407308"
}

variable "gke_namespace" {
  description = "GCP project ID"
  type        = string
  default = "data-process"
}


variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "region" {
  description = "The region for the GKE Cluster"
  type        = string
}

variable "secondary_ip_range" {
  type = string
  description = "using for custom secondary ip range"
  default = "10.0.104.0/24"
}

variable "network_name" {
  type = string
  description = "network name"
}




# variable "cluster_secondary_range_name" {
#   description = "Cluster secondary range name"
#   type        = string
# }

# variable "services_secondary_range_name" {
#   description = "Services secondary range name"
#   type        = string
# }

variable "private_subnet_1" {
  description = "Private subnet 1 for nodepool 1"
  type        = string
}

variable "private_subnet_2" {
  description = "Private subnet 2 for nodepool 2"
  type        = string
}

variable "node_pool_1_count" {
  description = "Number of nodes in the first node pool"
  type        = number
  default     = 1
}

variable "node_pool_2_count" {
  description = "Number of nodes in the second node pool"
  type        = number
  default     = 1
}


variable "disk_size_gb" {
  type = number
  default = 10
}
variable "disk_type" {
  type = string
  default = "pd-standard"
}
variable "machine_type" {
  default = "n1-standard-2"
}