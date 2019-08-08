## oa-skunkworks

A 50,000 foot view approach of building a cloud native organisation and it's
infrastructure from the ground up.


### Cluster deployment

```
cd terraform-gke-cluster
terraform init
terraform plan --var-file=environments/oa-development.tfvars
terraform apply --var-file=environments/oa-development.tfvars
cd ../
````

```
cat >> tiller-admin.yaml << EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: tiller
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: tiller
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: tiller
    namespace: kube-system
EOF
```

`kubectl apply -f tiller-admin.yaml`

```
helm init --service-account tiller --history-max 200

```

### Application deployment

```
helm dependency build helm-cluster-bootstrap
```
