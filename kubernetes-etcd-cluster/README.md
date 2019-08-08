## ETCD Cluster

Helm based version of etcd-cluster

```
helm install -f values.yaml . --wait --set storgae.provisioner="hostPath"
NAME:   wiggly-woodpecker
LAST DEPLOYED: Mon Aug  5 14:14:37 2019
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==> v1/Namespace
NAME  STATUS  AGE
etcd  Active  24s

==> v1/Pod(related)
NAME    READY  STATUS   RESTARTS  AGE
etcd-0  1/1    Running  0         24s
etcd-1  1/1    Running  0         21s
etcd-2  1/1    Running  0         3s

==> v1/Service
NAME  TYPE       CLUSTER-IP  EXTERNAL-IP  PORT(S)            AGE
etcd  ClusterIP  None        <none>       2380/TCP,2379/TCP  24s

==> v1/StorageClass
NAME      PROVISIONER           AGE
ssd-disk  kubernetes.io/gce-pd  24s

==> v1beta1/CronJob
NAME              SCHEDULE   SUSPEND  ACTIVE  LAST SCHEDULE  AGE
etcd-defrag-cron  0 2 * * *  False    0       <none>         24s

==> v1beta1/StatefulSet
NAME  READY  AGE
etcd  3/3    24s

```


## Deployment



__In production a default affinity key is set to set the node_pool `etcd` for usage, though you can disable this__

__Optionally `disktype` can be set to one of the kubernetes supported storageclasses__


## Quick test

Once the application has been deployed check it works...

```
kubectl exec etcd-0 -n etcd -- etcdctl set foo bar
kubectl exec etcd-2 -n etcd -- etcdctl get foo
```

## Failover
If any etcd member fails it gets re-joined eventually. You can test the scenario by killing process of one of the replicas:
```
$ ps aux | grep etcd-1
$ kill -9 ETCD_1_PID
$ kubectl get pods -l "app=etcd"
NAME                 READY     STATUS        RESTARTS   AGE
etcd-0               1/1       Running       0          54s
etcd-2               1/1       Running       0          51s
```
After a while:
```
$ kubectl get pods -l "app=etcd"
NAME                 READY     STATUS    RESTARTS   AGE
etcd-0               1/1       Running   0          1m
etcd-1               1/1       Running   0          20s
etcd-2               1/1       Running   0          1m
```
You can check state of re-joining from etcd-1's logs:
```
$ kubectl logs etcd-1
Waiting for etcd-0.etcd to come up
Waiting for etcd-1.etcd to come up
ping: bad address 'etcd-1.etcd'
Waiting for etcd-1.etcd to come up
Waiting for etcd-2.etcd to come up
Re-joining etcd member
Updated member with ID 7fd61f3f79d97779 in cluster
2016-06-20 11:04:14.962169 I | etcdmain: etcd Version: 2.2.5
2016-06-20 11:04:14.962287 I | etcdmain: Git SHA: bc9ddf2
```
...
Scaling using kubectl
This is for reference. Scaling should be managed by helm upgrade

The etcd cluster can be scale up by running kubectl patch or kubectl edit. For instance,
```
$ kubectl get pods -l "app=etcd"
NAME      READY     STATUS    RESTARTS   AGE
etcd-0    1/1       Running   0          7m
etcd-1    1/1       Running   0          7m
etcd-2    1/1       Running   0          6m
```

$ kubectl patch statefulset/etcd -p '{"spec":{"replicas": 5}}'
"etcd" patched

```
$ kubectl get pods -l "app=etcd"
NAME      READY     STATUS    RESTARTS   AGE
etcd-0    1/1       Running   0          8m
etcd-1    1/1       Running   0          8m
etcd-2    1/1       Running   0          8m
etcd-3    1/1       Running   0          4s
etcd-4    1/1       Running   0          1s
Scaling-down is similar. For instance, changing the number of replicas to 4:
```

```
$ kubectl edit statefulset/etcd
statefulset "etcd" edited

```
$ kubectl get pods -l "app=etcd"
NAME      READY     STATUS    RESTARTS   AGE
etcd-0    1/1       Running   0          8m
etcd-1    1/1       Running   0          8m
etcd-2    1/1       Running   0          8m
etcd-3    1/1       Running   0          4s
```
```
Once a replica is terminated (either by running kubectl delete pod etcd-ID or scaling down), content of /var/run/etcd/ directory is cleaned up. If any of the etcd pods restarts (e.g. caused by etcd failure or any other), the directory is kept untouched so the pod can recover from the failure.


## Other commands

Get all keys
 `ETCDCTL_API=3 etcdctl get "" --prefix --keys-only | sed '/^\s*$/d'`

 Delete keys
  `ETCDCTL_API=3 etcdctl del --prefix /`

## Debugging

https://github.com/etcd-io/etcd/blob/master/Documentation/op-guide/monitoring.md
