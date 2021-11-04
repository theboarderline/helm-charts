
{{- define "branch" -}}

  {{- if eq .Values.values.lifecycle "prod" }}
    main

  {{- else }}
    {{- required "REQUIRED: values.lifecycle" .Values.values.lifecycle }}

  {{- end }}

{{- end }}