# RT for the VPC (get references)
resource "aws_route_table_association" "k8s" {
  subnet_id      = aws_subnet.k8s.id
  route_table_id = aws_route_table.k8s.id
}
resource "aws_route_table" "k8s" {
  vpc_id = aws_vpc.k8s.id

  tags = merge(
    var.tags,
    map(
      "Name", "k8s"
    )
  )
}

# Create a route in the RT:
# - Go through IGW to reach EC2 with public IP (from the IGW)
resource "aws_route" "public" {
  route_table_id         = aws_route_table.k8s.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.k8s.id
}
