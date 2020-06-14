resource "aws_security_group" "master" {
  name        = "k8s master SG"
  description = "Allow cluster comunication"
  vpc_id      = aws_vpc.k8s.id

  tags = merge(
    var.tags,
    map(
      "Name", "k8s_master"
    )
  )
}

resource "aws_security_group_rule" "master_allow_ssh" {
  security_group_id = aws_security_group.master.id

  type        = "ingress"
  description = "Allow SSH from everywhere"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master_allow_egress" {
  security_group_id = aws_security_group.master.id

  type        = "egress"
  description = "Allow all egress"
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master_allow_worker_1" {
  security_group_id = aws_security_group.worker_1.id

  type                     = "ingress"
  description              = "Allow all traffic from workers"
  from_port                = 0
  to_port                  = 0
  protocol                 = -1
  source_security_group_id = aws_security_group.worker_1.id
}

resource "aws_spot_instance_request" "master" {
  ami           = local.master_ami
  spot_price    = var.master_spot_price
  instance_type = var.master_instance_type
  key_name      = var.key_name

  subnet_id                   = module.k8s_management.subnet_id
  vpc_security_group_ids      = [aws_security_group.master.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = "20"
  }

  tags = merge(
    var.tags,
    map(
      "Name", "k8s_master"
    )
  )
}
