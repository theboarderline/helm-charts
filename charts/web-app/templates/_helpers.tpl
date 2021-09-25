{{- define "walker-chart.api_image" -}}
  "{{ .Values.google.region }}-docker.pkg.dev/{{ .Values.app_code }}-{{ .Values.lifecycle }}-cicd-proj/api-repo/api:{{ .Values.api.tag }}"
{{- end -}}

{{- define "walker-chart.nginx_image" -}}
  "{{ .Values.google.region }}-docker.pkg.dev/{{ .Values.app_code }}-{{ .Values.lifecycle }}-cicd-proj/nginx-repo/nginx:{{ .Values.nginx.tag }}"
{{- end -}}

{{- define "walker-chart.iac_project" -}}
  {{ .Values.lifecycle }}-iac-proj
{{- end -}}

{{- define "walker-chart.gke_project" -}}
  {{ .Values.lifecycle }}-gke-proj
{{- end -}}

{{- define "walker-chart.db_project" -}}
  {{ .Values.lifecycle }}-db-proj
{{- end -}}

{{- define "walker-chart.cicd_project" -}}
  {{ .Values.app_code }}-{{ .Values.lifecycle }}-cicd-proj
{{- end -}}

{{- define "walker-chart.dns_project" -}}
  {{ .Values.app_code }}-{{ .Values.lifecycle }}-dns-proj
{{- end -}}

{{- define "walker-chart.db_name" -}}
  "{{ .Values.app_code }}-db"
{{- end -}}

{{- define "walker-chart.db_user" -}}
  "gke-worker@{{ .Values.lifecycle }}-gke-proj.iam"
{{- end -}}

{{- define "walker-chart.bucket" -}}
  "{{ .Values.app_code }}-{{ .Values.lifecycle }}-static"
{{- end -}}

{{- define "walker-chart.ip_name" -}}
  "{{ .Values.app_code }}-ip"
{{- end -}}

{{- define "walker-chart.firebase_domain" -}}
  "{{ .Values.app_code }}-{{ .Values.lifecycle }}-oauth-proj.firebaseapp.com"
{{- end -}}

{{- define "walker-chart.config_connect.service_account" -}}
  {{ .Values.app_code }}-app@{{ include "walker-chart.iac_project" . }}.iam.gserviceaccount.com
{{- end -}}

