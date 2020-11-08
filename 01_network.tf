# Main VPC
resource "aws_vpc" "k8s" {
  cidr_block = var.vpc_cidr_block

  tags = merge(
    var.tags,
    map(
      "Name", "k8s"
    )
  )
}

# IGW for main VPC
resource "aws_internet_gateway" "k8s" {
  vpc_id = aws_vpc.k8s.id

  tags = merge(
    var.tags,
    map(
      "Name", "k8s"
    )
  )
}

# Main Subnet for EC2
resource "aws_subnet" "k8s" {
  vpc_id            = aws_vpc.k8s.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = "eu-west-1a"

  tags = merge(
    var.tags,
    map(
      "Name", "k8s"
    )
  )
}
