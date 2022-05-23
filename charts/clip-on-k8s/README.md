# Helm chart for CLIP-as-service

A Helm chart for [CLIP-as-service](https://clip-as-service.jina.ai/), which is 
a low-latency high-scalability service for embedding images and text. 
It can be easily integrated as a microservice into neural search solutions.


## TL;TD

```bash
$ helm repo add jina https://jina.ai/helm-charts/
$ helm install my-clip-release jina/cas-helm
```

Once this chart is deployed, you can upgrade the deployment via 

```bash
$ helm upgrade --cleanup-on-fail --install my-clip-release jina/cas-helm
```

## Introduction

This chart bootstraps a [CLIP-as-service](https://clip-as-service.jina.ai/) deployment on a **Kubernetes** cluster 
using the **Helm** package manager.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+

## Installing the Chart

To install the chart with the release name `my-clip-release` on the namespace `jina-clip-on-k8s`:

```bash
$ helm install my-clip-release jina/cas-helm
```

The command deploys CLIP-as-service on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-clip-release
```

## Parameters

| Key                        | Type   | Default                  | Description                                                                                                                   |
|----------------------------|--------|--------------------------|-------------------------------------------------------------------------------------------------------------------------------|
| fullnameOverride           | string | `""`                     |                                                                                                                               |
| image.pullPolicy           | string | `"IfNotPresent"`         | See [the kubernetes docs](https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy)                           |
| image.repository           | string | `"jinaai/clip_executor"` | Image to use for deploying, must support ENTRYPOINT[ "jina", "executor" ]                                                     |
| image.tag                  | string | `"master"`               | Tag of the image to use                                                                                                       |
| imagePullSecrets           | list   | `[]`                     |                                                                                                                               |
| gateway.port               | int    | `51000`                  |                                                                                                                               |
| gateway.protocol           | string | `grpc`                   |                                                                                                                               |
| replicas                   | int    | `1`                      | Number of replicas of clip inference executor to serve                                                                        |
| modelName                  | string | `"Vit-B/32"`              | Model name to use for inference execut, default is ViT-B/32. Support all OpenAI released pretrained models                    |
| deviceName                 | string | `"cpu"`                  | cuda or cpu. Default is None means auto-detect.                                                                               |
| nameOverride               | string | `""`                     |                                                                                                                               |
| nodeSelector               | object | `{}`                     | See [the Kubernetes docs](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector)              |
| podAnnotations             | object | `{}`                     | Extra annotations for all pods                                                                                                |
| podSecurityContext         | object | `{}`                     | Security context for the pods. The default container can run as any user/group and does not run with elevated                 |
| prometheus.expose          | bool   | `false`                  | If `true`, prometheus metrics are exposed on /metrics                                                                         |
| resources                  | object | `{}`                     | Resource limits and requests for the mlflow pods                                                                              |
| securityContext            | object | `{}`                     | Security context for the containers. Take presedence over podSecurityContext.                                                 |
| service.port               | int    | `5000`                   |                                                                                                                               |
| service.type               | string | `"ClusterIP"`            | See [the Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types) |
| serviceAccount.annotations | object | `{}`                     | Annotations to add to the service account                                                                                     |
| serviceAccount.create      | bool   | `true`                   | Specifies whether a service account should be created                                                                         |
| serviceAccount.name        | string | `""`                     | The name of the service account to use. If not set and create is true, a name is generated using the fullname template        |
| tolerations                | list   | `[]`                     | See [the Kubernetes docs](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)                      |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install my-clip-release \
    --set modelName=ViT-B/16 \
    jina/cas-helm
```

The above command sets the pretrained CLIP model name `modelName` to `ViT-B/16`.


Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
helm install my-clip-release -f values.yaml jina/cas-helm
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## License

Copyright 2020-2022 Jina AI Limited.  All rights reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.