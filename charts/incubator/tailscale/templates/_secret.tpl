{{/* Define the secret */}}
{{- define "tailscale.secret" -}}

{{- $secretName := printf "%s-tailscale-secret" (include "tc.common.names.fullname" .) }}

---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{- with .Values.tailscale.authkey }}
  TS_AUTH_KEY: {{ . }}
  {{- end }}
{{- end }}
