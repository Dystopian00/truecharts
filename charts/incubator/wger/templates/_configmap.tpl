{{/* Define the configmap */}}
{{- define "wger.configmap" -}}

{{- $configName := printf "%s-wger-configmap" (include "tc.common.names.fullname" .) }}

---
{{/* This configmap are loaded on both main authentik container and worker */}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{/* Dependencies */}}
  DJANGO_DB_ENGINE: "django.db.backends.postgresql"
  DJANGO_DB_DATABASE: {{ .Values.postgresql.postgresqlDatabase }}
  DJANGO_DB_USER: {{ .Values.postgresql.postgresqlUsername }}
  DJANGO_DB_PORT: "5432"
  DJANGO_DB_HOST: {{ printf "%v-%v" .Release.Name "postgresql" }}
  DJANGO_CACHE_BACKEND: "django_redis.cache.RedisCache"
  DJANGO_CACHE_CLIENT_CLASS: "django_redis.client.DefaultClient"
  DJANGO_CACHE_TIMEOUT: "1296000"
  TIME_ZONE: "{{ .Values.TZ }}"
  {{/* True, not true */}}
  WGER_USE_GUNICORN: "True"
  {{/* User Defined */}}
  {{/* General */}}
  {{- with .Values.wger.site_url }}
  SITE_URL: {{ . | quote }}
  {{- end }}
  {{- with .Values.wger.exercise_cache_ttl }}
  EXERCISE_CACHE_TTL: {{ . | quote }}
  {{- end }}
  ALLOW_REGISTRATION: {{ ternary "True" "False" .Values.wger.allow_registration | squote }}
  ALLOW_GUEST_USERS: {{ ternary "True" "False" .Values.wger.allow_guest_users | squote }}
  ALLOW_UPLOAD_VIDEOS: {{ ternary "True" "False" .Values.wger.allow_upload_videos | squote }}
  SYNC_EXERCISES_ON_STARTUP: {{ ternary "True" "False" .Values.wger.sync_exercises_on_startup | squote }}
  DOWNLOAD_EXERCISE_IMAGES_ON_STARTUP: {{ ternary "True" "False" .Values.wger.download_exercise_images_on_startup | squote }}
  DJANGO_PERFORM_MIGRATIONS: {{ ternary "True" "False" .Values.wger.django_perform_migrations | squote }}
  DJANGO_DEBUG: {{ ternary "True" "False" .Values.wger.django_debug | squote }}
  NOCAPTCHA: {{ ternary "True" "False" .Values.wger.nocaptcha | squote }}
  {{/* Mail */}}
  ENABLE_EMAIL: {{ ternary "True" "False" .Values.wger.enable_email | squote }}
  {{- with .Values.wger.from_email }}
  FROM_EMAIL: {{ . }}
  {{- end }}
  {{- with .Values.wger.email_host }}
  EMAIL_HOST: {{ . }}
  {{- end }}
  {{- with .Values.wger.email_port }}
  EMAIL_PORT: {{ . | quote }}
  {{- end }}
  EMAIL_USE_TLS: {{ ternary "True" "False" .Values.wger.email_use_tls | squote }}
  EMAIL_USE_SSL: {{ ternary "True" "False" .Values.wger.email_use_ssl | squote }}
  nginx.conf: |-
    upstream wger {
        server localhost:8000;
    }
    server {
        listen {{ .Values.service.main.ports.main.port }};
        location / {
            proxy_pass http://localhost:8000;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $host;
            proxy_redirect off;
        }
        location /static/ {
            alias /static/;
        }
        location /media/ {
            alias /media/;
        }
        # Increase max body size to allow for video uploads
        client_max_body_size 100M;
    }
{{- end }}
