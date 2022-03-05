
{{- define "lifecycle_letter" -}}

  {{- substr 0 1 .Values.lifecycle -}}

{{- end }}


{{- define "domain" -}}

  {{- if eq .Values.lifecycle "prod" }}
  {{- required "Google Domain Required" .Values.google.domain }}

  {{- else }}
  {{- .Values.lifecycle -}}.{{- required "Google Domain Required" .Values.google.domain }}

  {{- end }}

{{- end }}


{{- define "gke_project" -}}
  {{- include "lifecycle_letter" . -}}-{{- required "REQUIRED: proj_identifier" .Values.proj_identifier -}}-gke-project
{{- end -}}


{{- define "db_project" -}}
  {{- include "lifecycle_letter" . -}}-{{- .Values.proj_identifier -}}-db-project
{{- end -}}


{{- define "app_project" -}}
  {{- .Release.Namespace -}}-app-project
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
    {{- .Release.Namespace -}}-instance
  {{- end -}}

{{- end -}}


{{- define "app_sa" -}}
  {{- .Release.Namespace -}}-workload@{{- include "app_project" . -}}.iam
{{- end -}}


{{- define "bucket" -}}
  {{- .Values.lifecycle -}}-{{- .Release.Namespace -}}-web-static
{{- end -}}


{{- define "private_bucket" -}}
  {{- .Values.lifecycle -}}-{{- .Release.Namespace -}}-private
{{- end -}}


{{- define "ip_name" -}}
  {{- .Release.Namespace -}}-ip
{{- end -}}


