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
| image.repository | string | `"ghcr.io/truecharts/memcached"` |  |
| image.tag | string | `"v1.6.14@sha256:e15b8aef2c256f24b139e2f4d1850d3367fc91e14a3dce5bd16f7867fcebbf77"` |  |
| service.main.ports.main.port | int | `11211` |  |
| service.main.ports.main.targetPort | int | `11211` |  |

All Rights Reserved - The TrueCharts Project
