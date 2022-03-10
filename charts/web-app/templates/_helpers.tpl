
{{- define "lifecycle_letter" -}}

  {{- substr 0 1 .Values.lifecycle -}}

{{- end }}


{{- define "base_domain" -}}
  {{- if .Values.domain }}
    {{- .Values.domain }}
  {{ else if .Values.google.domain }}
    {{- .Values.google.domain }}
  {{- end }}
{{- end }}

{{- define "domain" -}}
  {{- if eq .Values.lifecycle "prod" }}
    {{- include "base_domain" $ }}
  {{- else }}
    {{- required "REQUIRED: lifecycle" .Values.lifecycle -}}.{{- include "base_domain" $ }}
  {{- end }}
{{- end }}


{{- define "db_project" -}}
  {{- if .Values.db_project_id }}
  {{- .Values.db_project_id }}
  {{- else }}
  {{- include "lifecycle_letter" . -}}-{{- required "REQUIRED: .proj_identifier" .Values.proj_identifier -}}-db-project
  {{- end }}
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
  {{- required "REQUIRED: app_code" .Values.app_code -}}-workload@{{- include "app_project" . -}}.iam
{{- end -}}


{{- define "ksa_name" -}}
  {{- required "REQUIRED: app_code" .Values.app_code -}}-sa
{{- end -}}


{{- define "bucket" -}}
  {{- .Values.lifecycle -}}-{{- required "REQUIRED: app_code" .Values.app_code -}}-web-static
{{- end -}}


{{- define "private_bucket" -}}
  {{- .Values.lifecycle -}}-{{- required "REQUIRED: app_code" .Values.app_code -}}-private
{{- end -}}


{{- define "ip_name" -}}
  {{- .Values.lifecycle -}}-{{- required "REQUIRED: app_code" .Values.app_code -}}-ip
{{- end -}}


