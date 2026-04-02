{{/*
Validate that config.inviteCode is set (required).
*/}}
{{- define "tailzero-connector.validateConfig" -}}
{{- if eq (.Values.config.inviteCode | trim) "" -}}
{{- fail "config.inviteCode is required" -}}
{{- end -}}
{{- end }}
