## oa-skunkworks

A 50,000 foot view approach of building a cloud native organisation and it's
infrastructure from the ground up.


### Organisational deployment

//TBD

```
cd terraform-access-control
terraform init
```

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

Helm will deploy all k8s resource you require via the helm dependency `requirements.yaml`

```
helm dependency build helm-cluster-bootstrap
Hang tight while we grab the latest from your chart repositories...
...Unable to get an update from the "local" chart repository (http://127.0.0.1:8879/charts):
	Get http://127.0.0.1:8879/charts/index.yaml: dial tcp 127.0.0.1:8879: connect: connection refused
...Unable to get an update from the "stable" chart repository (https://kubernetes-charts.storage.googleapis.com):
	Get https://kubernetes-charts.storage.googleapis.com/index.yaml: x509: certificate signed by unknown authority
Update Complete.
Saving 1 charts
Deleting outdated charts
```
