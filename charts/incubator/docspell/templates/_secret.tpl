{{/* Define the secret */}}
{{- define "docspell.secret" -}}

{{- $serverSecretName := printf "%s-server-secret" (include "tc.common.names.fullname" .) }}
{{- $joexSecretName := printf "%s-joex-secret" (include "tc.common.names.fullname" .) }}

{{ $server := .Values.rest_server }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $serverSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace $serverSecretName) }}
  DOCSPELL_SERVER_AUTH_SERVER__SECRET: {{ index .data "DOCSPELL_SERVER_AUTH_SERVER__SECRET" }}
  {{- else }}
  {{/* This should ensure that container receivers something like b64:ENCODEDSECRET */}}
  DOCSPELL_SERVER_AUTH_SERVER__SECRET: {{ printf "b64:%v" (randAlphaNum 32 | b64enc) | b64enc }}
  {{- end }}

  {{- with $server.admin_endpoint.secret }}
  DOCSPELL_SERVER_ADMIN__ENDPOINT_SECRET: {{ . | b64enc }}
  {{- end }}

  {{- with $server.integration_endpoint.http_basic_auth.password }}
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_HTTP__BASIC_PASSWORD: {{ . | b64enc }}
  {{- end }}

  {{- with $server.integration_endpoint.http_header.header_name }}
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_HTTP__HEADER_HEADER__VALUE:
  {{- end }}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $joexSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
{{- end }}
