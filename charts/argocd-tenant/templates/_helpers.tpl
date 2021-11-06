
{{- define "targetRevision" -}}

  {{- if .Values.source.targetRevision }}
    {{- .Values.source.targetRevision }}

  {{- else if eq .Values.lifecycle "prod" }}
    {{- "main" -}}

  {{- else }}
    {{- required "REQUIRED: values.lifecycle" .Values.lifecycle }}

  {{- end }}

{{- end }}