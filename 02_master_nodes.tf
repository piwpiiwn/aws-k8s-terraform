resource "aws_instance" "master" {
  ami           = local.master_ami
  instance_type = var.master_instance_type
  key_name      = var.key_name

  subnet_id                   = aws_subnet.k8s.id
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
