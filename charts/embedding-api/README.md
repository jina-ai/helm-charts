# Jina Operator

## Prerequisites

- Kubernetes 1.21+
- Helm 3+

## Get Repo Info 

```console
helm repo add jina-operator https://jina.ai/jina-operator/
helm repo update
```

_See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation._

## Install Chart

Currently, we can only deploy the helm chart locally.

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

### Example

Assuming you already has a cluster install components in `wolf-infra`:

1. configure `values.yaml`:

  ```yaml
  clusterid: test1
  apimanager:
    ingress:
      enabled: true
      hosts:
      - test123.wolf.jina.ai
      tls: 
        - secretName: wolf-tls
        hosts:
        - "*.wolf.jina.ai"
  operator:
    config:
        create: true
        mongo:
        url: https://test123.123.com
        operator: |
          network:
            domains:
            - name: "wolf.jina.ai"
                cert:
                namespace: "cert-manager"
                secret: "wolf-tls"
            - name: "docsqa.jina.ai"
                cert:
                namespace: "cert-manager"
                secret: "docsqa-tls"
            - name: "dev.jina.ai"
                cert:
                namespace: "cert-manager"
                secret: "dev-tls"
          storage:
            efs:
            name: test123
            handler: fs-xxxx
            ebs: test234
          nodegroups:
          - name: standard
            selector: 
            - jina.ai/node-type: "standard"
            - karpenter.sh/provisioner-name: "default"
          - name: gpu-shared
            selector: 
            - jina.ai/node-type: "gpu-shared"
            - karpenter.sh/provisioner-name: "gpu-shared"
            tolerations:
            - key: nvidia.com/gpu-shared
            operator: Exists
            effect: NoSchedule
          - name: gpu
            selector: 
            - jina.ai/node-type: "gpu"
            - karpenter.sh/provisioner-name: "gpu"
            tolerations:
            - key: nvidia.com/gpu
            operator: Exists
            effect: NoSchedule
  ```

2. Create tls secret to `jcloud` namespace(We will add this function to operator in future):
   ```console
	kubectl get secret wolf-tls --namespace=cert-manager -o yaml | grep -v '^\s*namespace:\s' | kubectl apply --namespace=jcloud -f -
    ```

3. Install the helm chart with example values:
   ```console
    helm install jina-operator . -n jcloud --create-namespace
    ```

## Configuration

See [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing). To see all configurable options with detailed comments, visit the chart's [values.yaml](./values.yaml), or run these configuration commands:

```console
helm show values .
```

You may similarly use the above configuration commands on each chart [dependency](#dependencies) to see it's configurations.

### RBAC Configuration

Roles and RoleBindings resources will be created automatically for `server` service.

> **Notice**: API manager and operator is now sharing that same kubernetes service account, which we will change in future release.

> **Tip**: You can refer to the default `*-clusterrole.yaml` and `*-clusterrolebinding.yaml` files in [templates](templates/) to customize your own.

### ConfigMap Files

Operator is configured through [operator-cfg.yaml](https://prometheus.io/docs/alerting/configuration/). This file  will be mounted into the `jina-operator` pod.

### Ingress TLS

If your cluster allows automatic creation/retrieval of TLS certificates (e.g. [cert-manager](https://github.com/jetstack/cert-manager)), please refer to the documentation for that mechanism.

To manually configure TLS, first create/retrieve a key & certificate pair for the address(es) you wish to protect. Then create a TLS secret in the namespace:

```console
kubectl create secret tls custom-tls --cert=path/to/tls.cert --key=path/to/tls.key -n jcloud
```

Include the secret's name, along with the desired hostnames, in the alertmanager/server Ingress TLS section of your custom `values.yaml` file:

```yaml
apimanager:
  ingress:
    enabled: true
    hosts:
    - test123.custom.domain
    tls: 
    - secretName: custom-tls
    hosts:
    - "test123.custom.domain"
```

Update in `operator` for flow ingress:

```yaml
operator:
  config:
    create: true
    mongo:
      url: https://test123.123.com
    operator: |
      network:
        domains:
          - name: "custom.domain"
            cert:
              namespace: "jcloud"
              secret: "custom-tls"
      storage:
        efs:
          name: test123
          handler: fs-xxxx
        ebs: test234
      nodegroups:
      - name: standard
        selector: 
        - jina.ai/node-type: "standard"
        - karpenter.sh/provisioner-name: "default"
```

### NetworkPolicy

TODO
