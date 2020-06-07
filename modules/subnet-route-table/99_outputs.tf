output subnet_id {
  value       = aws_subnet.subnet.id
  description = "Subnet id"
}

output subnet_cidr_block {
  value       = aws_subnet.subnet.cidr_block
  description = "Subnet CIDR Block"
}

output route_table_id {
  value       = aws_route_table.route_table.id
  description = "Route Table id"
}
