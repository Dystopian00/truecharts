{{/* Define the cronjob */}}
{{- define "clamav.cronjob" -}}
{{- $jobName := include "common.names.fullname" . }}

---
apiVersion: batch/v1
kind: CronJob
metadata:
  name: {{ printf "%s-cronjob" $jobName }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
spec:
  schedule: "{{ .Values.clamav.cron_schedule }}"
  concurrencyPolicy: Forbid
  {{- with .Values.cronjob.failedJobsHistoryLimit }}
  failedJobsHistoryLimit: {{ . }}
  {{- end }}
  {{- with .Values.cronjob.successfulJobsHistoryLimit }}
  successfulJobsHistoryLimit: {{ . }}
  {{- end }}
  jobTemplate:
    metadata:
    spec:
      template:
        metadata:
        spec:
          securityContext:
            runAsUser: 0
            runAsGroup: 0
          restartPolicy: Never
          {{- with (include "common.controller.volumes" . | trim) }}
          volumes:
            {{- nindent 12 . }}
          {{- end }}
          containers:
            - name: {{ .Chart.Name }}
              securityContext:
                privileged: false
                readOnlyRootFilesystem: false
                allowPrivilegeEscalation: false
                runAsNonRoot: false
                capabilities:
                  drop:
                    - ALL
              image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
              env:
                - name: date_format
                  value: {{ .Values.clamav.date_format }}
                - name: log_file_name
                  value: {{ .Values.clamav.log_file_name }}
                - name: report_path
                  value: {{ .Values.clamav.report_path | trimSuffix "/" }}
              command: ["sh", "-c"]
              args:
                - >
                  export now=$(date ${date_format});
                  export log_file=$report_path/${log_file_name}_${now};
                  export status=99;
                  touch $log_file;
                  echo "Starting scan of \"/scandir\"";
                  clamdscan /scandir --log=$log_file;
                  status=$?;
                  if [ $status -eq 0 ];
                    then
                      echo "Exit Status: $status No Virus found!";
                  else
                    echo "Exit Status: $status. Check scan \"log_file\".";
                  fi;
                  cat $log_file;
              {{- with (include "common.controller.volumeMounts" . | trim) }}
              volumeMounts:
                {{ nindent 16 . }}
              {{- end }}
              resources:
{{ toYaml .Values.resources | indent 16 }}
{{- end -}}
