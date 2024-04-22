resource "kubernetes_namespace" "nginx-ingress" {
  metadata {
    annotations = {
      name:"ingress-nginx-namespace"
    }
    name = "nginx-ingress-namespace"
  }
  lifecycle {
  }
}
resource "helm_release" "public-nginx-ingress" {
  name       = "ingress-public"
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  version    = "4.3.0"
  namespace  = kubernetes_namespace.nginx-ingress.id
  values = [
    file("../HelmChart/ingress-nginx/public-values.yaml")
  ]
}