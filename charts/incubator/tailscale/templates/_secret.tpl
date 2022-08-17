{{/* Define the secret */}}
{{- define "tailscale.secret" -}}

{{- $secretName := printf "%s-tailscale-secret" (include "tc.common.names.fullname" .) }}

---
{{/* This secrets are loaded on both main authentik container and worker */}}
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $authentikSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{- with .Values.tailscale.authkey }}
  TS_AUTH_KEY: {{ . | b64enc }}
  {{- end }}
{{- end }}
