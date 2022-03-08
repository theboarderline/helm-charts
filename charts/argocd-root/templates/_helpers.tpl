
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


{{- define "sa_project_id" -}}
  {{- required "REQUIRED: sa_project_id" .Values.sa_project_id }}
{{- end -}}


{{- define "cpl_sa_project_id" -}}
  {{- include "lifecycle_letter" $ -}}-cpl-svc-acct-project
{{- end -}}
