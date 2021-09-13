# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.CHECK_FREQUENCY | int | `240` |  |
| env.PASSWORD | string | `"secretpasswordgoeshere"` |  |
| hostPathMounts[0].accessMode | string | `"ReadWriteOnce"` |  |
| hostPathMounts[0].enabled | bool | `true` |  |
| hostPathMounts[0].mountPath | string | `"/assets"` |  |
| hostPathMounts[0].name | string | `"assets"` |  |
| hostPathMounts[0].size | string | `"100Gi"` |  |
| hostPathMounts[0].type | string | `"pvc"` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"akhilrex/podgrab"` |  |
| image.tag | string | `"1.0.0"` |  |
| persistence.config.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.config.size | string | `"100Gi"` |  |
| persistence.config.type | string | `"pvc"` |  |
| podSecurityContext.fsGroup | int | `568` |  |
| podSecurityContext.runAsGroup | int | `568` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `568` |  |
| probes.liveness.enabled | bool | `false` |  |
| probes.readiness.enabled | bool | `false` |  |
| probes.startup.enabled | bool | `false` |  |
| service.main.ports.main.port | int | `8080` |  |
| service.tcp.enabled | bool | `true` |  |
| service.tcp.ports.tcp.enabled | bool | `true` |  |
| service.tcp.ports.tcp.port | int | `51080` |  |
| service.tcp.ports.tcp.protocol | string | `"TCP"` |  |
| service.tcp.type | string | `"ClusterIP"` |  |
| strategy.type | string | `"Recreate"` |  |

All Rights Reserved - The TrueCharts Project
