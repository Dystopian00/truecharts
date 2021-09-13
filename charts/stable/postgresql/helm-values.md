# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| enableUpgradeBackup | bool | `false` |  |
| envTpl.POSTGRES_DB | string | `"{{ .Values.postgresqlDatabase }}"` |  |
| envTpl.POSTGRES_USER | string | `"{{ .Values.postgresqlUsername }}"` |  |
| envValueFrom.POSTGRES_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.POSTGRES_PASSWORD.secretKeyRef.name | string | `"{{ ( tpl .Values.existingSecret $ ) | default ( include \"common.names.fullname\" . ) }}"` |  |
| existingSecret | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"bitnami/postgresql"` |  |
| image.tag | string | `"13.4.0@sha256:8dd9c609de6a960d65285f56106e00bd06ee0ce74fad4876ca7f8d847d10b2e2"` |  |
| initContainers.migrate-db.command[0] | string | `"/bin/sh"` |  |
| initContainers.migrate-db.command[1] | string | `"-cx"` |  |
| initContainers.migrate-db.command[2] | string | `"echo 'trying to migrate old db to new location...'\nmkdir -p /bitnami/postgresql/data\nmv -f /bitnami/postgresql/old/* /bitnami/postgresql/data/ || true\nchown -R {{ .Values.podSecurityContext.runAsUser }}:{{ .Values.podSecurityContext.fsGroup }} /bitnami/postgresql/data\nchmod 775 /bitnami/postgresql/data\n"` |  |
| initContainers.migrate-db.image | string | `"{{ .Values.alpineImage.repository}}:{{ .Values.alpineImage.tag }}"` |  |
| initContainers.migrate-db.imagePullPolicy | string | `"IfNotPresent"` |  |
| initContainers.migrate-db.securityContext.allowPrivilegeEscalation | bool | `true` |  |
| initContainers.migrate-db.securityContext.privileged | bool | `true` |  |
| initContainers.migrate-db.securityContext.runAsNonRoot | bool | `false` |  |
| initContainers.migrate-db.securityContext.runAsUser | int | `0` |  |
| initContainers.migrate-db.volumeMounts[0].mountPath | string | `"/bitnami/postgresql/old"` |  |
| initContainers.migrate-db.volumeMounts[0].name | string | `"db"` |  |
| initContainers.migrate-db.volumeMounts[1].mountPath | string | `"/bitnami/postgresql"` |  |
| initContainers.migrate-db.volumeMounts[1].name | string | `"data"` |  |
| persistence.data.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/bitnami/postgresql"` |  |
| persistence.data.size | string | `"999Gi"` |  |
| persistence.data.type | string | `"pvc"` |  |
| persistence.db.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.db.enabled | bool | `true` |  |
| persistence.db.mountPath | string | `"/bitnami/postgresql/old"` |  |
| persistence.db.size | string | `"999Gi"` |  |
| persistence.db.type | string | `"pvc"` |  |
| persistence.dbbackups.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.dbbackups.enabled | bool | `true` |  |
| persistence.dbbackups.mountPath | string | `"/dbbackups"` |  |
| persistence.dbbackups.size | string | `"999Gi"` |  |
| persistence.dbbackups.type | string | `"pvc"` |  |
| podSecurityContext.fsGroup | int | `568` |  |
| podSecurityContext.fsGroupChangePolicy | string | `"OnRootMismatch"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `568` |  |
| podSecurityContext.supplementalGroups | list | `[]` |  |
| postgresqlDatabase | string | `"test"` |  |
| postgresqlPassword | string | `"testpass"` |  |
| postgresqlUsername | string | `"test"` |  |
| securityContext.allowPrivilegeEscalation | bool | `true` |  |
| securityContext.privileged | bool | `false` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.enabled | bool | `true` |  |
| service.main.ports.main.port | int | `5432` |  |

All Rights Reserved - The TrueCharts Project
