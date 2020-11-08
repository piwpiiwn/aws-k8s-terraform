# Security Group creation for worker nodes
resource "aws_security_group" "worker" {
  name        = "k8s worker"
  description = "Allow cluster comunication"
  vpc_id      = aws_vpc.k8s.id

  tags = merge(
    var.tags,
    map(
      "Name", "k8s_worker"
    )
  )
}

# SECURITY GROUP RULES:

# Allow internet access
resource "aws_security_group_rule" "worker_allow_egress" {
  security_group_id = aws_security_group.worker.id

  type        = "egress"
  description = "Allow all egress"
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks = ["0.0.0.0/0"]
}

# Allow all from other nodes in the subnet
resource "aws_security_group_rule" "worker_allow_subnet" {
  security_group_id = aws_security_group.worker.id

  type        = "ingress"
  description = "Allow all from subnet"
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks = [aws_subnet.k8s.cidr_block]
}
