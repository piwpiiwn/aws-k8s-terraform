### Worker 1 ###
resource "aws_security_group" "worker_1" {
  name        = "k8s worker 1 SG"
  description = "Allow cluster comunication"
  vpc_id      = aws_vpc.k8s.id

  tags = merge(
    var.tags,
    map(
      "Name", "k8s_worker_1"
    )
  )
}

resource "aws_security_group_rule" "worker_1_allow_egress" {
  security_group_id = aws_security_group.worker_1.id

  type        = "egress"
  description = "Allow all egress"
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "worker_1_allow_master" {
  security_group_id = aws_security_group.worker_1.id

  type                     = "ingress"
  description              = "Allow traffic from master"
  from_port                = 0
  to_port                  = 0
  protocol                 = -1
  source_security_group_id = aws_security_group.master.id
}

resource "aws_spot_instance_request" "worker_1" {
  ami           = local.master_ami
  spot_price    = var.master_spot_price
  instance_type = var.master_instance_type
  key_name      = var.key_name

  subnet_id                   = module.k8s_worker_1.subnet_id
  vpc_security_group_ids      = [aws_security_group.worker_1.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = "20"
  }

  wait_for_fulfillment = true
  spot_type            = "one-time"

  tags = merge(
    var.tags,
    map(
      "Name", "k8s_worker_1"
    )
  )
}

### Worker 2 ###
resource "aws_security_group" "worker_2" {
  name        = "k8s worker 2 SG"
  description = "Allow cluster comunication"
  vpc_id      = aws_vpc.k8s.id

  tags = merge(
    var.tags,
    map(
      "Name", "k8s_worker_2"
    )
  )
}

resource "aws_security_group_rule" "worker_2_allow_egress" {
  security_group_id = aws_security_group.worker_2.id

  type        = "egress"
  description = "Allow all egress"
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "worker_2_allow_master" {
  security_group_id = aws_security_group.worker_2.id

  type                     = "ingress"
  description              = "Allow traffic from master"
  from_port                = 0
  to_port                  = 0
  protocol                 = -1
  source_security_group_id = aws_security_group.master.id
}

resource "aws_spot_instance_request" "worker_2" {
  ami           = local.master_ami
  spot_price    = var.master_spot_price
  instance_type = var.master_instance_type
  key_name      = var.key_name

  subnet_id                   = module.k8s_worker_2.subnet_id
  vpc_security_group_ids      = [aws_security_group.worker_2.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = "20"
  }

  wait_for_fulfillment = true
  spot_type            = "one-time"

  tags = merge(
    var.tags,
    map(
      "Name", "k8s_worker_2"
    )
  )
}
