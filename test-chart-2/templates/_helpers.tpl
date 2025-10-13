{{/*
Combined image pull secrets
*/}}
{{- define "test-chart-2.combinedImagePullSecrets" -}}
  {{- $secrets := concat .Values.global.imagePullSecrets .Values.image.pullSecrets }}
  {{- tpl (toYaml $secrets) . -}}
{{- end -}}

{{/*
Renders the container image for test-chart-2
*/}}
{{- define "test-chart-2.image" -}}
  {{- $repository := .Values.image.repository -}}
  {{- $tag := .Values.image.tag | default .Chart.AppVersion | toString -}}
  {{- $image := printf "%s:%s" $repository $tag -}}
  {{/* Add registry if present */}}
  {{- $registry := .Values.global.imageRegistry | default .Values.image.registry -}}
  {{- if $registry -}}
    {{- $image = printf "%s/%s" $registry $image -}}
  {{- end -}}
  {{/* Add SHA digest if provided */}}
  {{- if .Values.image.digest -}}
    {{- $image = printf "%s@%s" $image .Values.image.digest -}}
  {{- end -}}
  {{- $image -}}
{{- end -}}
