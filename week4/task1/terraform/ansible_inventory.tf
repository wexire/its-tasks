resource "local_file" "its-ansible-inv" {
  filename             = "${path.module}/../inventory"
  directory_permission = "0777"
  file_permission      = "0400"
  content              = <<EOT
all:
  hosts:
    web01:
      ansible_host: ${aws_instance.its-web[0].public_ip}
    web02:
      ansible_host: ${aws_instance.its-web[1].public_ip}
    db01:
      ansible_host: ${aws_instance.its-db.private_ip}
      ansible_ssh_common_args: '-o ProxyCommand="ssh -o StrictHostKeyChecking=no -W %h:%p -q ec2-user@${aws_instance.its-bastion.public_ip} -i ../ssh-keys/its-bastion-key"'

  children:
    webservers:
      hosts:
        web01:
        web02:

  vars:
    ansible_user: ec2-user
    ansible_ssh_private_key_file: ../ssh-keys/its-instance-key
  EOT

  provisioner "local-exec" {
    command = "scp -rp -i ../its-control.pem ../inventory ec2-user@${var.CONTROL_IP}:/home/ec2-user/ansible/"
  }
}