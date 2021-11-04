
{{- define "branch" -}}

  {{- if eq .Values.lifecycle "prod" }}
    main

  {{- else }}
    {{- required "REQUIRED: values.lifecycle" .Values.lifecycle }}

  {{- end }}

{{- end }}