{{- define "mw-app.gke_project" -}}
  {{ .Values.k8s.lifecycle }}-anthos-gke-project
{{- end }}

{{- define "mw-app.api_image" -}}
  {{ .Values.google.region }}-docker.pkg.dev/{{ include "mw-app.gke_project" . }}/{{ required "Image repo required" .Values.images.repo }}/{{ .Values.images.api.name }}:{{ .Values.images.api.tag }}
{{- end }}

{{- define "mw-app.nginx_image" -}}
  {{ .Values.google.region }}-docker.pkg.dev/{{ include "mw-app.gke_project" . }}/{{ required "Image Repo required" .Values.images.repo }}/{{ .Values.images.nginx.name }}:{{ .Values.images.nginx.tag }}
{{- end }}


