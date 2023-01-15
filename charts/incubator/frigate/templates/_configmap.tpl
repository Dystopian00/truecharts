{{/* Define the configmap */}}
{{- define "frigate.configmap" -}}

{{- $configName := printf "%s-frigate-config" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  config.yml: # TODO: |
    database:
      path: /db/frigate.db
    mqtt:
      {{- $mqtt := .Values.frigate.mqtt }}
      host: {{ required "You need to provide an MQTT host" $mqtt.host }}
      {{- with $mqtt.port }}
      port: {{ . }}
      {{- end }}
      {{- with $mqtt.topic_prefix }}
      topic_prefix: {{ . }}
      {{- end }}
      {{- with $mqtt.client_id }}
      client_id: {{ . }}
      {{- end }}
      {{- if not (kindIs "invalid" $mqtt.stats_interval) }}
      stats_interval: {{ $mqtt.stats_interval }}
      {{- end }}
      {{- with $mqtt.user }}
      user: {{ . }}
      {{- end }}
      {{- with $mqtt.password }}
      password: {{ . }}
      {{- end }}

    {{- $detectors := .Values.frigate.detectors -}}
    {{- if and $detectors.render_config $detectors.config }}
    detectors:
      {{- range $d := $detectors.config }}
      {{ $d.name | required "You need to provide a detector name" }}:
        type: {{ $d.type | required "You need to provide a detector type" }}
        {{- with $d.device }}
        device: {{ . }}
        {{- end }}
        {{- with $d.num_threads }}
        num_threads: {{ . }}
        {{- end }}
      {{- end }}
    {{- end }}

    {{- $model := .Values.frigate.model -}}
    {{- if $model.render_config }}
    model:
      width: {{ $model.width | required "You need to provide a model width" }}
      height: {{ $model.height | required "You need to provide a model height" }}
      {{- with $model.path }}
      path: {{ . }}
      {{- end }}
      {{- with $model.labelmap_path }}
      labelmap_path: {{ . }}
      {{- end }}
      {{- with $model.labelmap }}
      labelmap:
        {{- range $lmap := . }}
        {{ $lmap.model | required "You need to provide a labelmap model" }}: {{ $lmap.name | required "You need to provide a labelmap name" }}
        {{- end }}
      {{- end }}
    {{- end }}

    {{- $logger := .Values.frigate.logger -}}
    {{- if $logger.render_config }}
    logger:
      default: {{ $logger.default }}
      {{- with $logger.logs }}
      logs:
        {{- range $log := . }}
        {{ $log.component | required "You need to provide a logger cmponent" }}: {{ $log.verbosity | required "You need to provide logger verbosity" }}
        {{- end }}
      {{- end }}
    {{- end }}

    {{- $birdseye := .Values.frigate.birdseye -}}
    {{- if $birdseye.render_config }}
    birdseye:
      enabled: {{ ternary "True" "False" $birdseye.enabled }}
      {{- with $birdseye.width }}
      width: {{ . }}
      {{- end }}
      {{- with $birdseye.height }}
      height: {{ . }}
      {{- end }}
      {{- with $birdseye.quality }}
      quality: {{ . }}
      {{- end }}
      {{- with $birdseye.mode }}
      mode: {{ . }}
      {{- end }}
    {{- end }}

    {{- $ffmpeg := .Values.frigate.ffmpeg -}}
    {{- if $ffmpeg.render_config }}
    ffmpeg:
      {{- with $ffmpeg.global_args }}
      global_args: {{ . }}
      {{- end }}
      {{- with $ffmpeg.input_args }}
      input_args: {{ . }}
      {{- end }}
      {{- with $ffmpeg.hwaccel_args }}
      hwaccel_args: {{ . }}
      {{- end }}
      {{- if or $ffmpeg.output_args.detect $ffmpeg.output_args.record $ffmpeg.output_args.rtmp }}
      output_args:
        {{- with $ffmpeg.output_args.detect }}
        detect: {{ . }}
        {{- end }}
        {{- with $ffmpeg.output_args.record }}
        record: {{ . }}
        {{- end }}
        {{- with $ffmpeg.output_args.rtmp }}
        rtmp: {{ . }}
        {{- end }}
      {{- end }}
    {{- end }}

    {{- $detect := .Values.frigate.detect -}}
    {{- if $detect.render_config }}
    detect:
      enabled: {{ ternary "True" "False" $detect.enabled }}
      {{- with $detect.width }}
      width: {{ . }}
      {{- end }}
      {{- with $detect.height }}
      height: {{ . }}
      {{- end }}
      {{- with $detect.fps }}
      fps: {{ . }}
      {{- end }}
      {{- with $detect.max_disappeared }}
      max_disappeared: {{ . }}
      {{- end }}
      {{- if or (not (kindIs "invalid" $detect.stationary.interval)) $detect.stationary.threshold $detect.stationary.set_max_frames }}
      stationary:
        {{- if not (kindIs "invalid" $detect.stationary.interval) }} {{/* invalid kind means it's empty (0 is not empty) */}}
        interval: {{ $detect.stationary.interval }}
        {{- end }}
        {{- with $detect.stationary.threshold }}
        threshold: {{ . }}
        {{- end }}
        {{- if (hasKey $detect.stationary "max_frames") }}
        {{- if or $detect.stationary.max_frames.default $detect.stationary.max_frames.objects }}
        max_frames:
          {{- with $detect.stationary.max_frames.default }}
          default: {{ . }}
          {{- end }}
          {{- with $detect.stationary.max_frames.objects }}
          objects:
            {{- range $obj := . }}
            {{ $obj.object | required "You need to provide an object" }}: {{ $obj.frames required "You need to provide frames" }}
            {{- end }}
          {{- end }}
        {{- end }}
        {{- end }}
      {{- end }}
    {{- end }}

    {{- $objects := .Values.frigate.objects -}}
    {{- if $objects.render_config }}
    objects:
      {{- with $objects.track }}
      track:
        {{- range $track := . }}
        - {{ $track }}
        {{- end }}
      {{- end }}
      {{- with $objects.mask }}
      mask: {{ . }}
      {{- end }}
      {{- with $objects.filters }}
      filters:
        {{- range $filter := . }}
        {{ $filter.object | required "You need to provide an object" }}:
          {{- with $filter.min_area }}
          min_area: {{ . }}
          {{- end }}
          {{- with $filter.max_area }}
          max_area: {{ . }}
          {{- end }}
          {{- with $filter.min_ratio }}
          min_ratio: {{ . }}
          {{- end }}
          {{- with $filter.max_ratio }}
          max_ratio: {{ . }}
          {{- end }}
          {{- with $filter.min_score }}
          min_score: {{ . }}
          {{- end }}
          {{- with $filter.threshold }}
          threshold: {{ . }}
          {{- end }}
          {{- with $filter.mask }}
          mask: {{ . }}
          {{- end }}
        {{- end }}
      {{- end }}
    {{- end }}

    {{- $motion := .Values.frigate.motion -}}
    {{- if $motion.render_config }}
    motion:
      {{- with $motion.threshold }}
      threshold: {{ . }}
      {{- end }}
      {{- with $motion.contour_area }}
      contour_area: {{ . }}
      {{- end }}
      {{- with $motion.delta_alpha }}
      delta_alpha: {{ . }}
      {{- end }}
      {{- with $motion.frame_alpha }}
      frame_alpha: {{ . }}
      {{- end }}
      {{- with $motion.frame_height }}
      frame_height: {{ . }}
      {{- end }}
      {{- with $motion.mask }}
      mask: {{ . }}
      {{- end }}
      improve_contrast: {{ ternary "True" "False" $motion.improve_contrast }}
      {{- with $motion.mqtt_off_delay }}
      mqtt_off_delay: {{ . }}
      {{- end }}
    {{- end }}

    {{- $record := .Values.frigate.record -}}
    {{- if $record.render_config }}
    record:
      enabled: {{ ternary "True" "False" $record.enabled }}
      {{- with $record.expire_interval }}
      expire_interval: {{ . }}
      {{- end }}
      {{- if $record.retain.render_config }}
      retain:
        {{- if not (kindIs "invalid" $record.retain.days) }}
        days: {{ $record.retain.days }}
        {{- end }}
        {{- with $record.retain.mode }}
        mode: {{ . }}
        {{- end }}
      {{- end }}
      {{- if $record.events.render_config }}
      events:
        {{- if not (kindIs "invalid" $record.events.pre_capture) }}
        pre_capture: {{ $record.events.pre_capture }}
        {{- end }}
        {{- if not (kindIs "invalid" $record.events.post_capture) }}
        post_capture: {{ $record.events.post_capture }}
        {{- end }}
        {{- with $record.events.objects }}
        objects:
          {{- range $obj := . }}
          - {{ $obj }}
          {{- end }}
        {{- end }}
        {{- with $record.events.required_zones }}
        required_zones:
          {{- range $zone := . }}
          - {{ $zone }}
          {{- end }}
        {{- end }}
        {{- if $record.events.retain.render_config }}
        retain:
          default: {{ $record.events.retain.default | required "You need to provide default retain days" }}
          {{- with $record.events.retain.mode }}
          mode: {{ . }}
          {{- end }}
          {{- with $record.events.retain.objects }}
          objects:
          {{- range $obj := . }}
            {{ $obj.object | required "You need to provide an object" }}: {{ $obj.days | required "You need to provide default retain days" }}
          {{- end }}
          {{- end }}
        {{- end }}
      {{- end }}
    {{- end }}

    {{- $snapshots := .Values.frigate.snapshots -}}
    {{- if $snapshots.render_config }}
    snapshots:
      enabled: {{ ternary "True" "False" $snapshots.enabled }}
      clean_copy: {{ ternary "True" "False" $snapshots.clean_copy }}
      timestamp: {{ ternary "True" "False" $snapshots.timestamp }}
      bounding_box: {{ ternary "True" "False" $snapshots.bounding_box }}
      crop: {{ ternary "True" "False" $snapshots.crop }}
      {{- with $snapshots.height }}
      height: {{ . }}
      {{- end }}
      {{- with $snapshots.required_zones }}
      required_zones:
        {{- range $zone := . }}
        - {{ $zone }}
        {{- end }}
      {{- end }}
      {{- if $snapshots.retain.render_config }}
      retain:
        default: {{ $snapshots.retain.default | required "You need to provide default retain days" }}
        {{- with $snapshots.retain.objects }}
        objects:
        {{- range $obj := . }}
          {{ $obj.object | required "You need to provide an object" }}: {{ $obj.days | required "You need to provide default retain days" }}
        {{- end }}
        {{- end }}
      {{- end }}
    {{- end }}

    {{- $rtmp := .Values.frigate.rtmp -}}
    {{- if $rtmp.render_config }}
    rtmp:
      enabled: {{ ternary "True" "False" $rtmp.enabled }}
    {{- end }}

    {{- $live := .Values.frigate.live -}}
    {{- if $live.render_config }}
    live:
      {{- with $live.height }}
      height: {{ . }}
      {{- end }}
      {{- with $live.quality }}
      quality: {{ . }}
      {{- end }}
    {{- end }}

    {{- if .Values.frigate.timestamp_style.render_config }}
    timestamp_style:
      {{- with .Values.frigate.timestamp_style.position }}
      position: {{ . }}
      {{- end }}
      {{- with .Values.frigate.timestamp_style.format }}
      format: {{ . }}
      {{- end }}
      {{- if .Values.frigate.timestamp_style.color.render_config }}
      color:
        red: {{ .Values.frigate.timestamp_style.color.red | default 255 }}
        green: {{ .Values.frigate.timestamp_style.color.green | default 255 }}
        blue: {{ .Values.frigate.timestamp_style.color.blue | default 255 }}
      {{- end }}
      {{- with .Values.frigate.timestamp_style.thickness }}
      thickness: {{ . }}
      {{- end }}
      {{- if ne .Values.frigate.timestamp_style.effect "None" }}
      effect: {{ .Values.frigate.timestamp_style.effect }}
      {{- end }}
    {{- end }}

    cameras:
    {{- range .Values.frigate.cameras }}
      {{ .camera_name }}:
        ffmpeg:
          {{- with .ffmpeg }}
          inputs:
          {{- range .inputs }}
            - path: {{ .path }}
              {{- with .roles }}
              roles:
                {{- range . }}
                - {{ . }}
                {{- end }}
              {{- end }} {{/* end with roles*/}}
              {{- with .global_args }}
              global_args: {{ . }}
              {{- end }}
              {{- with .hwaccel_args }}
              hwaccel_args: {{ . }}
              {{- end }}
              {{- with .input_args }}
              input_args: {{ . }}
              {{- end }}
          {{- end }} {{/* end range inputs */}}
          {{- with .global_args }}
          global_args: {{ . }}
          {{- end }}
          {{- with .hwaccel_args }}
          hwaccel_args: {{ . }}
          {{- end }}
          {{- with .input_args }}
          input_args: {{ . }}
          {{- end }}
          {{- with .output_args }}
          output_args: {{ . }}
          {{- end }}
          {{- end }} {{/* end with ffmpeg */}}
        best_image_timeout: {{ .best_image_timeout | default 60 }}
        {{- with .zones }}
        zones:
          {{- range . }}
          {{ .name }}:
            coordinates: {{ required "You have to specify coordinates" .coordinates }}
            {{- with .objects }}
            objects:
              {{- range . }}
              - {{ . }}
              {{- end }}
            {{- end }} {{/* end with objects*/}}
            {{- with .filters }}
            filters:
              {{- range . }}
              {{ .object }}:
                {{- with .min_area }}
                min_area: {{ . }}
                {{- end }}
                {{- with .max_area }}
                max_area: {{ . }}
                {{- end }}
                {{- with .threshold }}
                threshold: {{ . }}
                {{- end }}
              {{- end }} {{/* end range filters */}}
            {{- end }} {{/* end with filter */}}
          {{- end }} {{/* end range zones */}}
        {{- end }} {{/* end with zones */}}
        {{- if .mqtt.render_config }}
        {{- with .mqtt }}
        mqtt:
          enabled: {{ ternary "True" "False" .enabled }}
          timestamp: {{ ternary "True" "False" .timestamp }}
          bounding_box: {{ ternary "True" "False" .bounding_box }}
          crop: {{ ternary "True" "False" .crop }}
          height: {{ .height | default 270 }}
          quality: {{ .quality | default 70 }}
          {{- with .required_zones }}
          required_zones:
            {{- range . }}
            - {{ . }}
            {{- end }}
          {{- end }}
        {{- end }} {{/* end with mqtt */}}
        {{- end }} {{/* end if mqtt.render_config */}}
        {{- if .ui.render_config }}
        {{- with .ui }}
        ui:
          {{- if or .order (eq (int .order) 0) }}
          order: {{ .order }}
          {{- end }}
          dashboard: {{ ternary "True" "False" .dashboard }}
        {{- end }} {{/* end with ui */}}
        {{- end }} {{/* end if ui.render_config */}}
    {{- end }} {{/* end range cameras */}}

{{- end }}
