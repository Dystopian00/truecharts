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
| image.repository | string | `"golift/unpackerr"` |  |
| image.tag | string | `"0.9.7"` |  |
| persistence.downloads.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.downloads.enabled | bool | `true` |  |
| persistence.downloads.mountPath | string | `"/downloads"` |  |
| persistence.downloads.size | string | `"100Gi"` |  |
| persistence.downloads.type | string | `"pvc"` |  |
| portal.enabled | bool | `false` |  |
| probes.liveness.enabled | bool | `false` |  |
| probes.readiness.enabled | bool | `false` |  |
| probes.startup.enabled | bool | `false` |  |
| service.main.enabled | bool | `false` |  |
| service.main.ports.main.enabled | bool | `false` |  |
| strategy.type | string | `"Recreate"` |  |

All Rights Reserved - The TrueCharts Project
