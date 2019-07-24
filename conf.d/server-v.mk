# server distributions
ifeq (distro,$(IMAGE_CLASS))

distro/server-v: cockpit = $(addprefix server-v/cockpit/,\
	docker kvm web)

distro/server-v: ceph = $(addprefix server-v/ceph/,\
	client mgr mon osd radosgw)

distro/server-v: glusterfs = $(addprefix server-v/glusterfs/,\
	client server)

distro/server-v: iscsi = $(addprefix server-v/iscsi/,\
	initiator  scsitarget  targetcli)

distro/server-v: moosefs = $(addprefix server-v/moosefs/,\
	cgiserv chunkserver client master metalogger)

distro/server-v: lizardfs = $(addprefix server-v/lizardfs/,\
	cgiserv chunkserver client master metalogger)

distro/server-v: nfs = $(addprefix server-v/,\
	nfs nfs-ganesha)

distro/server-v: opennebula = $(addprefix server-v/opennebula/,\
	flow gate gui node-kvm node-lxd server)

distro/server-v: openstack = $(addprefix server-v/openstack/,\
	block compute controller network)
# storage

distro/server-v: container = $(addprefix server-v/,\
	docker kubernetes rkt podman lxd)

distro/server-v: network = $(addprefix server-v/,\
	apache2 nginx bird dhcp dns haproxy keepalived openvswitch freeipa-client)

distro/server-v: monitoring = $(addprefix server-v/,\
	zabbix-agent telegraf prometheus-node_exporter monit collectd nagios-nrpe)
# zabbix prometheus influxdb grafana

distro/server-v: backup = $(addprefix server-v/,\
	bacula urbackup-client)

distro/server-v: logging = $(addprefix server-v/,\
	rsyslog-classic systemd-journal-remote)

distro/server-v: profiles = $(addprefix server-v/,\
	110-basic 120-pve 131-opennebula-node 132-opennebula-server 141-openstack-node 142-openstack-controller 201-docker)

ifeq (,$(filter-out x86_64,$(ARCH)))
distro/server-v: profiles_arch = $(addprefix server-v/,\
	120-pve)
endif

distro/.server-v-base: distro/.installer use/syslinux/ui/menu use/memtest
	@$(call add,BASE_LISTS,server-base openssh)

distro/server-v: distro/.server-v-base +installer +systemd \
	use/kernel/server use/init/systemd/multiuser \
	use/services use/ntp/chrony \
	use/server/base use/branding/complete use/firmware use/firmware/cpu \
	use/l10n/default/ru_RU use/install2/vnc \
	use/install2/xfs use/install2/fat \
	use/net/etcnet use/net-ssh \
	use/apt-conf/branch use/install2/repo \
	use/fonts/install2 \
	use/efi/shell +efi
	@$(call set,IMAGE_FLAVOUR,$(subst alt-9-,,$(IMAGE_NAME)))
	@$(call set,META_VOL_ID,ALT Server-V 9.0.0 $(ARCH))
	@$(call set,META_PUBLISHER,BaseALT Ltd)
	@$(call set,META_VOL_SET,ALT)
	@$(call set,META_APP_ID,ALT Server-V 9.0.0 $(ARCH) $(shell date +%F))
	@$(call set,DOCS,alt-server)
	@$(call set,BRANDING,alt-server)
	@$(call add,STAGE1_MODLISTS,stage2-mmc)
	@$(call set,INSTALLER,alt-server-v)
	@$(call add,INSTALL2_PACKAGES,alterator-notes)
	@$(call add,INSTALL2_PACKAGES,fdisk xfsprogs btrfs-progs)
	@$(call add,INSTALL2_PACKAGES,installer-feature-multipath)
	@$(call add,INSTALL2_PACKAGES,installer-feature-server-raid-fixup-stage2)
	@$(call add,THE_PACKAGES,alterator-fbi)
	@$(call add,THE_LISTS,$(call tags,server alterator))
	@$(call add,COMMON_PACKAGES,vim-console)
	@$(call add,SYSTEM_PACKAGES,mdadm-tool lvm2 multipath-tools vdo)
	@$(call add,BASE_KMODULES,ipset kvm xtables-addons kvdo)
	@$(call add,BASE_LISTS,virt/base.pkgs)
	@$(call add,MAIN_GROUPS,server-v/110-basic server-v/kvm)
ifeq (,$(filter-out x86_64,$(ARCH)))
	@$(call add,MAIN_GROUPS,server-v/120-pve server-v/pve)
endif
	@$(call add,MAIN_GROUPS,server-v/130-opennebula $(opennebula))
	@$(call add,MAIN_GROUPS,server-v/140-openstack $(openstack))
	@$(call add,MAIN_GROUPS,server-v/200-container $(container))
	@$(call add,MAIN_GROUPS,server-v/300-cluster server-v/corosync_pacemaker)
	@$(call add,MAIN_GROUPS,server-v/400-storage)
	@$(call add,MAIN_GROUPS,server-v/410-ceph $(ceph))
	@$(call add,MAIN_GROUPS,server-v/420-glusterfs $(glusterfs))
	@$(call add,MAIN_GROUPS,server-v/430-moosefs $(moosefs))
	@$(call add,MAIN_GROUPS,server-v/450-nfs $(nfs))
	@$(call add,MAIN_GROUPS,server-v/460-iscsi $(iscsi))
	@$(call add,MAIN_GROUPS,server-v/ocfs2)
	@$(call add,MAIN_GROUPS,server-v/500-network $(network))
	@$(call add,MAIN_GROUPS,server-v/600-monitoring $(monitoring))
	@$(call add,MAIN_GROUPS,server-v/700-backup $(backup))
	@$(call add,MAIN_GROUPS,server-v/800-logging $(logging))
	@$(call add,THE_PROFILES,$(profiles) $(profiles_arch) minimal)
	@$(call add,DEFAULT_SERVICES_ENABLE,getty@tty1 getty@ttyS0)
	@$(call add,DEFAULT_SERVICES_ENABLE,fstrim.timer)
	@$(call add,DEFAULT_SERVICES_ENABLE,libvirtd)
	@$(call add,DEFAULT_SERVICES_ENABLE,docker lxd)
	@$(call add,DEFAULT_SERVICES_ENABLE,bind nginx httpd2 mysqld openvswitch)
	@$(call add,DEFAULT_SERVICES_ENABLE,zabbix_agentd telegraf prometheus-node_exporter prometheus monit collectd nrpe)
	@$(call add,DEFAULT_SERVICES_ENABLE,bacula-sd urbackup-client)
	@$(call add,DEFAULT_SERVICES_ENABLE,rsyslogd systemd-journal-remote systemd-journal-upload systemd-journal-gatewayd)
	@$(call add,DEFAULT_SERVICES_DISABLE,powertop bridge gpm)
	@$(call add,DEFAULT_SERVICES_DISABLE,consolesaver)
	@$(call add,DEFAULT_SERVICES_DISABLE,ahttpd alteratord)
	@$(call add,DEFAULT_SERVICES_DISABLE,systemd-networkd systemd-resolved)

#	@$(call add,MAIN_GROUPS,server-v/111-cockpit $(cockpit))
endif
