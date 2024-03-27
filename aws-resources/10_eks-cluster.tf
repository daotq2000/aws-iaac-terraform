resource "aws_eks_cluster" "eks_cluster" {
  name     = "Eks-cluster"
  role_arn = aws_iam_role.role-eks.arn
  vpc_config {
    subnet_ids = [
      aws_subnet.private-subnet-1a,
      aws_subnet.private-subnet-1b,
      aws_subnet.private-subnet-1c
    ]
  }
  depends_on = [aws_iam_role_policy_attachment.eks_attach]
}