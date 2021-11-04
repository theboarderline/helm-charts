
{{- define "targetRevision" -}}

  {{- if eq .Values.values.lifecycle "prod" }}
    {{- required "REQUIRED: values.lifecycle" .Values.values.lifecycle }}

  {{- else }}
    {{- required "REQUIRED: values.lifecycle" .Values.values.lifecycle }}

  {{- end }}

{{- end }}