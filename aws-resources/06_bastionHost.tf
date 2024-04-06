resource "aws_instance" "bastion_host" {
  ami           = "ami-0c101f26f147fa7fd" # example AMI, update to the latest
  instance_type = "t2.micro" # example instance type, choose as per need
  subnet_id     = aws_subnet.public-subnet-1a.id
  key_name      = "public-bastion-host" # specify your key pair name
  security_groups = [aws_security_group.bastion_sg.id]
  user_data = <<EOF
    sudo yum update –y
    sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    sudo yum upgrade
    sudo dnf install java-17-amazon-corretto -y
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