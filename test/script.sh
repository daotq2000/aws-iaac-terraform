aws eks update-kubeconfig --region us-east-1 --name Eks-cluster
kubectl create deployment kubernetes-bootcamp --image=kimb88/hello-world-spring-boot:latest
kubectl expose deployment/kubernetes-bootcamp --type="ClusterIP" --port 80:8080
helm repo add eks https://aws.github.io/eks-charts
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=Eks-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller



