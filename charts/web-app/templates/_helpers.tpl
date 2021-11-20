

{{- define "domain" -}}

  {{- if eq .Values.lifecycle "prod" }}
  {{- required "Google Domain Required" .Values.google.domain }}

  {{- else }}
  {{- .Values.lifecycle -}}.{{- required "Google Domain Required" .Values.google.domain }}

  {{- end }}

{{- end }}


{{- define "gke_project" -}}
  {{- .Values.lifecycle -}}-{{- .Values.proj_identifier -}}-gke-project
{{- end -}}


{{- define "db_project" -}}
  {{- .Values.lifecycle -}}-{{- .Values.proj_identifier -}}-db-project
{{- end -}}


{{- define "app_project" -}}
  {{- .Values.app_code -}}-{{- .Values.proj_identifier -}}-app-project
{{- end -}}


{{- define "api_image" -}}
  {{- .Values.google.region -}}-docker.pkg.dev/{{- include "app_project" . -}}/api-repo/{{- .Values.lifecycle -}}:{{- .Values.api.tag }}
{{- end -}}


{{- define "nginx_image" -}}
  {{- .Values.google.region -}}-docker.pkg.dev/{{- include "app_project" . -}}/nginx-repo/{{- .Values.lifecycle -}}:{{- .Values.nginx.tag }}
{{- end -}}


{{- define "db_name" -}}
  {{- .Values.lifecycle -}}-db
{{- end -}}


{{- define "app_sa" -}}
  {{- .Values.app_code -}}-app@{{- include "app_project" . -}}.iam
{{- end -}}


{{- define "bucket" -}}
  {{- .Values.app_code -}}-app-static
{{- end -}}


{{- define "ip_name" -}}
  {{- .Values.app_code -}}-ip
{{- end -}}


