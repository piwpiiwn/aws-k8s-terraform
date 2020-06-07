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

resource "aws_subnet" "k8s_management" {
  vpc_id            = aws_vpc.k8s.id
  cidr_block        = var.management_subnet_cidr_block
  availability_zone = "${var.region}a"

  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    map(
      "Name", "k8s_management"
    )
  )
}

resource "aws_route_table" "k8s_management" {
  vpc_id = aws_vpc.k8s.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s.id
  }

  tags = merge(
    var.tags,
    map(
      "Name", "k8s_management"
    )
  )
}

resource "aws_route_table_association" "k8s_management" {
  subnet_id      = aws_subnet.k8s_management.id
  route_table_id = aws_route_table.k8s_management.id
}

resource "aws_subnet" "k8s_worker_1" {
  vpc_id            = aws_vpc.k8s.id
  cidr_block        = var.worker_subnet_1_cidr_block
  availability_zone = "${var.region}b"

  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    map(
      "Name", "k8s_worker_1"
    )
  )
}

resource "aws_route_table" "k8s_worker_1" {
  vpc_id = aws_vpc.k8s.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s.id
  }

  tags = merge(
    var.tags,
    map(
      "Name", "k8s_worker_1"
    )
  )
}

resource "aws_route_table_association" "k8s_worker_1" {
  subnet_id      = aws_subnet.k8s_worker_1.id
  route_table_id = aws_route_table.k8s_worker_1.id
}


resource "aws_subnet" "k8s_worker_2" {
  vpc_id            = aws_vpc.k8s.id
  cidr_block        = var.worker_subnet_2_cidr_block
  availability_zone = "${var.region}c"

  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    map(
      "Name", "k8s_worker_2"
    )
  )
}


resource "aws_route_table" "k8s_worker_2" {
  vpc_id = aws_vpc.k8s.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s.id
  }

  tags = merge(
    var.tags,
    map(
      "Name", "k8s_worker_2"
    )
  )
}

resource "aws_route_table_association" "k8s_worker_2" {
  subnet_id      = aws_subnet.k8s_worker_2.id
  route_table_id = aws_route_table.k8s_worker_2.id
}
