# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.APP_KEY | string | `"AGcfkCUS233ZWmBXztYbdyCs2u7kkz55"` |  |
| env.DB_CONNECTION | string | `"pgsql"` |  |
| env.DB_DATABASE | string | `"firefly"` |  |
| env.DB_PORT | int | `5432` |  |
| env.DB_USERNAME | string | `"firefly"` |  |
| envValueFrom.DB_HOST.secretKeyRef.key | string | `"postgresql_host"` |  |
| envValueFrom.DB_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"fireflyiii/core"` |  |
| image.tag | string | `"version-5.5.12"` |  |
| initContainers.init-postgresdb.command[0] | string | `"sh"` |  |
| initContainers.init-postgresdb.command[1] | string | `"-c"` |  |
| initContainers.init-postgresdb.command[2] | string | `"until pg_isready -U authelia -h ${pghost} ; do sleep 2 ; done"` |  |
| initContainers.init-postgresdb.env[0].name | string | `"pghost"` |  |
| initContainers.init-postgresdb.env[0].valueFrom.secretKeyRef.key | string | `"plainhost"` |  |
| initContainers.init-postgresdb.env[0].valueFrom.secretKeyRef.name | string | `"dbcreds"` |  |
| initContainers.init-postgresdb.image | string | `"postgres:13.1"` |  |
| initContainers.init-postgresdb.imagePullPolicy | string | `"IfNotPresent"` |  |
| persistence.data.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/var/www/html/storage/upload"` |  |
| persistence.data.size | string | `"100Gi"` |  |
| persistence.data.type | string | `"pvc"` |  |
| podSecurityContext.fsGroup | int | `0` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsNonRoot | bool | `false` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"firefly"` |  |
| postgresql.postgresqlUsername | string | `"firefly"` |  |
| probes.liveness.path | string | `"/login"` |  |
| probes.readiness.path | string | `"/login"` |  |
| probes.startup.path | string | `"/login"` |  |
| service.main.ports.main.port | int | `8080` |  |
| strategy.type | string | `"Recreate"` |  |

All Rights Reserved - The TrueCharts Project
