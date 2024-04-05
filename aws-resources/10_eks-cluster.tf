resource "aws_eks_cluster" "eks_cluster" {
  name     = "Eks-cluster"
  role_arn = aws_iam_role.role-eks.arn
  vpc_config {
    subnet_ids = [
      aws_subnet.private-subnet-1a.id,
      aws_subnet.private-subnet-1b.id,
      aws_subnet.private-subnet-1c.id
    ]
  }
  depends_on = [aws_iam_role_policy_attachment.eks_attach]
  tags = {
    name="terraform project"
    description = "managed by terraform provisioning"
  }
}