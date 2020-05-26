resource "aws_vpc" "k8s" {
  cidr_block = var.vpc_cidr_block

  tags = merge(
    var.tags,
    map(
      "Name", "k8s"
    )
  )
}

resource "aws_subnet" "k8s_management" {
  vpc_id            = aws_vpc.k8s.id
  cidr_block        = var.management_subnet_cidr_block
  availability_zone = "${var.region}a"

  tags = merge(
    var.tags,
    map(
      "Name", "k8s_management"
    )
  )
}

resource "aws_subnet" "k8s_worker_1" {
  vpc_id            = aws_vpc.k8s.id
  cidr_block        = var.worker_subnet_1_cidr_block
  availability_zone = "${var.region}b"

  tags = merge(
    var.tags,
    map(
      "Name", "k8s_worker_1"
    )
  )
}

resource "aws_subnet" "k8s_worker_2" {
  vpc_id            = aws_vpc.k8s.id
  cidr_block        = var.worker_subnet_2_cidr_block
  availability_zone = "${var.region}c"

  tags = merge(
    var.tags,
    map(
      "Name", "k8s_worker_2"
    )
  )
}
