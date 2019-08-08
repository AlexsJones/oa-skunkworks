Place here a `serviceaccount.json` with sufficient access to the projects within terraform-gke-cluster/environments
and their API components.

```
gcloud beta iam service-accounts create oa-skunkworks-automated \
    --description "Automated service account" \
    --display-name "oa-skunkworks-automated"
```

```
gcloud projects add-iam-policy-binding oa-development-248412 \
  --member serviceAccount:oa-skunkworks-automated@oa-development-248412.iam.gserviceaccount.com \
  --role roles/owner
```

```
gcloud iam service-accounts keys create serviceaccount.json \
  --iam-account oa-skunkworks-automated@oa-development-248412.iam.gserviceaccount.com
```
