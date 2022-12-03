{{/* Define the configmap */}}
{{- define "invidious.config" -}}

{{- $configName := printf "%s-invidious-config" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: Secret
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  INVIDIOUS_CONFIG:|
    # version compatible 0.20.1+
    db:
      user: {{ .Values.postgresql.postgresqlUsername }}
      password: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" | b64enc }}
      host: {{ printf "%v-%v" .Release.Name "postgresql" }}
      port: "5432"
      dbname: {{ .Values.postgresql.postgresqlDatabase }}
    check_tables: "{{ .Values.invidious.check_tables }}"

    port: {{ .Values.service.main.ports.main.port }}
    external_port: {{ .Values.service.main.ports.main.port }}
    host_binding: {{ .Values.network.inbound.host_binding }}
    domain: {{ .Values.network.inbound.domain }}
    https_only: {{ .Values.network.inbound.https_only }}
    hsts: {{ .Values.network.inbound.hsts }}

   #disable_proxy: false #true, false, dash, livestreams, downloads, local
   #pool_size: 100
   #use_quic: false
   #cookies: ## Accepted values: a string in the format "name1=value1; name2=value2..."
   #force_resolve: ipv4
   #output: STDOUT
   #log_level: Info
   #popular_enabled: true
   #statistics_enabled: false

   #registration_enabled: true
   #login_enabled: true
   #captcha_enabled: true
   #admins: [""]

   channel_threads: 1
   #channel_refresh_interval: 30m
   full_refresh: false
   feed_threads: 1
   #decrypt_polling: false

   jobs:
     clear_expired_items:
       enable: true
     refresh_channels:
       enable: true
     refresh_feeds:
       enable: true

   #captcha_api_url: https://api.anti-captcha.com
   #captcha_key:

   #banner:
   #use_pubsub_feeds: false
   #hmac_key:
   #dmca_content:
   #cache_annotations: false
   #modified_source_code_url: ""
   #playlist_length_limit: 500

   default_user_preferences:
     #locale: en-US
     #region: US
     #captions: ["", "", ""]

     #dark_mode: "auto"
     #thin_mode: false

     #feed_menu: ["Popular", "Trending", "Subscriptions", "Playlists"]
     #default_home: Popular
     #max_results: 40
     #annotations: false
     #annotations_subscribed: false
     #comments: ["youtube", ""]
     #player_style: invidious
     #related_videos: true

    #autoplay: false
    #continue: false
    #continue_autoplay: true
    #listen: false
    #video_loop: false

   #quality: hd720
   #quality_dash: auto
   #speed: 1.0
   #volume: 100
   #vr_mode: true

   #latest_only: false
   #notifications_only: false
   #unseen_only: false
   #sort: published

   #local: false
   #show_nick: true
   #automatic_instance_redirect: false
   #extend_desc: false
{{- end -}}
