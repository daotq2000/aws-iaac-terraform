output "vpc-main" {
  value = aws_vpc.vpc-main.id
}
output "sqs_id" {
  value = aws_sqs_queue.sqs_iaac.id
}
output "sqs_arn" {
  value = aws_sqs_queue.sqs_iaac.arn
}
output "sqs_url" {
  value = aws_sqs_queue.sqs_iaac.url
}
output "sqs_queue_name" {
  value = aws_sqs_queue.sqs_iaac.name
}
output "kubeconfig" {
  value = aws_eks_cluster.eks_cluster.access_config
}
resource "local_file" "kubeconfig" {
  filename = "configurations/kubeconfig"
  content = aws_eks_cluster.eks_cluster.access_config
}