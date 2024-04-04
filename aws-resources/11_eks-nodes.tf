resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "private-nodes"
  node_role_arn   = aws_iam_role.nodes.arn
  ami_type = "AL2_x86_64"
  subnet_ids = [
    aws_subnet.private-subnet-1a.id,
    aws_subnet.private-subnet-1b.id,
    aws_subnet.private-subnet-1c.id,
  ]

  capacity_type  = "SPOT"
  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 1
    max_size     = 5
    min_size     = 0
  }
  remote_access {
    ec2_ssh_key = var.ssh_access_key
    source_security_group_ids = [aws_security_group.bastion_sg.id]
  }
  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "Eks-cluster"
  }

  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
}