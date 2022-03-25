
{{- define "lifecycle" -}}
  {{- required "REQUIRED: lifecycle" $.Values.lifecycle -}}
{{- end }}


{{- define "sa_project_id" -}}
  {{- required "REQUIRED: sa_project_id " $.Values.sa_project_id -}}
{{- end -}}


{{- define "gke_project_id" -}}
  {{- required "REQUIRED: gke_project_id" $.Values.gke_project_id -}}
{{- end -}}


{{- define "db_project_id" -}}
  {{- required "REQUIRED: db_project_id " $.Values.db_project_id -}}
{{- end -}}


{{- define "app_project_id" -}}
  {{- required "REQUIRED app_code" .Values.app_code -}}-app-project
{{- end -}}


{{- define "app_admin_sa" -}}
  {{- include "app_namespace" $ }}-infra-admin@{{- include "sa_project_id" . -}}.iam.gserviceaccount.com
{{- end }}


{{- define "app_namespace" }}
  {{- include "lifecycle" $ -}}-{{- required "REQUIRED: app_code" .Values.app_code }}
{{- end }}


{{- define "ip_name" }}
  {{- include "app_namespace" $ }}-ip
{{- end }}



{{- define "branch" -}}
  {{- if eq .Values.lifecycle "prod" }}
    {{- "main" }}
  {{- else }}
    {{- include "lifecycle" $ }}
  {{- end }}
{{- end }}


{{- define "domain" -}}
  {{- if eq .Values.lifecycle "prod" }}
    {{- required "REQUIRED: domain" .Values.domain }}
  {{- else }}
    {{- include "lifecycle" $ -}}.{{- required "REQUIRED: domain" .Values.domain }}
  {{- end }}
{{- end }}


{{- define "app_sa" -}}
  {{- include "app_namespace" $ }}-app-workload@{{- include "sa_project_id" . -}}.iam
{{- end -}}


{{- define "cicd_sa" -}}
  {{- "projects/" -}}{{- include "app_project_id" $ }}/serviceAccounts/{{ include "lifecycle" $ }}-{{- required "REQUIRED app_code" .Values.app_code -}}-cicd@{{- include "app_project_id" . }}.iam.gserviceaccount.com
{{- end -}}


{{- define "artifact_repo" -}}
  {{- "us-central1-docker.pkg.dev/" -}}{{- include "app_project_id" $ -}}/{{- include "lifecycle" $ -}}-{{- required "REQUIRED google.artifact_repo" .Values.google.artifact_repo }}
{{- end -}}


{{- define "api_image" -}}
  {{- include "artifact_repo" $ }}/api
{{- end -}}


{{- define "nginx_image" -}}
  {{- include "artifact_repo" $ }}/nginx
{{- end -}}


{{- define "etl_bucket" -}}
  {{- include "app_namespace" $ -}}-etl-bucket
{{- end -}}


{{- define "public_bucket" -}}
  {{- include "app_namespace" $ -}}-public-content-bucket
{{- end -}}


{{- define "cluster_name"  -}}
  {{- "central-cluster" -}}
{{- end }}
