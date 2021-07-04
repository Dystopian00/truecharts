{{/* Define the configmap */}}
{{- define "nextcloud.configmap" -}}

{{- $hosts := "" }}
{{- if .Values.ingress.main.enabled }}
{{ range $index, $host := .Values.ingress.main.hosts }}
    {{- if $index }}
    {{ $hosts = ( printf "%v %v" $hosts $host.host ) }}
    {{- else }}
    {{ $hosts = ( printf "%s" $host.host ) }}
    {{- end }}
{{ end }}
{{- end }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: nextcloudconfig
data:
  NEXTCLOUD_TRUSTED_DOMAINS: {{ ( printf "%v %v %v" "test.fakedomain.dns" .Values.env.NODE_IP $hosts ) | quote }}
  {{- if .Values.ingress.main.enabled }}
  APACHE_DISABLE_REWRITE_IP: "1"
  {{- end }}

{{- end -}}
