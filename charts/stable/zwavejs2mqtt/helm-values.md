# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | `{}` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"zwavejs/zwavejs2mqtt"` |  |
| image.tag | string | `"5.5.3"` |  |
| persistence.config.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.config.size | string | `"100Gi"` |  |
| persistence.config.type | string | `"pvc"` |  |
| podSecurityContext.fsGroup | int | `568` |  |
| podSecurityContext.runAsGroup | int | `568` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `568` |  |
| podSecurityContext.supplementalGroups[0] | int | `5` |  |
| podSecurityContext.supplementalGroups[1] | int | `20` |  |
| podSecurityContext.supplementalGroups[2] | int | `24` |  |
| probes.liveness.enabled | bool | `true` |  |
| probes.readiness.enabled | bool | `true` |  |
| probes.startup.enabled | bool | `false` |  |
| service.main.ports.main.port | int | `8091` |  |
| service.ws.enabled | bool | `true` |  |
| service.ws.ports.ws.enabled | bool | `true` |  |
| service.ws.ports.ws.port | int | `3000` |  |
| service.ws.ports.ws.protocol | string | `"TCP"` |  |
| service.ws.type | string | `"ClusterIP"` |  |
| strategy.type | string | `"Recreate"` |  |

All Rights Reserved - The TrueCharts Project
