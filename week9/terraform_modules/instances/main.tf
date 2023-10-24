resource "aws_key_pair" "its-kp" {
  key_name   = "its-node-key"
  public_key = file("./ssh-keys/its-node-key.pub")
}

resource "aws_launch_template" "its-lt" {
  name                   = "its-lt"
  image_id               = "ami-0df435f331839b2d6"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.its-kp.key_name
  update_default_version = true
}

resource "aws_instance" "its-worker-nodes" {
  count = 2
  private_ip = "10.0.1.${count.index + 11}"
  vpc_security_group_ids = [var.security_group_id]
  subnet_id = var.public_subnets[0]

  launch_template {
    id = aws_launch_template.its-lt.id
  }
}

resource "aws_instance" "its-master-node" {
  instance_type = "t3.medium"
  private_ip = "10.0.1.10"
  vpc_security_group_ids = [var.security_group_id]
  subnet_id = var.public_subnets[0]

  launch_template {
    id = aws_launch_template.its-lt.id
  }
}

resource "local_file" "ansible-inventory" {
  filename             = "${path.module}/ansible/inventory"
  directory_permission = "0777"
  file_permission      = "0666"
  content              = <<EOT
all:
  hosts:
    worker01:
      ansible_host: ${aws_instance.its-worker-nodes[0].public_ip}
    worker02:
      ansible_host: ${aws_instance.its-worker-nodes[1].public_ip}
    master01:
      ansible_host: ${aws_instance.its-master-node.public_ip}

  children:
    workers:
      hosts:
        worker01:
        worker02:
    masters:
      hosts:
        master01:

  vars:
    ansible_user: ec2-user
    ansible_ssh_private_key_file: ../ssh-keys/its-node-key
  EOT

  provisioner "local-exec" {
    command = "scp -rp -i ./ssh-keys/its-control.pem ./ansible/inventory ec2-user@${var.control_ip}:/home/ec2-user/ansible/"
  }
}