{{/*
Expand the name of the chart.
*/}}
{{- define "test-chart-1.name" -}}
  {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "test-chart-1.fullname" -}}
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
{{- define "test-chart-1.chart" -}}
  {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "test-chart-1.labels" -}}
helm.sh/chart: {{ include "test-chart-1.chart" . }}
{{ include "test-chart-1.selectorLabels" . }}
app.kubernetes.io/version: {{ coalesce .Values.image.tag .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: chatbot-ui
app.kubernetes.io/part-of: talk-to-the-power-system
{{- if .Values.labels }}
{{ tpl (toYaml .Values.labels) . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "test-chart-1.selectorLabels" -}}
app.kubernetes.io/name: {{ include "test-chart-1.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "test-chart-1.serviceAccountName" -}}
  {{- if .Values.serviceAccount.create }}
    {{- default (include "test-chart-1.fullname" .) .Values.serviceAccount.name }}
  {{- else }}
    {{- default "default" .Values.serviceAccount.name }}
  {{- end }}
{{- end }}

{{/*
Returns the namespace of the release.
*/}}
{{- define "test-chart-1.namespace" -}}
  {{- .Values.namespaceOverride | default .Release.Namespace | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Returns the name of the ConfigMap resource used for the runtime environment configurations.
*/}}
{{- define "test-chart-1.fullname.config.properties" -}}
  {{- printf "%s-%s" (include "test-chart-1.fullname" .) "properties" -}}
{{- end -}}

{{/*
Returns the name of the ConfigMap resource used for the runtime environment configurations.
*/}}
{{- define "test-chart-1.fullname.agent.config" -}}
  {{- printf "%s-%s" (include "test-chart-1.fullname" .) "agent-configuration" -}}
{{- end -}}
