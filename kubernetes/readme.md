## Configure the Docker credentials in the cluster
```shell
kubectl create secret generic regcred --from-file=.dockerconfigjson=k8s/docker-config.json --type=kubernetes.io/dockerconfigjson
```