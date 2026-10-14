{{/*
Validate that exactly one of config.inviteCode or config.token is set.
*/}}
{{- define "tailzero-connector.validateConfig" -}}
{{- $invite := .Values.config.inviteCode | default "" | trim -}}
{{- $token := .Values.config.token | default "" | trim -}}
{{- if and (eq $invite "") (eq $token "") -}}
{{- fail "one of config.inviteCode or config.token is required" -}}
{{- end -}}
{{- if and (ne $invite "") (ne $token "") -}}
{{- fail "config.inviteCode and config.token are mutually exclusive; set only one" -}}
{{- end -}}
{{- end }}

{{/*
Validate rbac.clusterRoleMode value.
Only accepts "api-admin" or "none". Fails on any other value.
*/}}
{{- define "tailzero-connector.validateRbacMode" -}}
{{- $mode := .Values.rbac.clusterRoleMode | toString | trim -}}
{{- if and (ne $mode "api-admin") (ne $mode "none") -}}
{{- fail (printf "rbac.clusterRoleMode must be either \"api-admin\" or \"none\", got: %q" $mode) -}}
{{- end -}}
{{- end }}
