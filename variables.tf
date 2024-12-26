variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default = "amazing-math-407308"
}

variable "region" {
  description = "The region for the VPC"
  type        = string
  default = "asia-southeast1"
}

variable "network_name" {
  description = "The name of the VPC"
  type        = string
  default = "gke-demo-vpc"
}

variable "public_subnet_cidrs" {
  description = "CIDR ranges for public subnets"
  type        = list(string)
  default     = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
}

variable "private_subnet_cidrs" {
  description = "CIDR ranges for private subnets"
  type        = list(string)
  default     = [
    "10.0.101.0/24",
    "10.0.102.0/24",
    "10.0.103.0/24"
  ]
}
