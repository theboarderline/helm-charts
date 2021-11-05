
{{- define "targetRevision" -}}
  {{- if .Values.source.targetRevision }}
    {{- .Values.source.targetRevision }}

  {{- else if .Values.lifecycle }}
    {{- if eq .Values.lifecycle "prod" }}
      main

    {{- else }}
      {{- required "REQUIRED: values.lifecycle" .Values.lifecycle }}

    {{- end }}
  {{- else }}
    HEAD
  {{- end }}
{{- end }}


{{- define "argocd.targetRevision" -}}
  {{- if .Values.argocd.source.targetRevision }}
    {{- .Values.argocd.source.targetRevision }}

  {{- else }}
    {{- include "targetRevision" . -}}

  {{- end }}
{{- end }}


{{- define "self.targetRevision" -}}
  {{- if .Values.self.source.targetRevision }}
    {{- .Values.self.source.targetRevision }}

  {{- else }}
    {{- include "targetRevision" . -}}

  {{- end }}
{{- end }}


{{- define "platform.targetRevision" -}}
  {{- if .Values.platform.source.targetRevision }}
    {{- .Values.platform.source.targetRevision }}

  {{- else }}
    {{- include "targetRevision" . -}}

  {{- end }}
{{- end }}

{{- define "secrets_refresh" -}}
  {{- if and (.Values.lifecycle) (eq .Values.lifecycle "dev") }}
    {{- "3000" -}}

  {{- else }}
    {{- "60000" -}}

  {{- end }}
{{- end }}