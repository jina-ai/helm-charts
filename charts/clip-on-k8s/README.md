# clip-on-k8s

A Helm chart for Clip-as-Service (https://clip-as-service.jina.ai/)

**Homepage:** <https://github.com/numb3r3/charts>

## Maintainers

| Name   | Email | Url                    |
|--------| ------ |------------------------|
| Felix  |  | <https://github.com/numb3r3> |

## Source Code

* <https://github.com/numb3r3/clip-on-k8s>
* <https://github.com/jina-ai/clip-as-service>

## Values

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
| modelName                  | string | `"Vit-B/16"`             | Model name to use for inference execut, default is ViT-B/32. Support all OpenAI released pretrained models                    |
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

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.9.1](https://github.com/norwoodj/helm-docs/releases/v1.9.1)