{{/* Define the secret */}}
{{- define "tailscale.config" -}}

data:
  TS_KUBE_SECRET: {{ $secretName | squote }}
  TS_SOCKET: /var/run/tailscale/tailscaled.sock
  TS_USERSPACE: {{ .Values.tailscale.userspace | quote }}
  TS_ACCEPT_DNS: {{ .Values.tailscale.accept_dns | quote }}
  TS_AUTH_ONCE: {{ .Values.tailscale.auth_once | quote }}
  {{- with .Values.tailscale.routes }}
  TS_ROUTES: {{ . }}
  {{- end }}
  {{- with .Values.tailscale.dest_ip }}
  TS_DEST_IP: {{ . }}
  {{- end }}
  {{- with .Values.tailscale.sock5_server }}
  TS_SOCK5_SERVER: {{ . }}
  {{- end }}
  {{- with .Values.tailscale.daemon_extra_args }}
  TS_TAILSCALED_EXTRA_ARGS: {{ . | quote }}
  {{- end }}
  {{- with $customArgs }}
  TS_EXTRA_ARGS: {{ . | quote }}
  {{- end }}
  {{- with .Values.tailscale.outbound_http_proxy_listen }}
  TS_OUTBOUND_HTTP_PROXY_LISTEN: {{ . | quote }}
  {{- end }}
{{- end }}
