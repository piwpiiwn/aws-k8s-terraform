output master_ip {
  value = aws_spot_instance_request.master.public_ip
}

output worker_1_ip {
  value = aws_spot_instance_request.worker_1.public_ip
}

output "ansibleinventory" {
  sensitive = true
  value = {
    all = {
      children = {
        masters = {
          hosts = {
            master = {
              ansible_host                 = aws_spot_instance_request.master.public_ip
              ansible_connection           = "ssh"
              ansible_user                 = "ec2-user"
              ansible_ssh_private_key_file = var.local_private_key_path
              ansible_python_interpreter   = "python3"
            }
          }
        }
        workers = {
          hosts = {
            worker_1 = {
              ansible_host                 = aws_spot_instance_request.worker_1.public_ip
              ansible_connection           = "ssh"
              ansible_user                 = "ec2-user"
              ansible_ssh_private_key_file = var.local_private_key_path
              ansible_ssh_common_args      = "-o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -W %h:%p -i ${var.local_private_key_path} -q ec2-user@${aws_spot_instance_request.master.public_ip}\""
              ansible_python_interpreter   = "python3"
            }
          }
        }
      }
    }
  }
}
