
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


{{- define "self.targetRevision" -}}
  {{- if .Values.self.source.targetRevision }}
    {{- .Values.self.source.targetRevision }}

  {{- else }}
    {{- include "targetRevision" . -}}

  {{- end }}
{{- end }}


{{- define "argocd.targetRevision" -}}
  {{- if .Values.argocd.source.targetRevision }}
    {{- .Values.argocd.source.targetRevision }}

  {{- else }}
    {{- include "targetRevision" . -}}

  {{- end }}
{{- end }}


{{- define "events.targetRevision" -}}
  {{- if .Values.events.source.targetRevision }}
    {{- .Values.events.source.targetRevision }}

  {{- else }}
    {{- include "targetRevision" . -}}

  {{- end }}
{{- end }}


{{- define "rollouts.targetRevision" -}}
  {{- if .Values.rollouts.source.targetRevision }}
    {{- .Values.rollouts.source.targetRevision }}

  {{- else }}
    {{- include "targetRevision" . -}}

  {{- end }}
{{- end }}


{{- define "workflows.targetRevision" -}}
  {{- if .Values.workflows.source.targetRevision }}
    {{- .Values.workflows.source.targetRevision }}

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


{{- define "gatekeeper.targetRevision" -}}
  {{- if .Values.gatekeeper.source.targetRevision }}
    {{- .Values.gatekeeper.source.targetRevision }}

  {{- else }}
    {{- include "targetRevision" . -}}

  {{- end }}
{{- end }}


{{- define "gatekeeper_policies.targetRevision" -}}
  {{- if .Values.gatekeeper_policies.source.targetRevision }}
    {{- .Values.gatekeeper_policies.source.targetRevision }}

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


{{- define "secrets_sa" -}}
gke-nodes@{{- required "REQUIRED: lifecycle_letter" .Values.lifecycle_letter -}}-{{ .Values.proj_identifier }}-gke-project.iam.gserviceaccount.com
{{- end }}