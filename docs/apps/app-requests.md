# App Request List

_This list is to track `App Requests` from one place._

 -> New app request should be made by creating a new issue. The issue will be checked if it's viable, linked here and closed. <-

 *Note that the order of the list is not the order that each app will be added! For an app to be added, it would need someone to make a PR for it*

- [ ] Still to be added to TrueCharts
- [x] Already added to TrueCharts

❌ Not likely to be added to TrueCharts (Please add reason)

### Apps

- [ ] Flexget #726
- [ ] Seafile #725
- [ ] dnsmasq #711
- [ ] Deemix #628
- [ ] Trackarr #602
- [ ] Steamcmd & 7 Days to die #599
- [ ] Locast2Plex #473
- [ ] Taiga #438
- [ ] Wordpress #437
- [ ] Synapse (Matrix Server) #410
- [ ] Umbrel #404
- [ ] Netdata #280
- [ ] Appwrite/Parse Framework #278
- [ ] Prometheus #275
- [ ] Requestarr #237
- [ ] GitLab #227
- [ ] Scrutiny #198
- [ ] MovieNight #139
- [ ] LanCache #138
- [ ] Phabricator #122
- [ ] ApacheGuacamole #103
- [ ] n8n #27
- [ ] InfluxDB #5
- [ ] Grafana #4
- [ ] External-Auth-Server #28
- [ ] Borg Backup #782
- [ ] Krusader #794
- [ ] WeblateOrg #817
- [ ] ElectrumX #881
- [ ] Restic #897
- [ ] External-DNS #905
- [ ] Shoko #917
- [ ] kodbox #965
- [ ] Zabbix-Agent
- [ ] Zabbix-Server
- [ ] Filestash #1000
- [ ] UISP #1007
- [ ] Openspeedtest #1018
- [ ] LinkAce #1020
- [ ] Zoneminder #1021
- [ ] OpenHAB #1043
- [ ] Logitech Media Server #1062
- [ ] Suricata #1063
- [ ] Jitsi Meet #1064
- [ ] Mumble Server #1065
- [ ] Quassel IRC #1070
- [ ] KodBox #1079
- [ ] oauth2-proxy
- [ ] DokuWiki #1115
- [ ] Storj Node #1086
- [ ] PiGallery2 #1116

##### TODO: Requires Postgresql customisation
- [ ] Keycloack #1106

##### TODO: Requires MariaDB to be added first
- [ ] FreePBX #1111

### Apps that not have a specific candidate yet.

- [ ] DMS (Document Manage System) #810
- [ ] Mail Server #274
- [ ] Log Manager #509
- [ ] FTP Client #615
- [ ] Web Server #273
- [ ] Minecraft Server #314
- [ ] Printer/Scanner server (CUPS for example) #1024
- [ ] Private torrent tracker (OpenTracker for example) #1025

### Apps to port from a specific source

