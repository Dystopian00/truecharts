{{/* Define the secrets */}}
{{- define "localai.secrets" -}}
{{- $secretName := (printf "%s-localai-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}

{{- $lai := .Values.localai -}}

enabled: true
data:
  BUILD_TYPE: {{ $lai.build_type }}
  REBUILD: {{ $lai.rebuild }}
  GO_TAGS: {{ $lai.go_tags }}
  CONTEXT_SIZE: {{ $lai.context_size }}
  DEBUG: {{ $lai.debug }}
  CORS: {{ $lai.cors }}
  CORS_ALLOW_ORIGINS: {{ $lai.cors_allow_origins | quote }}
{{- end }}
