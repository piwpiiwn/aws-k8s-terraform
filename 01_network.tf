resource "aws_vpc" "k8s" {
  cidr_block = var.vpc_cidr_block

  tags = merge(
    var.tags,
    map(
      "Name", "k8s"
    )
  )
}

resource "aws_internet_gateway" "k8s" {
  vpc_id = aws_vpc.k8s.id

  tags = merge(
    var.tags,
    map(
      "Name", "k8s"
    )
  )
}

module "k8s_management" {
  source = "./modules/subnet-route-table"

  name                    = "k8s_management"
  vpc_id                  = aws_vpc.k8s.id
  cidr_block              = var.management_subnet_cidr_block
  availability_zone       = "${var.region}a"
  internet_gateway_id     = aws_internet_gateway.k8s.id
  map_public_ip_on_launch = false

  tags = var.tags
}

module "k8s_worker_1" {
  source = "./modules/subnet-route-table"

  name                = "k8s_worker_1"
  vpc_id              = aws_vpc.k8s.id
  cidr_block          = var.worker_subnet_1_cidr_block
  availability_zone   = "${var.region}b"
  internet_gateway_id = aws_internet_gateway.k8s.id

  tags = var.tags
}

module "k8s_worker_2" {
  source = "./modules/subnet-route-table"

  name                = "k8s_worker_2"
  vpc_id              = aws_vpc.k8s.id
  cidr_block          = var.worker_subnet_2_cidr_block
  availability_zone   = "${var.region}c"
  internet_gateway_id = aws_internet_gateway.k8s.id

  tags = var.tags
}
