{{/*
Validate rbac.clusterRoleMode value
Only accepts "api-admin" or "none". Fails on any other value.
*/}}
{{- define "border0-connector.validateRbacMode" -}}
{{- $mode := .Values.rbac.clusterRoleMode | toString | trim -}}
{{- if and (ne $mode "api-admin") (ne $mode "none") -}}
{{- fail (printf "rbac.clusterRoleMode must be either \"api-admin\" or \"none\", got: %q" $mode) -}}
{{- end -}}
{{- end }}
