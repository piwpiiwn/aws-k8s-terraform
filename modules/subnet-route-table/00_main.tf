resource "aws_subnet" "subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_block
  availability_zone = var.availability_zone

  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    var.tags,
    map(
      "Name", var.name
    )
  )
}

resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  tags = merge(
    var.tags,
    map(
      "Name", var.name
    )
  )
}

resource "aws_route_table_association" "route_table_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route" "public_route" {
  count = var.public == true ? 1 : 0

  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}
