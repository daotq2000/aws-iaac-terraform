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
resource "kubernetes_namespace" "ciaws" {
  metadata {
    annotations = {
      name:"ciaws"
    }
    name = "ciaws"
  }
  lifecycle {
  }
}
resource "kubernetes_namespace" "monitoring" {
  metadata {
    annotations = {
      name:"monitoring"
    }
    name = "monitoring"
  }
  lifecycle {
  }
}

resource "helm_release" "public-nginx-ingress" {
  name       = "ingress-public"
  chart      = "aws-load-balancer-controller"
  repository = "public.ecr.aws/eks/aws-load-balancer-controller"
  version    = "v2.7.0"
  namespace  = kubernetes_namespace.nginx-ingress.id
  values = [
    file("../HelmChart/ingress-nginx/values.yaml")
  ]
}