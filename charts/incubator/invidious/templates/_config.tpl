{{/* Define the configmap */}}
{{- define "invidious.config" -}}

{{- $configName := printf "%s-invidious-config" (include "tc.common.names.fullname" .) }}
{{- $v := .Values.invidious }}
{{- $vNet := $v.network }}
{{- $vLog := $v.logging }}
{{- $vFeat := $v.features }}
{{- $vUserAcc := $v.users_accounts }}
{{- $vBgJobs := $v.background_jobs }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  INVIDIOUS_CONFIG: |
    # Database
    check_tables: true
    db:
      user: {{ .Values.postgresql.postgresqlUsername }}
      dbname: {{ .Values.postgresql.postgresqlDatabase }}
      password: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" }}
      host: {{ .Values.postgresql.url.plain | trimAll "\"" }}
      port: 5432

    # Network
    host_binding: 0.0.0.0
    port: {{ .Values.service.main.ports.main.port }}
    external_port: {{ $vNet.inbound.external_port }}
    https_only: {{ $vNet.inbound.https_only }}
    domain: {{ $vNet.inbound.domain }}
    hsts: {{ $vNet.inbound.hsts }}
    disable_proxy: {{ $vNet.outbound.disable_proxy }}
    pool_size: {{ $vNet.outbound.pool_size }}
    use_quic: {{ $vNet.outbound.use_quic }}
    cookies: {{ join "; " $vNet.outbound.cookies }}
    force_resolve: {{ $vNet.outbound.force_resolve }}

    # Logging
    output: {{ $vLog.output }}
    log_level: {{ $vLog.log_level }}

    # Features
    popular_enabled: {{ $vFeat.popular_enabled }}
    statistics_enabled: {{ $vFeat.statistics_enabled }}

    # Users and Accounts
    registration_enabled: {{ $vUserAcc.registration_enabled }}
    login_enabled: {{ $vUserAcc.login_enabled }}
    captcha_enabled: {{ $vUserAcc.captcha_enabled }}
    {{- if $vUserAcc.admins -}}
    admins:
      {{- range $vUserAcc.admins }}
      - {{ . }}
      {{- end }}
    {{- else }}
    admins: [""]
    {{- end }}

    # Background Jobs
    channel_threads: {{ $vBgJobs.channel_threads }}
    channel_refresh_interval: {{ $vBgJobs.channel_refresh_interval }}
    full_refresh: {{ $vBgJobs.full_refresh }}
    feed_threads: {{ $vBgJobs.feed_threads }}
    decrypt_polling: {{ $vBgJobs.decrypt_polling }}

    # Jobs
    jobs:
      clear_expired_items:
        enable: true
      refresh_channels:
        enable: true
      refresh_feeds:
        enable: true
    captcha_api_url: "https://api.anti-captcha.com"
    captcha_key: ""
    banner: ""
    use_pubsub_feeds: false
    hmac_key: ""
    dmca_content: [""]
    cache_annotations: false
    modified_source_code_url: ""
    playlist_length_limit: 500
    default_user_preferences:
      locale: en-US
      region: US
      captions: ["","",""]
      dark_mode: auto
      thin_mode: false
      feed_menu: ["Popular", "Trending", "Subscriptions", "Playlists"]
      default_home: Popular
      max_results: 40
      annotations: false
      annotations_subscribed: false
      comments: ["youtube"]
      player_style: invidious
      related_videos: true
      autoplay: false
      continue: false
      continue_autoplay: true
      listen: false
      video_loop: false
      quality: hd720
      quality_dash: auto
      speed: 1.0  # Convert to float with `| float64`
      volume: 100
      vr_mode: true
      latest_only: false
      notifications_only: false
      unseen_only: false
      sort: published
      local: false
      show_nick: true
      automatic_instance_redirect: false
      extend_desc: false
{{- end -}}
