

{{- define "domain" -}}

  {{- if .Values.lifecycle }}

    {{- if eq .Values.lifecycle "prod" }}
      {{- required "REQUIRED: domain" .Values.domain }}

    {{- else }}
      {{- .Values.lifecycle -}}.{{- required "REQUIRED: domain" .Values.domain }}

    {{- end -}}

  {{- else }}
    {{- required "REQUIRED: domain" .Values.domain }}
  {{- end -}}

{{- end }}
