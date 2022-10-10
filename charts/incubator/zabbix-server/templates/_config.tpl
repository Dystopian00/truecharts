{{/* Define the configmap */}}
{{- define "zabbix.config" -}}

{{- $serverConfigName := printf "%s-server-config" (include "tc.common.names.fullname" .) }}
{{- $commonConfigName := printf "%s-common-config" (include "tc.common.names.fullname" .) }}
{{- $webConfigName := printf "%s-web-config" (include "tc.common.names.fullname" .) }}
{{- $agentConfigName := printf "%s-agent-config" (include "tc.common.names.fullname" .) }}
{{- $javagatewayConfigName := printf "%s-javagateway-config" (include "tc.common.names.fullname" .) }}
{{- $webserviceConfigName := printf "%s-webservice-config" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $commonConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  DB_SERVER_HOST: {{ printf "%v-%v" .Release.Name "postgresql" }}
  DB_SERVER_PORT: "5432"
  POSTGRES_USER: {{ .Values.postgresql.postgresqlUsername }}
  POSTGRES_DB: {{ .Values.postgresql.postgresqlDatabase }}

---

{{- $server := .Values.zabbix.server }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $serverConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  ZBX_LISTENPORT: {{ .Values.service.server.ports.server.port | quote }}
  {{- if $server.listen_backlog }}
  ZBX_LISTENBACKLOG: {{ $server.listen_backlog | quote }}
  {{- end }}
  ZBX_LOADMODULE: "{{ range initial $server.load_modules }}{{ . }},{{ end }}{{ with last $server.load_modules }}{{ . }}{{ end }}"
  ZBX_DEBUGLEVEL: {{ $server.debug_level | quote }}
  ZBX_TIMEOUT: {{ $server.timeout | quote }}
  ZBX_WEBSERVICEURL: http://localhost:{{ .Values.service.webservice.ports.webservice.port }}
  ZBX_SERVICEMANAGERSYNCFREQUENCY: {{ $server.service_manager_sync_freq | quote }}
  ZBX_STARTREPORTWRITERS: {{ $server.start_report_writers | quote }}
  ZBX_STARTPOLLERS: {{ $server.start_pollers | quote }}
  ZBX_IPMIPOLLERS: {{ $server.ipmi_pollers | quote }}
  ZBX_STARTPREPROCESSORS: {{ $server.start_preprocessors | quote }}
  ZBX_STARTPOLLERSUNREACHABLE: {{ $server.start_pollers_unreachable | quote }}
  ZBX_STARTTRAPPERS: {{ $server.start_trappers | quote }}
  ZBX_STARTPINGERS: {{ $server.start_pingers | quote }}
  ZBX_STARTDISCOVERERS: {{ $server.start_discoverers | quote }}
  ZBX_STARTHISTORYPOLLERS: {{ $server.start_history_pollers | quote }}
  ZBX_STARTHTTPPOLLERS: {{ $server.start_http_pollers | quote }}
  ZBX_STARTODBCPOLLERS: {{ $server.start_obdc_pollers | quote }}
  ZBX_STARTTIMERS: {{ $server.start_timers | quote }}
  ZBX_STARTESCALATORS: {{ $server.start_escalators | quote }}
  ZBX_STARTALERTERS: {{ $server.start_alerters | quote }}
  ZBX_STARTJAVAPOLLERS: {{ $server.start_java_pollers | quote }}
  ZBX_STARTVMWARECOLLECTORS: {{ $server.start_vmware_colelctors | quote }}
  ZBX_VMWAREFREQUENCY: {{ $server.vmware_frequency | quote }}
  ZBX_VMWAREPERFFREQUENCY: {{ $server.vmware_perf_frequency | quote }}
  ZBX_VMWARECACHESIZE: {{ $server.vmware_cache_size }}
  ZBX_VMWARETIMEOUT: {{ $server.vmware_timeout | quote }}
  ZBX_HOUSEKEEPINGFREQUENCY: {{ $server.housekeeping_freq | quote }}
  ZBX_MAXHOUSEKEEPERDELETE: {{ $server.max_housekeeper_delete | quote }}
  ZBX_PROBLEMHOUSEKEEPINGFREQUENCY: {{ $server.problem_housekeeper_freq | quote }}
  ZBX_SENDERFREQUENCY: {{ $server.sender_freq | quote }}
  ZBX_CACHESIZE: {{ $server.cache_size }}
  ZBX_CACHEUPDATEFREQUENCY: {{ $server.cache_update_freq | quote }}
  ZBX_STARTDBSYNCERS: {{ $server.start_db_syncers | quote }}
  ZBX_HISTORYCACHESIZE: {{ $server.history_cache_size }}
  ZBX_HISTORYINDEXCACHESIZE: {{ $server.history_index_cache_size}}
  ZBX_HISTORYSTORAGEDATEINDEX: {{ ternary "1" "0" $server.history_storage_date_index }}
  ZBX_TRENDCACHESIZE: {{ $server.trend_cache_size }}
  ZBX_TRENDFUNCTIONCACHESIZE: {{ $server.trend_function_cache_size }}
  ZBX_VALUECACHESIZE: {{ $server.value_cache_size }}
  ZBX_TRAPPERTIMEOUT: {{ $server.trapper_timeout | quote }}
  ZBX_UNREACHABLEPERIOD: {{ $server.unreachable_period | quote }}
  ZBX_UNAVAILABLEDELAY: {{ $server.unavailable_delay | quote }}
  ZBX_UNREACHABLEDELAY: {{ $server.unreachable_delay | quote }}
  ZBX_LOGSLOWQUERIES: {{ $server.log_slow_queries | quote }}
  ZBX_STARTPROXYPOLLERS: {{ $server.start_proxy_pollers | quote }}
  ZBX_PROXYCONFIGFREQUENCY: {{ $server.proxy_config_freq | quote }}
  ZBX_PROXYDATAFREQUENCY: {{ $server.proxy_data_freq | quote }}
  ZBX_STARTLLDPROCESSORS: {{ $server.start_lld_processors | quote }}
  ZBX_EXPORTFILESIZE: {{ $server.export_file_size }}
  ZBX_EXPORTTYPE: "{{ range initial $server.export_type }}{{ . }},{{ end }}{{ with last $server.export_type }}{{ . }}{{ end }}"
  ZBX_STATSALLOWEDIP: "{{ range initial $server.stats_allowed_ips }}{{ . }},{{ end }}{{ with last $server.stats_allowed_ips }}{{ . }}{{ end }}"
  ZBX_ENABLE_SNMP_TRAPS: {{ $server.enable_snmp_traps | quote }}
  ZBX_JAVAGATEWAY_ENABLE: {{ $server.java_gateway_enabled | quote }}
  {{/* TODO: add javagateway
  ZBX_JAVAGATEWAY: zabbix-java-gateway
  ZBX_JAVAGATEWAYPORT: 10052
  */}}

---

{{- $agent := .Values.zabbix.agent }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $agentConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  ZBX_SERVER_HOST: localhost
  ZBX_PASSIVESERVERS: localhost
  ZBX_ACTIVESERVERS: localhost:{{ .Values.service.server.ports.server.port }}
  {{- if not $agent.hostname_item }}
  ZBX_HOSTNAME: {{ $agent.hostname }}
  {{- end }}
  {{- if not $agent.metadata_item }}
  ZBX_METADATA: {{ $agent.metadata }}
  {{- end }}
  ZBX_METADATAITEM: {{ $agent.metadata_item }}
  ZBX_HOSTNAMEITEM: {{ $agent.hostname_item }}
  ZBX_SERVER_PORT: {{ .Values.service.server.ports.server.port }}
  ZBX_PASSIVE_ALLOW: {{ $agent.passive_allow | quote }}
  ZBX_ACTIVE_ALLOW: {{ $agent.active_allow | quote }}
  ZBX_TIMEOUT: {{ $agent.timeout | quote }}
  ZBX_ENABLEPERSISTENTBUFFER: {{ $agent.enable_persistent_buffer | quote }}
  ZBX_PERSISTENTBUFFERPERIOD: {{ $agent.persistent_buffer_period }}
  ZBX_LOGREMOTECOMMANDS: {{ ternary "1" "0" $agent.log_remote_commands }}
  ZBX_STARTAGENTS: {{ $agent.start_agents | quote }}
  ZBX_LISTENPORT: {{ .Values.service.agent.ports.agent.port }}
  ZBX_REFRESHACTIVECHECKS: {{ $agent.refresh_active_checks | quote }}
  ZBX_BUFFERSEND: {{ $agent.buffer_send | quote }}
  ZBX_BUFFERSIZE: {{ $agent.buffer_size | quote }}
  ZBX_MAXLINESPERSECOND: {{ $agent.max_line_per_second | quote }}
  ZBX_UNSAFEUSERPARAMETERS: {{ ternary "1" "0" $agent.unsafe_user_parameters }}
  ZBX_TLSCONNECT: {{ $agent.tls_connect }}
  ZBX_TLSACCEPT: {{ $agent.tls_accept }}
  ZBX_TLSPSKIDENTITY: {{ $agent.psk_identity }}
  ZBX_TLSPSKFILE: {{ $agent.psk_file }}
  ZBX_ALLOWKEY: {{ $agent.allow_key }}
  ZBX_DENYKEY: {{ $agent.deny_key }}

---

{{- $frontend := .Values.zabbix.frontend }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $webConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  PHP_TZ: {{ .Values.TZ }}
  ZBX_SERVER_HOST: localhost
  ZBX_SERVER_PORT: {{ .Values.service.server.ports.server.port }}
  ZBX_SERVER_NAME: {{ $frontend.server_name }}
  ENABLE_WEB_ACCESS_LOG: {{ $frontend.enable_access_logs | quote }}
  ZBX_MAXEXECUTIONTIME: {{ $frontend.max_execution_time | quote }}
  ZBX_MEMORYLIMIT: {{ $frontend.memory_limit }}
  ZBX_POSTMAXSIZE: {{ $frontend.post_max_size }}
  ZBX_UPLOADMAXFILESIZE: {{ $frontend.upload_max_file_size }}
  ZBX_MAXINPUTTIME: {{ $frontend.max_input_time | quote }}
  ZBX_SESSION_NAME: {{ $frontend.session_name }}
  ZBX_DENY_GUI_ACCESS: {{ $frontend.deny_gui_access | quote }}
  {{- if $frontend.access_ip_range }}
  ZBX_GUI_ACCESS_IP_RANGE: '[{{ range initial $frontend.access_ip_range }}{{ . | quote }},{{ end }}{{ with last $frontend.access_ip_range }}{{ . | quote }}{{ end }}]'
  {{- end }}
  ZBX_GUI_WARNING_MSG: {{ $frontend.warning_message }}
  ZBX_SSO_SETTINGS: {{ $frontend.sso_settings }}
  PHP_FPM_PM: {{ $frontend.php_fpm_pm }}
  PHP_FPM_PM_MAX_CHILDREN: {{ $frontend.php_fpm_pm_max_children | quote }}
  PHP_FPM_PM_START_SERVERS: {{ $frontend.php_fpm_pm_start_servers | quote }}
  PHP_FPM_PM_MIN_SPARE_SERVERS: {{ $frontend.php_fpm_pm_min_spare_servers | quote }}
  PHP_FPM_PM_MAX_SPARE_SERVERS: {{ $frontend.php_fpm_pm_max_spare_servers | quote }}
  PHP_FPM_PM_MAX_REQUESTS: {{ $frontend.php_fpm_pm_max_requests | quote }}

---

{{- $javagateway := .Values.zabbix.javagateway }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $javagatewayConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  ZBX_START_POLLERS: {{ $javagateway.start_pollers | quote }}
  ZBX_TIMEOUT: {{ $javagateway.timeout | quote }}
  ZBX_DEBUGLEVEL: {{ $javagateway.debug_level }}

---

{{- $webservice := .Values.zabbix.webservice }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $webserviceConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  ZBX_LISTENPORT: {{ .Values.service.webservice.ports.webservice.port }}
  ZBX_ALLOWEDIP: localhost
  ZBX_DEBUGLEVEL: {{ $webservice.debug_level | quote }}
  ZBX_TIMEOUT: {{ $webservice.timeout | quote }}
{{- end -}}