This is a list of Helm charts in the popular[ k8s-at-home ](https://github.com/k8s-at-home/charts) repository that we aim to one day port all port to TrueCharts.

It below [k8s-at-home ](https://github.com/k8s-at-home/charts) it also includes some "sister" repositories, that feature Charts that are very close to  [k8s-at-home ](https://github.com/k8s-at-home/charts), but not quite. However the porting process should be relatively similair.

#### [ k8s-at-home ](https://github.com/k8s-at-home/charts)

##### TODO: Require custom care to handle their configuration

- [ ] adguard-home
- [ ] blocky
- [ ] comcast
- [ ] Frigate #871
- [ ] games-on-whales
- [ ] gollum
- [ ] homer
- [ ] magic-mirror
- [ ] modem-stats
- [ ] neolink
- [ ] network-ups-tools
- [ ] onedrive
- [ ] rtorrent-flood
- [ ] searx
- [ ] sharry

##### TODO: Requires Postgresql customisation

- [ ] dsmr-reader
- [ ] joplin-server
- [ ] kanboard
- [ ] librespeed
- [ ] miniflux
- [ ] openkm
- [ ] powerdns
- [ ] shlink
- [ ] statping
- [ ] teedy
- [ ] teslamate
- [ ] traccar
- [ ] tt-rss
- [ ] wallabag
- [ ] wikijs
- [ ] recipes

##### TODO: Requires Prometheus to be added first

- [ ] alertmanager-bot
- [ ] promcord
- [ ] prometheus-nut-exporter
- [ ] speedtest-exporter
- [ ] unifi-poller
- [ ] uptimerobot-prometheus
- [ ] traefik-forward-auth
- [ ] uptimerobot
- [ ] vikunja
- [ ] youtubedl-material

##### TODO: Requires MongoDB to be added first

- [ ] overleaf

##### TODO: Requires MariaDB to be added first

- [ ] anonaddy
- [ ] baikal
- [ ] bookstack
- [ ] icinga2
- [ ] monica
- [ ] openemr
- [ ] xbackbone

##### TODO: Other Complications

_These Apps have specific requirements or need specific customisation and care_

- [ ] foundryvtt
- [ ] homebridge
- [ ] jetbrains-projector
- [ ] paperless
- [ ] tdarr



#### [ nicholaswilde ](https://github.com/nicholaswilde/helm-charts)

##### TODO: Require custom care to handle their configuration

- [ ] olivetin
- [ ] writefreely

##### TODO: Requires Postgresql customisation

- [ ] babybuddy
- [ ] etherpad
- [ ] odoo
- [ ] papermerge
- [ ] shiori
- [ ] firefox-syncserver
- [ ] gotify
- [ ] chyrp-lite

##### TODO: Requires MariaDB to be added first

- [ ] clarkson
- [ ] friendica
- [ ] projectsend
- [ ] snipe-it
- [ ] formalms
- [ ] leantime
- [ ] blog
- [ ] bookstack

##### TODO: Other Complications

- [ ] boinc-client
- [ ] hedgedoc
- [ ] mariadb
- [ ] cryptpad

### Not Likely to be added

:x: pod-gateway (while a one-vpn-app app sounds nice, it would be extremely complicated to give it an acceptable user experience)

:x: dnsmadeeasy-webhook (We do not support the underlaying cert-manager system as we use TrueNAS SCALE Certs)

:x: intel-gpu-plugin (Already Integrated in TrueNAS SCALE)

:x: multus (We use the CNI supplied by TrueNAS SCALE)

:x: samba (Already Integrated into TrueNAS SCALE)

:x: smarter-device-manager (preferably iX finds a way of implementing something like this)

:x: zalando-postgres-cluster (We need to deploy the actual operator as an app instead)

:x: Nginx Proxy Manager #1019 (Doesn't fit very well in the kubernetes ecosystem, might cause confusion and or support issues)

:x: diun ( The general feature is already integrated into SCALE)

:x: pterodactyl (Not natively compatible with k8s, would most likely go totally haywire when clustering launches)

:x: booksonic (is *depricated* by upstream )

:x: installer (an installer-ecosystem, within an installer ecosystem (scale) seems a bit weird)

:x: static (Upstream project disapeared)

:x: todo (Upstream project disapeared)

### Completed App Requests

- [x] JDownloader2 #613
- [x] Gitea #291
- [x] OnlyOffice Document Server #192
- [x] Pihole #12
- [x] Authelia #1
- [x] Photo Manager #293
- [x] airsonic
- [x] appdaemon
- [x] bazarr
- [x] calibre
- [x] calibre-web
- [x] deconz
- [x] deluge
- [x] dizquetv
- [x] duplicati
- [x] emby
- [x] esphome
- [x] flaresolverr
- [x] flood
- [x] focalboard
- [x] freshrss
- [x] gaps
- [x] gonic
- [x] grocy
- [x] haste-server
- [x] healthchecks
- [x] heimdall
- [x] home-assistant
- [x] hyperion-ng
- [x] jackett
- [x] jellyfin
- [x] komga
- [x] lazylibrarian
- [x] lidarr
- [x] lychee
- [x] mealie
- [x] mosquitto
- [x] mylar
- [x] navidrome
- [x] node-red
- [x] nullserv
- [x] nzbget
- [x] nzbhydra2
- [x] octoprint
- [x] omada-controller
- [x] ombi
- [x] organizr
- [x] overseerr
- [x] owncast
- [x] owncloud-ocis
- [x] photoprism
- [x] piaware
- [x] plex
- [x] pretend-youre-xyzzy
- [x] protonmail-bridge
- [x] prowlarr
- [x] pyload
- [x] qbittorrent
- [x] radarr
- [x] readarr
- [x] reg
- [x] resilio-sync
- [x] sabnzbd
- [x] ser2sock
- [x] sonarr
- [x] stash
- [x] syncthing
- [x] tautulli
- [x] thelounge
- [x] transmission
- [x] truecommand
- [x] tvheadend
- [x] unifi
- [x] unpackerr
- [x] vaultwarden
- [x] xteve
- [x] zwavejs2mqtt
- [x] haste
- [x] postgres
- [x] syncthing
- [x] transmission
- [x] apache-musicindex
- [x] aria2
- [x] booksonic-air
- [x] cryptofolio
- [x] icantbelieveitsnotvaletudo
- [x] minio-console
- [x] valheim
- [x] whoogle
- [x] amcrest2mqtt
- [x] audacity
- [x] beets
- [x] cloud9
- [x] code-server
- [x] davos
- [x] digikam
- [x] doublecommander
- [x] filezilla
- [x] fossil
- [x] golinks
- [x] grav
- [x] headphones
- [x] leaf2mqtt
- [x] medusa
- [x] mstream
- [x] muximux
- [x] notes
- [x] novnc
- [x] photoshow
- [x] piwigo
- [x] pixapop
- [x] remmina
- [x] shorturl
- [x] sickchill
- [x] sickgear
- [x] smokeping
- [x] sqlitebrowser
- [x] twtxt
- [x] wiki
- [x] zigbee2mqtt
- [x] podgrab
- [x] Uptime Kuma #1097
