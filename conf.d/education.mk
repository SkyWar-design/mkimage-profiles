# ALT Education

mixin/education: use/kernel use/firmware \
	+systemd \
	use/services \
	use/ntp/chrony \
	use/x11/xorg use/x11/lightdm/gtk +pulse \
	+nm use/x11/gtk/nm use/net-eth/dhcp \
	use/xdg-user-dirs/deep
	@$(call set,BRANDING,alt-education)
	@$(call add,THE_BRANDING,indexhtml)
	@$(call add,THE_BRANDING,menu xfce-settings system-settings)
	@$(call add,THE_LISTS,slinux/xfce-base)
	@$(call add,THE_LISTS,slinux/misc-base)
	@$(call add,THE_LISTS,gnome-p2p)
	@$(call add,THE_LISTS,$(call tags,base l10n))
	@$(call add,BASE_LISTS,education/base)
	@$(call add,BASE_LISTS,workstation/3rdparty)
	@$(call add,THE_LISTS,education/misc)
	@$(call add,THE_PACKAGES,usbutils pv lftp links2 openssh-server xinput xorg-drv-libinput)
	@$(call add,THE_PACKAGES,net-tools fdisk gdisk parted partclone)
	@$(call add,THE_PACKAGES,disable-usb-autosuspend)
	@$(call add,THE_LISTS,$(call tags,base regular))

ifeq (distro,$(IMAGE_CLASS))

distro/education: distro/alt-education; @:
distro/alt-education: distro/.installer mixin/education \
	use/memtest \
	use/branding/complete \
	use/live/install use/live/suspend \
	use/live/repo use/live/x11 use/live/rw \
	use/install2/vnc use/install2/full \
	use/l10n/default/ru_RU +vmguest \
	+efi use/efi/refind use/efi/shell \
	use/isohybrid use/luks \
	+plymouth +wireless \
	use/install2/fonts
	@$(call set,INSTALLER,education)
	@$(call set,META_APP_ID,ALT Education)
	@$(call set,META_VOL_SET,ALT)
	@$(call set,META_PUBLISHER,BaseALT Ltd)
	@$(call add,INSTALL2_PACKAGES,disable-usb-autosuspend)
	@$(call add,INSTALL2_PACKAGES,installer-feature-samba-usershares-stage2)
	@$(call add,MAIN_LISTS,slinux/not-install-full)
	@$(call add,MAIN_GROUPS,education/01_preschool)
	@$(call add,MAIN_GROUPS,education/02_gradeschool)
	@$(call add,MAIN_GROUPS,education/03_highschool)
	@$(call add,MAIN_GROUPS,education/04_secondary_vocational)
	@$(call add,MAIN_GROUPS,education/05_university)
	@$(call add,MAIN_GROUPS,education/teacher)
	@$(call add,MAIN_GROUPS,education/kde5)
	@$(call add,MAIN_GROUPS,education/server-apps-edu)
ifeq (,$(filter-out i586 x86_64,$(ARCH)))
	@$(call set,KFLAVOURS,std-def)
	@$(call add,THE_KMODULES,virtualbox)
	@$(call add,THE_KMODULES,nvidia)
	@$(call add,THE_KMODULES,lsadrv bbswitch)
	@$(call add,THE_KMODULES,staging)
	@$(call add,MAIN_KMODULES,bbswitch)
	@$(call add,THE_PACKAGES,xorg-drv-vmware xorg-drv-vmmouse)
	@$(call add,THE_PACKAGES,syslinux)
	@$(call add,MAIN_PACKAGES,owamp-server)
endif
	@$(call add,THE_PACKAGES,bluez pulseaudio-bluez)
	@$(call add,THE_PACKAGES,alterator-fbi)
	@$(call add,THE_PACKAGES,alt-rootfs-installer)
	@$(call add,BASE_PACKAGES,os-prober)
	@$(call add,BASE_PACKAGES,guest-account)
	@$(call add,BASE_PACKAGES,nextcloud-client)
	@$(call add,MAIN_PACKAGES,iperf3)
	@$(call add,MAIN_PACKAGES,stellarium)
	@$(call add,MAIN_PACKAGES,libreoffice-block-macros)
	@$(call add,MAIN_PACKAGES,lmms)
	@$(call add,STAGE1_MODLISTS,stage2-mmc)
	@$(call set,GLOBAL_LIVE_NO_CLEANUPDB,true)
	@$(call add,LIVE_PACKAGES,livecd-timezone)
	@$(call add,LIVE_LISTS,slinux/network-base)
	@$(call add,LIVE_LISTS,$(call tags,base rescue))
	@$(call add,STAGE2_PACKAGES,xorg-conf-libinput-touchpad)
	@$(call add,STAGE2_PACKAGES,chrony)
	@$(call add,STAGE1_MODLISTS,stage2-mmc)
endif

ifeq (vm,$(IMAGE_CLASS))
ifeq (,$(filter-out aarch64 armh,$(ARCH)))

vm/education: vm/alt-education; @:
vm/alt-education: vm/systemd use/repo use/x11/armsoc \
	use/oem use/bootloader/uboot mixin/education
	@$(call add,DEFAULT_SERVICES_DISABLE,multipathd)

endif
endif
