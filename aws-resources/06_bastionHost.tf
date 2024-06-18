resource "aws_instance" "bastion_host" {
  ami           = "ami-0c101f26f147fa7fd" # example AMI, update to the latest
#   instance_type = "t2.small" # example instance type, choose as per need
  instance_type = "t3.small" # example instance type, choose as per need
  subnet_id     = aws_subnet.public-subnet-1a.id
  key_name      = var.ssh_access_key # specify your key pair name
  security_groups = [aws_security_group.bastion_sg.id]
  user_data = <<EOF
    sudo yum update
    sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    sudo yum upgrade
    sudo yum install java-11-amazon-corretto-headless
    sudo yum install jenkins -y
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
    sudo systemctl status jenkins
  EOF

  tags = {
    name="terraform project"
    description = "managed by terraform provisioning"
  }
}