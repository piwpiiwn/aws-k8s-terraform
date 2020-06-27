variable name {
  type        = string
  description = "Name for the Subnet and Route Table"
}

variable vpc_id {
  type        = string
  description = "VPC ID for the Subnet"
}

variable cidr_block {
  type        = string
  description = "CIDR Block for the Subnet"
}

variable availability_zone {
  type        = string
  description = "Availability Zone for the subnet"
}

variable public {
  default     = true
  description = "Makes subnet public or private"
}

variable map_public_ip_on_launch {
  type        = string
  default     = true
  description = "Assign Public IP Defaut value"
}

variable internet_gateway_id {
  type        = string
  default     = ""
  description = "Internet Gateway id if the subnet is public"
}

variable tags {
  type        = map
  description = "A map of tags to assign to every resource"
}

