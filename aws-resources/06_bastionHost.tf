resource "aws_instance" "bastion_host" {
  ami           = "ami-0c101f26f147fa7fd" # example AMI, update to the latest
  instance_type = "t2.micro" # example instance type, choose as per need
  subnet_id     = aws_subnet.public-subnet-1a.id
  key_name      = "public-bastion-host" # specify your key pair name
  security_groups = [aws_security_group.bastion_sg.id]
  tags = {
    name="terraform project"
    description = "managed by terraform provisioning"
  }
}