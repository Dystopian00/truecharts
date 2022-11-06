{{/* Define the configmap */}}
{{- define "misskey.configmap" -}}

---
apiVersion: v1
kind: ConfigMap
metadata:
  name: misskeyconfig
data:
  default.yml: |-
    #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    # Misskey configuration
    #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    #   ┌─────┐
    #───┘ URL └─────────────────────────────────────────────────────

    # Final accessible URL seen by a user.
    # url: https://example.tld/

    # ONCE YOU HAVE STARTED THE INSTANCE, DO NOT CHANGE THE
    # URL SETTINGS AFTER THAT!

    #   ┌───────────────────────┐
    #───┘ Port and TLS settings └───────────────────────────────────

    #
    # Misskey supports two deployment options for public.
    #

    # Option 1: With Reverse Proxy
    #
    #                 +----- https://example.tld/ ------------+
    #   +------+      |+-------------+      +----------------+|
    #   | User | ---> || Proxy (443) | ---> | Misskey (3000) ||
    #   +------+      |+-------------+      +----------------+|
    #                 +---------------------------------------+
    #
    #   You need to setup reverse proxy. (eg. nginx)
    #   You do not define 'https' section.

    # Option 2: Standalone
    #
    #                 +- https://example.tld/ -+
    #   +------+      |   +---------------+    |
    #   | User | ---> |   | Misskey (443) |    |
    #   +------+      |   +---------------+    |
    #                 +------------------------+
    #
    #   You need to run Misskey as root.
    #   You need to set Certificate in 'https' section.

    # To use option 1, uncomment below line.
    port: {{ .Values.service.main.ports.main.port }} # A port that your Misskey server should listen.

    # To use option 2, uncomment below lines.
    #port: 443

    #https:
    #  # path for certification
    #  key: /etc/letsencrypt/live/example.tld/privkey.pem
    #  cert: /etc/letsencrypt/live/example.tld/fullchain.pem

    #   ┌──────────────────────────┐
    #───┘ PostgreSQL configuration └────────────────────────────────

    db:
      host: {{ printf "%v-%v" .Release.Name "postgresql" }}
      port: 5432

      # Database name
      db: {{ .Values.postgresql.postgresqlDatabase }}

      # Auth
      user: {{ .Values.postgresql.postgresqlUsername }}
      pass: {{ .Values.postgresql.postgresqlPassword }}

      # Whether disable Caching queries
      #disableCache: true

      # Extra Connection options
      #extra:
      #  ssl: true

    #   ┌─────────────────────┐
    #───┘ Redis configuration └─────────────────────────────────────

    redis:
      host: {{ printf "%v-%v" .Release.Name "redis" }}
      port: 6379
      pass: {{ .Values.redis.redisPassword }}
      #prefix: example-prefix
      #db: 1

    #   ┌─────────────────────────────┐
    #───┘ Elasticsearch configuration └─────────────────────────────

    #elasticsearch:
    #  host: localhost
    #  port: 9200
    #  ssl: false
    #  user:
    #  pass:

    #   ┌───────────────┐
    #───┘ ID generation └───────────────────────────────────────────

    # You can select the ID generation method.
    # You don't usually need to change this setting, but you can
    # change it according to your preferences.

    # Available methods:
    # aid ... Short, Millisecond accuracy
    # meid ... Similar to ObjectID, Millisecond accuracy
    # ulid ... Millisecond accuracy
    # objectid ... This is left for backward compatibility

    # ONCE YOU HAVE STARTED THE INSTANCE, DO NOT CHANGE THE
    # ID SETTINGS AFTER THAT!

    id: {{ .Values.misskey.id }}
    #   ┌─────────────────────┐
    #───┘ Other configuration └─────────────────────────────────────

    # Whether disable HSTS
    #disableHsts: true

    # Number of worker processes
    #clusterLimit: 1

    # Job concurrency per worker
    # deliverJobConcurrency: 128
    # inboxJobConcurrency: 16

    # Job rate limiter
    # deliverJobPerSec: 128
    # inboxJobPerSec: 16

    # Job attempts
    # deliverJobMaxAttempts: 12
    # inboxJobMaxAttempts: 8

    # IP address family used for outgoing request (ipv4, ipv6 or dual)
    #outgoingAddressFamily: ipv4

    # Syslog option
    #syslog:
    #  host: localhost
    #  port: 514

    # Proxy for HTTP/HTTPS
    #proxy: http://127.0.0.1:3128

    #proxyBypassHosts: [
    #  'example.com',
    #  '192.0.2.8'
    #]

    # Proxy for SMTP/SMTPS
    #proxySmtp: http://127.0.0.1:3128   # use HTTP/1.1 CONNECT
    #proxySmtp: socks4://127.0.0.1:1080 # use SOCKS4
    #proxySmtp: socks5://127.0.0.1:1080 # use SOCKS5

    # Media Proxy
    #mediaProxy: https://example.com/proxy

    # Sign to ActivityPub GET request (default: false)
    #signToActivityPubGet: true

    #allowedPrivateNetworks: [
    #  '127.0.0.1/32'
    #]

    # Upload or download file size limits (bytes)
    #maxFileSize: 262144000
    url: {{ .Values.misskey.url }}


{{- end -}}
