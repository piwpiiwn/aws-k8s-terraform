output master_public_ip {
  value = aws_instance.master.public_ip
}
output master_private_ip {
  value = aws_instance.master.private_ip
}

output worker_public_ip {
  value = aws_spot_instance_request.worker.public_ip
}
output worker_private_ip {
  value = aws_spot_instance_request.worker.private_ip
}

output "inventory" {
  sensitive = true
  value = {
    all = {
      children = {
        masters = {
          hosts = {
            master = {
              ansible_host       = aws_instance.master.public_ip
              ansible_connection = "ssh"
              ansible_user       = "ec2-user"
            }
          }
        }
        workers = {
          hosts = {
            worker = {
              ansible_host            = aws_spot_instance_request.worker.private_ip
              ansible_connection      = "ssh"
              ansible_user            = "ec2-user"
              ansible_ssh_common_args = "-o ProxyCommand=\"ssh -q -W %h:%p -l ec2-user ${aws_instance.master.public_ip}\""
            }
          }
        }
      }
    }
  }
}
