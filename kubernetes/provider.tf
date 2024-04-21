provider "kubernetes" {
  config_path    = "configurations/kubeconfig"
  config_context = "aws-iaac"
  insecure = true
}
provider "helm" {
  kubernetes {
    config_path    = "configurations/kubeconfig"
    config_context = "aws-iaac"
    insecure = true
  }
}