

{{- define "domain" -}}

  {{- if eq .Values.lifecycle "prod" }}
  {{- required "Google Domain Required" .Values.google.domain }}

  {{- else }}
  {{- .Values.lifecycle -}}.{{- required "Google Domain Required" .Values.google.domain }}

  {{- end }}

{{- end }}


{{- define "gke_project" -}}
  {{- required "REQUIRED: lifecycle_letter" .Values.lifecycle_letter -}}-{{- required "REQUIRED: proj_identifier" .Values.proj_identifier -}}-gke-project
{{- end -}}


{{- define "db_project" -}}
  {{- .Values.lifecycle_letter -}}-{{- .Values.proj_identifier -}}-db-project
{{- end -}}


{{- define "app_project" -}}
  {{- .Values.namespace -}}-app-project
{{- end -}}


{{- define "api_image" -}}
  {{- .Values.google.region -}}-docker.pkg.dev/{{- include "app_project" . -}}/{{- .Values.lifecycle -}}/api:{{- .Values.api.tag }}
{{- end -}}


{{- define "nginx_image" -}}
  {{- .Values.google.region -}}-docker.pkg.dev/{{- include "app_project" . -}}/{{- .Values.lifecycle -}}/nginx:{{- .Values.nginx.tag }}
{{- end -}}


{{- define "db_name" -}}
  {{- .Values.lifecycle -}}-db
{{- end -}}


{{- define "app_sa" -}}
  {{- .Values.namespace -}}-workload@{{- include "app_project" . -}}.iam
{{- end -}}


{{- define "bucket" -}}
  {{- .Values.lifecycle -}-{{- .Values.namespace -}}-web-static
{{- end -}}


{{- define "ip_name" -}}
  {{- .Values.namespace -}}-ip
{{- end -}}


