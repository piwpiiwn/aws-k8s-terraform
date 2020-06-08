# Subnet and route table Terraform module

This module creates:

- Subnet
- Route Table
- Route Table association

## Example Usage

```hcl
module my_subnet {
  source = "./modules/subnet-route-table"

  name                = "my-subnet"
  vpc_id              = "vpc-aaaabbbbcccc"
  cidr_block          = "10.0.0.0/24"
  availability_zone   = "eu-west-1a"
  internet_gateway_id = "igw-aaaabbbbcccc"

  tags = var.tags
}
```

## Variables

- **name**: *Required*. Name for the Subnet and Route Table.
- **vpc_id**: *Required*. VPC ID for the Subnet.
- **cidr_block**: *Required*. CIDR Block for the Subnet.
- **availability_zone**: *Required*. Availability Zone for the subnet.
- **tags**: *Required*. A map of tags to assign to every resource.
- **internet_gateway_id**: Internet Gateway id if the subnet is public. Rquired unless **public** is set to *false*.
- **public**: Makes subnet public or private. *Default*: true.
- **map_public_ip_on_launch**: Assign Public IP Defaut value. *Default*: true.

## Outputs

- **subnet_id**: Subnet id.
- **subnet_cidr_block**: Subnet CIDR Block.
- **route_table_id**: Route Table id.
