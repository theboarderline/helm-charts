
{{- define "lifecycle" -}}
  {{- required "REQUIRED: lifecycle" $.Values.lifecycle -}}
{{- end }}


{{- define "sa_project_id" -}}
  {{- required "REQUIRED: sa_project_id" $.Values.sa_project_id -}}
{{- end -}}


{{- define "gke_project_id" -}}
  {{- required "REQUIRED: gke_project_id" $.Values.gke_project_id -}}
{{- end -}}


{{- define "db_project_id" -}}
  {{- required "REQUIRED: db_project_id " $.Values.db_project_id -}}
{{- end -}}


{{- define "apps_admin_sa" -}}
  {{- required "REQUIRED: apps_admin_sa " $.Values.apps_admin_sa -}}
{{- end }}

