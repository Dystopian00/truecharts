{{/* Define the secrets */}}
{{- define "lychee.secrets" -}}
{{- $secretName := (printf "%s-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $lycheeprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
{{- $app_key := "" }}
data:
  {{- if $lycheeprevious}}
  APP_KEY: {{ index $lycheeprevious.data "APP_KEY" }}
  {{- else }}
  {{- $app_key := randAlphaNum 32 }}
  APP_KEY: {{ $app_key | b64enc }}
  {{- end }}

{{- end -}}
