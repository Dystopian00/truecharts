{{/* Define the secret */}}
{{- define "cloudflareddns.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}
{{- $domains := list }}
{{- $records := list }}
{{- $zones := list }}
{{- range $item := $cfddns.host_and_record }}
  {{- $domains = mustAppend $domains $item.domain }}
  {{- $records = mustAppend $records $item.record }}
  {{- $zones = mustAppend $zones $item.zone }}
{{- end }}
{{- $cfddns := .Values.cloudflareddns -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  {{- with $cfddns.user }}
  CF_USER: {{ . | quote }}
  {{- end }}
  {{- with $cfddns.api_key }}
  CF_APIKEY: {{ . | quote }}
  {{- end }}
  {{- with $cfddns.api_token }}
  CF_APITOKEN: {{ . | quote }}
  {{- end }}
  {{- with $cfddns.api_token_zone }}
  CF_APITOKEN_ZONE: {{ . | quote }}
  {{- end }}
  INTERVAL: {{ $cfddns.interval | quote }}
  LOG_LEVEL: {{ $cfddns.log_level | quote }}
  DETECTION_MODE: {{ $cfddns.detect_override | default $cfddns.detect_mode | quote }}
  CF_ZONES: {{ join ";" $zones | quote }}
  CF_HOSTS: {{ join ";" $hosts | quote }}
  CF_RECORDTYPES: {{ join ";" $records | quote }}
{{- end -}}
