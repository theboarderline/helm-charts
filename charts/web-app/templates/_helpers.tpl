

{{- define "walker-chart.domain" -}}

  {{- if eq .Values.lifecycle "prod" }}
  {{- required "Google Domain Required" .Values.google.domain }}

  {{- else }}
  {{- .Values.lifecycle -}}.{{- required "Google Domain Required" .Values.google.domain }}

  {{- end }}

{{- end }}


{{- define "walker-chart.gke_project" -}}
  {{- .Values.lifecycle -}}-{{- .Values.proj_identifier -}}-gke-project
{{- end -}}


{{- define "walker-chart.db_project" -}}
  {{- .Values.lifecycle -}}-{{- .Values.proj_identifier -}}-db-project
{{- end -}}


{{- define "walker-chart.app_project" -}}
  {{- .Values.app_code -}}-{{- .Values.proj_identifier -}}-app-project
{{- end -}}


{{- define "walker-chart.api_image" -}}
  {{- .Values.google.region -}}-docker.pkg.dev/{{- include "walker-chart.app_project" . -}}/api-repo/{{- .Values.lifecycle -}}:{{- .Values.api.tag }}
{{- end -}}


{{- define "walker-chart.nginx_image" -}}
  {{- .Values.google.region -}}-docker.pkg.dev/{{- include "walker-chart.app_project" . -}}/nginx-repo/{{- .Values.lifecycle -}}:{{- .Values.nginx.tag }}
{{- end -}}


{{- define "walker-chart.db_name" -}}
  {{- .Values.lifecycle -}}-db
{{- end -}}


{{- define "walker-chart.app_sa" -}}
  {{- .Values.app_code -}}-app@{{- include "walker-chart.app_project" . -}}.iam.gserviceaccount.com
{{- end -}}


{{- define "walker-chart.bucket" -}}
  {{- .Values.app_code -}}-app-static
{{- end -}}


{{- define "walker-chart.ip_name" -}}
  {{- .Values.app_code -}}-ip
{{- end -}}



