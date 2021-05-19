{{- /* The main container included in the controller */ -}}
{{- define "common.controller.mainContainer" -}}
- name: {{ include "common.names.fullname" . }}
  image: {{ printf "%s:%s" .Values.image.repository (default .Chart.AppVersion .Values.image.tag) | quote }}
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  {{- with .Values.command }}
  command:
    {{- if kindIs "string" . }}
    - {{ . }}
    {{- else }}
      {{ toYaml . | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- with .Values.args }}
  args:
    {{- if kindIs "string" . }}
    - {{ . }}
    {{- else }}
    {{ toYaml . | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- with .Values.securityContext }}
  securityContext:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.lifecycle }}
  lifecycle:
    {{- toYaml . | nindent 4 }}
  {{- end }}

  env:
   {{- range $key, $value := .Values.envTpl }}
    - name: {{ $key }}
       value: {{ tpl $value $ | quote }}
   {{- end }}
   {{- range $key, $value := .Values.envValueFrom }}
    - name: {{ $key }}
      valueFrom:
       {{- $value | toYaml | nindent 6 }}
   {{- end }}
  {{- range $envList := .Values.envList }}
    {{- if and $envList.name $envList.value }}
    - name: {{ $envList.name }}
      value: {{ $envList.value | quote }}
    {{- else }}
    {{- fail "Please specify name/value for environment variable" }}
    {{- end }}
  {{- end}}
  {{- with .Values.env }}
    {{- range $k, $v := . }}
      {{- $name := $k }}
      {{- $value := $v }}
      {{- if kindIs "int" $name }}
        {{- $name = required "environment variables as a list of maps require a name field" $value.name }}
      {{- end }}
    - name: {{ quote $name }}
      {{- if kindIs "map" $value -}}
        {{- if hasKey $value "value" }}
            {{- $value = $value.value -}}
        {{- else if hasKey $value "valueFrom" }}
          {{- toYaml $value | nindent 6 }}
        {{- else }}
          {{- dict "valueFrom" $value | toYaml | nindent 6 }}
        {{- end }}
      {{- end }}
      {{- if not (kindIs "map" $value) }}
        {{- if kindIs "string" $value }}
          {{- $value = tpl $value $ }}
        {{- end }}
      value: {{ quote $value }}
      {{- end }}
    {{- end }}
  {{- end }}
  {{- if or .Values.envFrom .Values.secret }}
  envFrom:
    {{- with .Values.envFrom }}
      {{- toYaml . | nindent 4 }}
    {{- end }}
    {{- if .Values.secret }}
    - secretRef:
        name: {{ include "common.names.fullname" . }}
    {{- end }}
  {{- end }}
  {{- include "common.controller.ports" . | trim | nindent 2 }}
  {{- with (include "common.controller.volumeMounts" . | trim) }}
  volumeMounts:
    {{ nindent 4 . }}
  {{- end }}
  {{- include "common.controller.probes" . | trim | nindent 2 }}
  {{/*
  Merges the TrueNAS SCALE generated GPU info with the .Values.resources dict
  */}}
  {{- $resources := dict "limits" ( .Values.scaleGPU | default dict ) }}
  {{- $resources = merge $resources .Values.resources }}
  resources:
  {{- with $resources }}
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end -}}
