{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "jina-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "jina-operator.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "jina-operator.flow-operator-name" -}}
{{- if .Values.flowOperatorNameOverride -}}
{{- .Values.flowOperatorNameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "flow-%s" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "flow-%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "jina-operator.deployment-operator-name" -}}
{{- if .Values.deploymentOperatorNameOverride -}}
{{- .Values.deploymentOperatorNameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "deployment-%s" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "deployment-%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "jina-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Fullname suffixed with api manager
*/}}
{{- define "api-manager.fullname" -}}
{{- printf "%s-api-manager" (include "jina-operator.fullname" .) -}}
{{- end -}}

{{/*
Create the name of the jina operator service account
*/}}
{{- define "jina-operator.serviceAccountName" -}}
{{- if .Values.operator.rbac.serviceAccount.create -}}
    {{ default (include "jina-operator.fullname" .) .Values.operator.rbac.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.operator.rbac.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the api manager service account
*/}}
{{- define "api-manager.serviceAccountName" -}}
{{- if .Values.apimanager.rbac.serviceAccount.create -}}
    {{ default (include "api-manager..fullname" .) .Values.apimanager.rbac.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.apimanager.rbac.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts
*/}}
{{- define "jina-operator.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/*
generic labels
*/}}
{{- define "generic.labels" -}}
helm.sh/chart: {{ include "jina-operator.chart" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: {{ include "jina-operator.name" . }}
{{- if .Values.commonLabels }}
{{ toYaml .Values.commonLabels }}
{{- end }}
{{- end -}}

{{/*
operator labels
*/}}
{{- define "jina-operator.labels" -}}
{{ include "jina-operator.selectorLabels" . }}
{{ include "generic.labels" . }}
{{- if .Values.operator.extraLabels }}
{{ toYaml .Values.operator.extraLabels }}
{{- end }}
{{- end -}}

{{/*
operator Selector labels
*/}}
{{- define "jina-operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "jina-operator.name" . }}
{{- end -}}

{{/*
flow operator Selector labels
*/}}
{{- define "jina-operator.flowOperatorSelectorLabels" -}}
app.kubernetes.io/name: {{ include "jina-operator.flow-operator-name" . }}
{{- end -}}

{{/*
deployment operator Selector labels
*/}}
{{- define "jina-operator.deploymentOperatorSelectorLabels" -}}
app.kubernetes.io/name: {{ include "jina-operator.deployment-operator-name" . }}
{{- end -}}

{{/*
api manager labels
*/}}
{{- define "api-manager.labels" -}}
{{ include "api-manager.selectorLabels" . }}
{{ include "generic.labels" . }}
{{- if .Values.apimanager.extraLabels }}
{{ toYaml .Values.apimanager.extraLabels }}
{{- end }}
{{- end -}}

{{/*
api manager Selector labels
*/}}
{{- define "api-manager.selectorLabels" -}}
app.kubernetes.io/name: {{ include "api-manager.fullname" . }}
{{- end -}}

{{/*
Return the appropriate apiVersion for rbac.
*/}}
{{- define "jina-operator.rbac.apiVersion" -}}
  {{- if .Capabilities.APIVersions.Has "rbac.authorization.k8s.io/v1" }}
    {{- print "rbac.authorization.k8s.io/v1" -}}
  {{- else -}}
    {{- print "rbac.authorization.k8s.io/v1beta1" -}}
  {{- end -}}
{{- end -}}
{{/*
Return the appropriate apiVersion for ingress.
*/}}
{{- define "jina-operator.ingress.apiVersion" -}}
  {{- if and (.Capabilities.APIVersions.Has "networking.k8s.io/v1") (semverCompare ">= 1.19-0" .Capabilities.KubeVersion.Version) -}}
      {{- print "networking.k8s.io/v1" -}}
  {{- else if .Capabilities.APIVersions.Has "networking.k8s.io/v1beta1" -}}
    {{- print "networking.k8s.io/v1beta1" -}}
  {{- else -}}
    {{- print "extensions/v1beta1" -}}
  {{- end -}}
{{- end -}}
{{/*
Return the appropriate apiVersion for podDisruptionBudget.
*/}}
{{- define "jina-operator.podDisruptionBudget.apiVersion" -}}
  {{- if $.Capabilities.APIVersions.Has "policy/v1/PodDisruptionBudget" -}}
    {{- print "policy/v1" -}}
  {{- else -}}
    {{- print "policy/v1beta1" -}}
  {{- end -}}
{{- end -}}
{{/*
Return if ingress is stable.
*/}}
{{- define "jina-operator.ingress.isStable" -}}
  {{- eq (include "jina-operator.ingress.apiVersion" .) "networking.k8s.io/v1" -}}
{{- end -}}
{{/*
Return if ingress supports ingressClassName.
*/}}
{{- define "jina-operator.ingress.supportsIngressClassName" -}}
  {{- or (eq (include "jina-operator.ingress.isStable" .) "true") (and (eq (include "jina-operator.ingress.apiVersion" .) "networking.k8s.io/v1beta1") (semverCompare ">= 1.18-0" .Capabilities.KubeVersion.Version)) -}}
{{- end -}}
{{/*
Return if ingress supports pathType.
*/}}
{{- define "jina-operator.ingress.supportsPathType" -}}
  {{- or (eq (include "jina-operator.ingress.isStable" .) "true") (and (eq (include "jina-operator.ingress.apiVersion" .) "networking.k8s.io/v1beta1") (semverCompare ">= 1.18-0" .Capabilities.KubeVersion.Version)) -}}
{{- end -}}