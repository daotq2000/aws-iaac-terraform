provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = var.eks-context-name
  insecure = true
}
provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = var.eks-context-name
    insecure = true
  }
}