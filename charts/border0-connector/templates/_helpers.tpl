{{/*
Expand the name of the chart.
*/}}
{{- define "border0-connector.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "border0-connector.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "border0-connector.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "border0-connector.labels" -}}
helm.sh/chart: {{ include "border0-connector.chart" . }}
{{ include "border0-connector.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "border0-connector.selectorLabels" -}}
app.kubernetes.io/name: {{ include "border0-connector.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Generate the name of the service account to use
*/}}
{{- define "border0-connector.generatedServiceAccountName" -}}
{{- if ne .Values.serviceAccount.name "" }}
{{- .Values.serviceAccount.name }}
{{- else }}
{{- include "border0-connector.fullname" . }}
{{- end }}
{{- end }}

{{/*
Generate the name of the cluster role to use
*/}}
{{- define "border0-connector.generatedClusterRoleName" -}}
{{- if ne .Values.rbac.name "" }}
{{- .Values.rbac.name }}
{{- else }}
{{- include "border0-connector.fullname" . }}
{{- end }}
{{- end }}

{{/*
Generate the name of the role to use for secret management
*/}}
{{- define "border0-connector.generatedRoleName" -}}
{{- include "border0-connector.fullname" . }}-secret-manager
{{- end }}

{{/*
Generate the name of the secret to use
*/}}
{{- define "border0-connector.generatedSecretName" -}}
{{- include "border0-connector.fullname" . }}-config
{{- end }}

{{/*
Check if ClusterRole should be created based on rbac.clusterRoleMode
Returns "true" only if mode is "api-admin".
*/}}
{{- define "border0-connector.shouldCreateClusterRole" -}}
{{- $mode := .Values.rbac.clusterRoleMode | toString | trim -}}
{{- if eq $mode "api-admin" -}}
true
{{- end -}}
{{- end }}
