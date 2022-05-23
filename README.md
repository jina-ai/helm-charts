# Helm Charts

This is where I keep my helm charts!

Currently, the available charts are:

- [clip-on-k8s](./charts/clip-on-k8s/README.md)

## Install a chart

Assuming you have [Helm](https://helm.sh/) installed,

```sh
helm repo add jina https://numb3r3.github.io/helm-charts/
helm upgrade --cleanup-on-fail --install \
  -n jina-clip-on-k8s \
  --create-namespace my-clip-on-k8s \
  jina/cas-helm
```

For customization options, see the README.md for [each chart](./charts/).