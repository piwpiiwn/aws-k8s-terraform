resource "aws_spot_instance_request" "worker" {
  ami           = local.worker_ami
  spot_price    = var.worker_spot_price
  instance_type = var.worker_instance_type
  key_name      = var.key_name

  subnet_id                   = aws_subnet.k8s.id
  vpc_security_group_ids      = [aws_security_group.worker.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = "20"
  }

  wait_for_fulfillment = true
  spot_type            = "one-time"

  tags = merge(
    var.tags,
    map(
      "Name", "k8s_worker"
    )
  )
}
