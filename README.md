Command history:

```bash
terraform init
terraform plan
terraform apply
terraform plan -out="aks.tfplan"
terraform show aks.tfplan
terraform apply aks.tfplan
terraform output
terraform output -raw kube_config > ~/.kube/glebops.yaml
export KUBECONFIG=~/.kube/glebops.yaml
kubect get nodes
k9s
terraform init -upgrade
terraform console

> azurerm_kubernetes_cluster.main

terraform import  'helm_release.this["contour"]' "projectcontour/contour"
terraform import  'helm_release.this["nginx"]' "default/nginx"
terraform state list
terraform state rm helm_release.ingress helm_release.nginx
terraform state list
terraform plan -out="aks.tfplan"
terraform destroy -auto-approve
```
To read about:
- EOT
- ingress controllers

