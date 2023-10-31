
# JCloud Operator

  

## Prerequisites

  

- Kubernetes 1.27+

- Helm 3+


_See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation._

  

## Install Chart

  

-   Use Public chart:
    
    ```bash
    $ helm repo add jina <https://jina.ai/helm-charts/>
    $ helm search repo jina
    $ helm repo update
    $ helm install jcloud-operator jina/jcloud-operator -n jcloud --set apimanager.enable=false
    
    ```
    

Once the deployment is finished, you should see something like this in the shell output:

```bash
NAME: jcloud-operator
LAST DEPLOYED: Mon Jun  5 03:53:24 2023
NAMESPACE: jcloud
STATUS: deployed
REVISION: 1
TEST SUITE: None

```

You can validate if the operator is running by checking the pod status in `jcloud` namespace

```bash
$ kubectl get pods -n jcloud
NAME                                           READY   STATUS    RESTARTS   AGE
jcloud-operator-8467cdf5c6-7b5bq               2/2     Running   0          57m

```

  

```console

helm install [RELEASE_NAME] . -n jcloud --create-namespace

```

  

Since the repo is private, we can't download the release package directly. Below method will report 404 if you tried to download the release.

  

```console

helm install [RELEASE_NAME] jina-operator/jina-operator -n jcloud --create-namespace

```

  

_See [configuration](#configuration) below._

  

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

  

## Uninstall Chart

  

```console

helm uninstall [RELEASE_NAME] -n jcloud

```

  

This removes all the Kubernetes components associated with the chart and deletes the release.

  

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

  

## Upgrading Chart

  

```console

helm upgrade [RELEASE_NAME] [CHART] --install -n jcloud

```

  

_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

  


## Configuration

  

See [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing). To see all configurable options with detailed comments, visit the chart's [values.yaml](./values.yaml), or run these configuration commands:

  

```console

helm show values .

```

  

You may similarly use the above configuration commands on each chart [dependency](#dependencies) to see it's configurations.

  

### RBAC Configuration

  

Roles and RoleBindings resources will be created automatically for `server` service.

  

>  **Notice**: API manager and operator is now sharing that same kubernetes service account, which we will change in future release.

  

>  **Tip**: You can refer to the default `*-clusterrole.yaml` and `*-clusterrolebinding.yaml` files in [templates](templates/) to customize your own.

  

### ConfigMap Files

  

Operator is configured through [operator-cfg.yaml](https://prometheus.io/docs/alerting/configuration/). This file will be mounted into the `jina-operator` pod.

  

### Ingress TLS

  

If your cluster allows automatic creation/retrieval of TLS certificates (e.g. [cert-manager](https://github.com/jetstack/cert-manager)), please refer to the documentation for that mechanism.

  

To manually configure TLS, first create/retrieve a key & certificate pair for the address(es) you wish to protect. Then create a TLS secret in the namespace:

  

```console

kubectl create secret tls custom-tls --cert=path/to/tls.cert --key=path/to/tls.key -n jcloud

```

  

Include the secret's name, along with the desired hostnames, in the alertmanager/server Ingress TLS section of your custom `values.yaml` file:

