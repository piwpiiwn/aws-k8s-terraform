variable region {
  type        = string
  default     = "eu-west-1"
  description = "AWS Region"
}

variable tags {
  type        = map
  description = "Default tags"
}

variable vpc_cidr_block {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR for K8S VPC"
}

variable management_subnet_cidr_block {
  type        = string
  default     = "10.0.255.0/24"
  description = "CIDR for K8S Management Subnet"
}

variable worker_subnet_1_cidr_block {
  type        = string
  default     = "10.0.1.0/24"
  description = "CIDR for K8S Subnet 1"
}

variable worker_subnet_2_cidr_block {
  type        = string
  default     = "10.0.2.0/24"
  description = "CIDR for K8S Subnet 2"
}

variable master_instance_type {
  type        = string
  default     = "t3.medium"
  description = "Master Node Instance Type"
}

variable master_spot_price {
  type        = string
  default     = "0.0456"
  description = "Master Node Spot Price"
}

variable worker_instance_type {
  type        = string
  default     = "t3.medium"
  description = "Worker Node Instance Type"
}

variable worker_spot_price {
  type        = string
  default     = "0.0456"
  description = "Worker Node Spot Price"
}

variable key_name {
  type        = string
  default     = "k8s"
  description = "Public Key Name"
}
