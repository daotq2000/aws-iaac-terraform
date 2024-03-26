variable "vpc_cidr_block" {
  type = string
  default = "10.10.0.0/24"
}
variable "subnet-az" {
  type = map(string)
  default = {
    us-east-1a: "10.10.0.0/24",
    us-east-1b: "10.10.1.0/24",
    us-east-1c: "10.10.2.0/24"
  }
}
variable "ami-bastion-host" {
  type = string
  default = "ami-0c101f26f147fa7fd"
}
variable "ssh-key" {
  type = string
  default = "ssh-key-bastion-host"
}