{{/* Define the secrets */}}
{{- define "nocodb.secrets" -}}

data:
  {{- if $nocodbprevious}}
  NC_AUTH_JWT_SECRET: {{ index $nocodbprevious.data "NC_AUTH_JWT_SECRET" }}
  {{- else }}
  {{- $auth_jwt_token := randAlphaNum 32 }}
  NC_AUTH_JWT_SECRET: {{ $auth_jwt_token | b64enc }}
  {{- end }}

{{- end -}}
