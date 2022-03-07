
{{- define "targetRevision" -}}
  {{- if .Values.targetRevision }}
    {{- .Values.targetRevision }}

  {{- else if .Values.lifecycle }}
    {{- if eq .Values.lifecycle "prod" }}
      {{- "main" }}

    {{- else }}
      {{- required "REQUIRED: values.lifecycle" .Values.lifecycle }}

    {{- end }}
  {{- else }}
    HEAD
  {{- end }}
{{- end }}



{{- define "repo_url" -}}
  {{- "git@github.com:theboarderline/" -}}{{- required "REQUIRED: repo_name" .Values.repo_name }}
{{- end }}
