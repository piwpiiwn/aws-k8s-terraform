variable tags {
  type        = map
  default     = {}
  description = "Default tags"
}

# NETWORK VARS

variable vpc_cidr_block {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR for K8s VPC"
}

variable subnet_cidr_block {
  type        = string
  default     = "10.0.0.0/24"
  description = "CIDR for K8S Management Subnet"
}

# INSTANCES VARS

variable master_instance_type {
  type        = string
  default     = "t3a.medium"
  description = "Master Node Instance Type"
}

variable worker_instance_type {
  type        = string
  default     = "t3a.medium"
  description = "Worker Node Instance Type"
}

variable worker_spot_price {
  type        = string
  default     = "0.0408"
  description = "Worker Node Spot Price"
}

variable key_name {
  type        = string
  default     = "k8s"
  description = "Public Key Name"
}

# SECURITY GROUPS VARS
variable allowed_ips {
  type        = list
  default     = ["0.0.0.0/0"] # All
  description = "Allowed IPs for managing the cluster"
}
