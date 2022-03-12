
{{- define "domain" -}}
  {{- if .Values.lifecycle }}
    {{- if eq .Values.lifecycle "prod" }}
      {{- required "REQUIRED: domain" .Values.domain }}
    {{- else }}
      {{- .Values.lifecycle -}}.{{- required "REQUIRED: domain" .Values.domain }}
    {{- end }}
  {{- else }}
    {{- .Values.domain -}}
  {{- end }}
{{- end }}


{{- define "db_project" -}}
  {{- required "REQUIRED: db_project_id" .Values.db_project_id }}
{{- end -}}


{{- define "app_project" -}}
  {{- required "REQUIRED: app_code" .Values.app_code -}}-app-project
{{- end -}}


{{- define "api_image" -}}
  {{- .Values.google.region -}}-docker.pkg.dev/{{- include "app_project" . -}}/{{- .Values.lifecycle -}}/api:{{- .Values.api.tag }}
{{- end -}}


{{- define "nginx_image" -}}
  {{- .Values.google.region -}}-docker.pkg.dev/{{- include "app_project" . -}}/{{- .Values.lifecycle -}}/nginx:{{- .Values.nginx.tag }}
{{- end -}}


{{- define "agile_image" -}}
  {{- .Values.google.region -}}-docker.pkg.dev/{{- include "app_project" . -}}/{{- .Values.lifecycle -}}/agile-connector:{{- .Values.api.tag }}
{{- end -}}


{{- define "db_name" -}}
  {{- .Values.lifecycle -}}-db
{{- end -}}


{{- define "instance_name" -}}
  {{- if .Values.db.instance }}
    {{- .Values.db.instance }}
  {{- else -}}
    {{- required "REQUIRED: app_code" .Values.app_code -}}-instance
  {{- end -}}
{{- end -}}


{{- define "app_sa" -}}
  {{- if $.Values.sa }}
    {{- $.Values.app_sa }}
  {{- else }}
    {{- required "REQUIRED: app_code" .Values.app_code -}}-workload@{{- include "app_project" . -}}.iam
  {{- end }}
{{- end -}}


{{- define "ksa_name" -}}
  {{- required "REQUIRED: app_code" .Values.app_code -}}-sa
{{- end -}}


{{- define "bucket" -}}
  {{- if $.Values.public_bucket }}
    {{- $.Values.public_bucket }}
  {{- else }}
    {{- .Values.lifecycle -}}-{{- required "REQUIRED: app_code" .Values.app_code -}}-web-static
  {{- end }}
{{- end -}}




{{- define "private_bucket" -}}
  {{- if $.Values.private_bucket }}
    {{- $.Values.private_bucket }}
  {{- else }}
  {{- .Values.lifecycle -}}-{{- required "REQUIRED: app_code" .Values.app_code -}}-private
  {{- end }}
{{- end -}}


{{- define "ip_name" -}}
  {{- if $.Values.ip_name }}
    {{- $.Values.ip_name }}
  {{- else }}
    {{- $.Values.lifecycle -}}-{{- required "REQUIRED: app_code" .Values.app_code -}}-ip
  {{- end }}
{{- end -}}


