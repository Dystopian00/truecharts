# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/truecharts/syncthing"` |  |
| image.tag | string | `"v1.18.2@sha256:780c4924c4739d707295bd74fd21a186a640bd71f15efc2fcbc9fb9b05162a0d"` |  |
| persistence.config.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/var/syncthing/"` |  |
| persistence.config.size | string | `"100Gi"` |  |
| persistence.config.type | string | `"pvc"` |  |
| podSecurityContext.fsGroup | int | `568` |  |
| podSecurityContext.fsGroupChangePolicy | string | `"OnRootMismatch"` |  |
| podSecurityContext.runAsGroup | int | `568` |  |
| podSecurityContext.runAsUser | int | `568` |  |
| podSecurityContext.supplementalGroups | list | `[]` |  |
| securityContext.allowPrivilegeEscalation | bool | `true` |  |
| securityContext.privileged | bool | `false` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| service.discovery.ports.discovery.enabled | bool | `true` |  |
| service.discovery.ports.discovery.port | int | `21027` |  |
| service.discovery.ports.discovery.protocol | string | `"UDP"` |  |
| service.listeners.ports.tcp.enabled | bool | `true` |  |
| service.listeners.ports.tcp.port | int | `22000` |  |
| service.listeners.ports.tcp.protocol | string | `"TCP"` |  |
| service.listeners.ports.udp.enabled | bool | `true` |  |
| service.listeners.ports.udp.port | int | `22000` |  |
| service.listeners.ports.udp.protocol | string | `"UDP"` |  |
| service.main.ports.main.port | int | `8384` |  |

All Rights Reserved - The TrueCharts Project
