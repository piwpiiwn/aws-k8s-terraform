# Security Group creation for master nodes
resource "aws_security_group" "master" {
  name        = "k8s master"
  description = "Allow cluster comunication"
  vpc_id      = aws_vpc.k8s.id

  tags = merge(
    var.tags,
    map(
      "Name", "k8s_master"
    )
  )
}

# SECURITY GROUP RULES:

# Allow ssh from allowed_ips
resource "aws_security_group_rule" "master_allow_ssh" {
  security_group_id = aws_security_group.master.id

  type        = "ingress"
  description = "Allow SSH from allowed_ips"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = var.allowed_ips
}

# Allow API from anywhere
resource "aws_security_group_rule" "master_allow_api" {
  security_group_id = aws_security_group.master.id

  type        = "ingress"
  description = "Allow API Server from allowed_ips"
  from_port   = 6443
  to_port     = 6443
  protocol    = "tcp"
  cidr_blocks = var.allowed_ips
}

# Allow internet access
resource "aws_security_group_rule" "master_allow_egress" {
  security_group_id = aws_security_group.master.id

  type        = "egress"
  description = "Allow all egress"
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks = ["0.0.0.0/0"]
}

# Allow all from other nodes in the subnet
resource "aws_security_group_rule" "master_allow_subnet" {
  security_group_id = aws_security_group.master.id

  type        = "ingress"
  description = "Allow all from subnet"
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks = [aws_subnet.k8s.cidr_block]
}
