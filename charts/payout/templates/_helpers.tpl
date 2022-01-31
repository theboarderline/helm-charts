
{{- define "server_image" -}}
  {{- if .Values.server_image }}
    {{- .Values.server_image }}
  {{- else }}
    {{- "gcr.io/walker-cpl/payout-server" -}}
  {{- end }}
{{- end -}}


{{- define "calculator_image" -}}
  {{- if .Values.calculator_image }}
    {{- .Values.calculator_image }}
  {{- else }}
    {{- "gcr.io/walker-cpl/payout-calculator" -}}
  {{- end }}
{{- end -}}


{{- define "gcp_project_id" -}}
  {{- if .Values.gcp_project_id }}
    {{- .Values.gcp_project_id }}
  {{- else }}
    {{- required "REQUIRED: tenant_code" .Values.tenant_code -}}-app-project
  {{- end }}
{{- end }}


{{- define "ip_name" -}}
  {{- if .Values.ip_name }}
    {{- .Values.ip_name }}
  {{- else }}
    {{- required "REQUIRED: tenant_code" .Values.tenant_code -}}-ip
  {{- end }}
{{- end }}


