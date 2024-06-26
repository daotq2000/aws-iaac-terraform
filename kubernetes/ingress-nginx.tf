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
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  version    = "4.3.0"
  namespace  = kubernetes_namespace.nginx-ingress.id
  values = [
    file("../HelmChart/ingress-nginx/public-values-uat.yaml")
  ]
}
# resource "helm_release" "aws_load_balancer_controller" {
#   name       = "aws-load-balancer-controller"
#   repository = "https://aws.github.io/eks-charts"
#   chart      = "aws-load-balancer-controller"
#   namespace  = "kube-system"
#
#   # Set values such as the cluster name and VPC ID
#   set {
#     name  = "clusterName"
#     value = "Eks-cluster"
#   }
#
#   set {
#     name  = "region"
#     value = "us-east-1"
#   }
#
#   set {
#     name  = "vpcId"
#     value = "10.0.0.0/16"
#   }
#
# }
# resource "kubernetes_manifest" "alb_ingress" {
#
#   manifest = {
#     apiVersion = "networking.k8s.io/v1"
#     kind       = "Ingress"
#
#     metadata = {
#       name        = "alb-ingress"
#       annotations = {
#         "kubernetes.io/ingress.class"                  = "alb"
#         "alb.ingress.kubernetes.io/scheme"             = "internet-facing"
#         "alb.ingress.kubernetes.io/target-type"        = "instance" # or "ip"
#         "alb.ingress.kubernetes.io/listen-ports"       = jsonencode([{HTTP:80}])
#         # Include any other annotations necessary for your setup
#       }
#       namespace  = "nginx-ingress-namespace"
#     }
#     spec = {
#       rules = [{
#         http = {
#           paths = [{
#             path        = "/*"
#             pathType    = "Prefix"
#             backend = {
#               service = {
#                 name = "aws-load-balancer-target"
#                 port = {
#                   number = 30080
#                 }
#               }
#             }
#           }]
#         }
#       }]
#     }
#   }
# }