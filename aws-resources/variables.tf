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
  default = "aws-code-pipeline"
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
    url:"https://github.com/daotq2000/aws-iaac-terraform"
  }
}