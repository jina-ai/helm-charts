# The Jina Helm Chart Repository

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Chart Publish](https://github.com/jina-ai/helm-charts/actions/workflows/publish.yml/badge.svg?branch=master)](https://github.com/jina-ai/helm-charts/actions/workflows/publish.yml)


Jina-powered applications, ready to launch on Kubernetes using [Kubernetes Helm](https://github.com/helm/helm).

Currently, the available charts are:

- [clip-on-k8s](./charts/clip-on-k8s/README.md)


## TL;DR

```bash
$ helm repo add jina https://jina.ai/helm-charts/
$ helm search repo jina
$ helm install my-release jina/<chart-name>
```

## Setup

### Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+

### Setup a Kubernetes Cluster

For setting up Kubernetes, please refer to the Kubernetes [getting started guide](https://kubernetes.io/docs/getting-started-guides/).

### Install Helm

[Helm](https://helm.sh/) is a tool for managing Kubernetes charts. Charts are packages of pre-configured Kubernetes resources.

To install Helm, refer to the [Helm install guide](https://github.com/helm/helm#install) and ensure that the helm binary is in the PATH of your shell.

### Add repo

The following command allows you to download and install all the charts from this repository:

```bash
$ helm repo add jina https://jina.ai/helm-charts/
```

### Using Helm

Once you have installed the Helm client, you can deploy a Jina Helm Chart into a Kubernetes cluster.

Please refer to the [Quick Start guide](https://helm.sh/docs/intro/quickstart/) if you wish to get running in just a few commands, otherwise the [Using Helm Guide](https://helm.sh/docs/intro/using_helm/) provides detailed instructions on how to use the Helm client to manage packages on your Kubernetes cluster.

Useful Helm Client Commands:
* View available charts: `helm search repo`
* Install a chart: `helm install my-release jina/<chart-name>`
* Upgrade your application: `helm upgrade`

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


