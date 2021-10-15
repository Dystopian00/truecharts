{{/*
This template generates a random password and ensures it persists across updates/edits to the chart
*/}}
{{- define "common.dependencies.postgresql.injector" -}}
{{- $pghost := printf "%v-%v" .Release.Name "postgresql" }}
{{- if .Values.postgresql.enabled }}
---
apiVersion: v1
kind: Secret
metadata:
  labels:
    {{- include "common.labels" . | nindent 4 }}
  name: dbcreds
{{- $dbprevious := lookup "v1" "Secret" .Release.Namespace "dbcreds" }}
{{- $dbPass := "" }}
data:
{{- if $dbprevious }}
  {{- $dbPass = ( index $dbprevious.data "postgresql-password" ) | b64dec  }}
  postgresql-password: {{ ( index $dbprevious.data "postgresql-password" ) }}
  postgresql-postgres-password: {{ ( index $dbprevious.data "postgresql-postgres-password" ) }}
{{- else }}
  {{- $dbPass = randAlphaNum 50 }}
  postgresql-password: {{ $dbPass | b64enc | quote }}
  postgresql-postgres-password: {{ randAlphaNum 50 | b64enc | quote }}
{{- end }}
  url: {{ ( printf "postgresql://%v:%v@%v-postgresql:5432/%v" .Values.postgresql.postgresqlUsername $dbPass .Release.Name .Values.postgresql.postgresqlDatabase  ) | b64enc | quote }}
  urlnossl: {{ ( printf "postgresql://%v:%v@%v-postgresql:5432/%v?sslmode=disable" .Values.postgresql.postgresqlUsername $dbPass .Release.Name .Values.postgresql.postgresqlDatabase  ) | b64enc | quote }}
  plainporthost: {{ ( printf "%v-%v" .Release.Name "postgresql" ) | b64enc | quote }}
  plainhost: {{ ( printf "%v-%v" .Release.Name "postgresql" ) | b64enc | quote }}
type: Opaque
{{- $_ := set .Values.postgresql "postgresqlPassword" ( $dbPass | quote ) }}
{{- $_ := set .Values.postgresql.url "plain" ( ( printf "%v-%v" .Release.Name "postgresql" ) | quote ) }}
{{- $_ := set .Values.postgresql.url "plainport" ( ( printf "%v-%v:5432" .Release.Name "postgresql" ) | quote ) }}
{{- $_ := set .Values.postgresql.url "complete" ( ( printf "%v%v:%v@%v-%v:%v/%v" "postgresql://" .Values.postgresql.postgresqlUsername $dbPass .Release.Name "postgresql" "5432" .Values.postgresql.postgresqlDatabase  ) | quote ) }}

{{- end }}
{{- end -}}
