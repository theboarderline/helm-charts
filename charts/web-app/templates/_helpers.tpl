
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


{{- define "registry_name" -}}
  {{- required "REQUIRED: lifecycle" .Values.lifecycle }}-{{- .Values.app_code -}}-v2-images
{{- end -}}


{{- define "primary_cluster" -}}
  {{- required "REQUIRED: primary_cluster" .Values.primary_cluster }}
{{- end -}}


{{- define "sa_project_id" -}}
  {{- required "REQUIRED: sa_project_id" .Values.sa_project_id }}
{{- end -}}


{{- define "db_project" -}}
  {{- required "REQUIRED: db_project_id" .Values.db_project_id }}
{{- end -}}


{{- define "app_project" -}}
  {{- required "REQUIRED: app_code" .Values.app_code -}}-app-project
{{- end -}}


{{- define "api_image" -}}
  {{- "gcr.io" -}}/{{- include "app_project" . -}}/{{- include "registry_name" . -}}/api:{{- .Values.api.tag }}
{{- end -}}


{{- define "nginx_image" -}}
  {{- "gcr.io" -}}/{{- include "app_project" . -}}/{{- include "registry_name" . -}}/react:{{- .Values.nginx.tag }}
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


{{- define "app_admin_sa" -}}
  {{- if $.Values.sa }}
    {{- $.Values.app_sa }}
  {{- else }}
    {{- required "REQUIRED: app_code" .Values.app_code -}}-admin@{{- include "sa_project_id" . -}}.iam.gserviceaccount.com
  {{- end }}
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
  {{- .Values.lifecycle -}}-{{- required "REQUIRED: app_code" .Values.app_code -}}-v2-web-static
{{- end -}}


{{- define "ingest_bucket" -}}
  {{- .Values.lifecycle -}}-{{- required "REQUIRED: app_code" .Values.app_code -}}-v2-ingest
{{- end -}}


{{- define "clean_data_bucket" -}}
  {{- .Values.lifecycle -}}-{{- required "REQUIRED: app_code" .Values.app_code -}}-v2-cleaned-data
{{- end -}}


{{- define "ip_name" -}}
  {{- required "REQUIRED: lifecycle" .Values.lifecycle }}-{{- .Values.app_code -}}-v2-ip
{{- end -}}


