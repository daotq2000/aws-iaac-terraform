resource "aws_ecr_repository" "ecr_repository" {
  name = "eks-project"
  tags = {
    name="terraform project"
    description = "managed by terraform provisioning"
  }
}
