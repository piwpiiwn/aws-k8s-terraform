resource "aws_security_group" "master" {
  name        = "k8s master SG"
  description = "Allow cluster comunication"
  vpc_id      = aws_vpc.k8s.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow traffic from workers"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      module.k8s_worker_1.subnet_cidr_block,
      module.k8s_worker_2.subnet_cidr_block
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    map(
      "Name", "k8s_master"
    )
  )
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
