variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}
variable "ssh_access_key" {
  type = string
  default = "public-bastion-host"
}
variable "aws_role_code_pipeline" {
  type = string
  default = "arn:aws:iam::846338211683:role/service-role/aws-code-pipeline"
}
variable "registry_credential" {
  type = string
  default = "registry_credential"
}
variable "registry_credential_provider" {
  type = string
  default = "registry_credential_provider"
}
variable "repository" {
  type = map
  default = {
    source: "GITHUB",
    url:"https://github.com/daotq2000/aws-spring-sqs-queue.git"
  }
}
variable "region" {
  type = string
  default = "us-east1"
}
variable "az" {
  type = set(string)
  default = ["us-east-1a","us-east-1b","us-east-1c"]
}