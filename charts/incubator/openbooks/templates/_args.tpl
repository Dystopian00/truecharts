{{- define "openbooks.args" -}}
args:
  - --port
  - {{ .Values.service.main.ports.main.port }}
  - --name
  - {{.Values.openbooks.user_name}}
  - --searchbot
  - {{.Values.openbooks.search}}
  {{- if .Values.openbooks.tls }}
  - --tls
  {{- end }}
  - --searchbot
  - {{.Values.openbooks.search}}
  {{- if .Values.openbooks.log }}
  - --log
  {{- end }}
  {{- if .Values.openbooks.debug }}
  - --debug
  {{- end }}
  {{- if .Values.openbooks.persist }}
  - --persist
  {{- end }}
  {{- if .Values.openbooks.no_browser_downloads }}
  - --no-browser-downloads
  {{- end }}
{{- end -}}
