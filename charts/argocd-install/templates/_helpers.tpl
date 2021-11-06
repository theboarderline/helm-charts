

{{- define "domain" -}}

  {{- if eq .Values.lifecycle "prod" }}
  {{- required "ArgoCD Domain Required" .Values.domain }}

  {{- else }}
  {{- .Values.lifecycle -}}.{{- required "ArgoCD Domain Required" .Values.domain }}

  {{- end }}

{{- end }}
