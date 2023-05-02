
{{- define "lifecycle" -}}
  {{- required "REQUIRED: lifecycle" .Values.lifecycle -}}
{{- end }}


{{- define "domain" -}}
  {{- required "REQUIRED: domain" .Values.domain }}
{{- end }}


{{- define "subdomain" -}}
  {{- if eq .Values.lifecycle "prod" }}
    {{- include "domain" . }}
  {{- else }}
    {{- include "lifecycle" $ -}}.{{- include "domain" . }}
  {{- end }}
{{- end }}


{{- define "branch" -}}
  {{- if eq .Values.lifecycle "prod" }}
    {{- "main" }}
  {{- else }}
    {{- include "lifecycle" $ -}}
  {{- end }}
{{- end }}


{{- define "app_label" -}}
  {{- include "lifecycle" $ -}}-{{- required "REQUIRED: app_code" .Values.app_code -}}
{{- end }}


{{- define "registry_name" -}}
  {{- include "lifecycle" $ -}}
{{- end -}}


{{- define "primary_cluster_name" -}}
  {{- required "REQUIRED: primary_cluster_name" .Values.primary_cluster_name }}
{{- end -}}


{{- define "primary_cluster" -}}
  {{- required "REQUIRED: primary_cluster" .Values.primary_cluster }}
{{- end -}}


{{- define "sa_project_id" -}}
  {{- required "REQUIRED: sa_project_id" .Values.sa_project_id }}
{{- end -}}


{{- define "gke_project" -}}
  {{- required "REQUIRED: gke_project_id" .Values.gke_project_id }}
{{- end -}}


{{- define "db_project" -}}
  {{- required "REQUIRED: db_project_id" .Values.db_project_id }}
{{- end -}}


{{- define "app_project" -}}
  {{- required "REQUIRED: app_code" .Values.app_code -}}-app-project
{{- end -}}


{{- define "api_registry" -}}
  {{- required "REQUIRED: google.registry" .Values.google.registry -}}/{{- include "app_project" . -}}/{{- include "registry_name" . -}}/api
{{- end -}}


{{- define "nginx_registry" -}}
  {{- required "REQUIRED: google.registry" .Values.google.registry -}}/{{- include "app_project" . -}}/{{- include "registry_name" . -}}/react
{{- end -}}


{{- define "graphql_registry" -}}
  {{- required "REQUIRED: google.registry" .Values.google.registry -}}/{{- include "app_project" . -}}/{{- include "registry_name" . -}}/graphql
{{- end -}}


{{- define "importer_registry" -}}
  {{- required "REQUIRED: google.registry" .Values.google.registry -}}/{{- include "app_project" . -}}/{{- include "registry_name" . -}}/importer
{{- end -}}


{{- define "api_image" -}}
  {{- include "api_registry" . -}}:{{- .Values.api.tag }}
{{- end -}}


{{- define "graphql_image" -}}
  {{- include "graphql_registry" . -}}:{{- .Values.graphql.tag }}
{{- end -}}


{{- define "importer_image" -}}
  {{- include "importer_registry" . -}}:{{- .Values.importer.tag }}
{{- end -}}


{{- define "nginx_image" -}}
  {{- include "nginx_registry" . -}}:{{- .Values.nginx.tag }}
{{- end -}}

{{- define "crm_image" -}}
  {{- include "crm_registry" . -}}:{{- .Values.crm.tag }}
{{- end -}}

{{- define "selenium_image" -}}
  {{- include "selenium_registry" . -}}:{{- .Values.selenium.tag }}
{{- end -}}


{{- define "db_name" -}}
  {{- include "lifecycle" $ -}}-db
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


{{- define "cicd_sa" -}}
  {{- "projects/" -}}{{- include "app_project" $ }}/serviceAccounts/{{- include "app_label" $ -}}-cicd@{{- include "app_project" . }}.iam.gserviceaccount.com
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
  {{- include "app_label" $ -}}-v2-web-static
{{- end -}}


{{- define "ingest_bucket" -}}
  {{- include "app_label" $ -}}-v2-ingest
{{- end -}}


{{- define "clean_data_bucket" -}}
  {{- include "app_label" $ -}}-v2-cleaned-data
{{- end -}}


{{- define "ip_name" -}}
  {{- if .Values.ip_name }}
    {{- .Values.ip_name }}
  {{- else }}
    {{- include "app_label" $ -}}-ip
  {{- end }}
{{- end -}}


