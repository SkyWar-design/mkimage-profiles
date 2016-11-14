ifeq (distro,$(IMAGE_CLASS))

distro/alt-workstation: workstation_groups = $(addprefix workstation/,\
	10-office 20-networking 30-multimedia 40-virtualization 50-publishing \
	3rdparty blender clamav emulators gnome-peer-to-peer graphics-editing \
	gtk-dictionary libreoffice mate-usershare pidgin raccess \
	scanning scribus sound-editing vlc \
	freecad ganttproject thunderbird \
	kvm virtualbox)

distro/alt-workstation: distro/.base use/luks  \
	+installer +sysvinit +power +systemd +pulse +vmguest +wireless +efi \
	use/kernel/net use/docs/license \
	use/vmguest use/memtest \
	use/bootloader/grub \
	use/install2/fs use/install2/vnc use/install2/repo \
	use/install2/suspend use/x11/xorg use/sound use/xdg-user-dirs \
	mixin/desktop-installer \
	use/efi/refind use/efi/shell use/rescue/base \
	use/branding use/syslinux/ui/gfxboot use/plymouth/full \
	use/fonts/install2 use/install2/fs \
	use/fonts/otf/adobe use/fonts/otf/mozilla \
	use/fonts/ttf/google/extra use/fonts/ttf/redhat use/fonts/ttf/ubuntu \
	use/l10n/default/ru_RU \
	use/control use/services \
	use/live/install use/live/suspend use/live/x11 use/live/repo \
	use/live/rw \
	use/x11/lightdm/gtk use/docs/manual use/x11/gtk/nm +nm \
	use/fonts/ttf/google use/domain-client/full \
	use/browser/firefox use/browser/firefox/esr
	@$(call set,BRANDING,alt-workstation)
	@$(call add,THE_BRANDING,graphics mate-settings)
	@$(call add,THE_BRANDING,alterator bootloader bootsplash graphics)
	@$(call add,THE_BRANDING,notes slideshow)
	@$(call set,INSTALLER,altlinux-desktop)
	@$(call add,INSTALL2_BRANDING,notes slideshow)
	@$(call add,INSTALL2_BRANDING,alterator notes)
	@$(call add,INSTALL2_PACKAGES,alterator-notes)
	@$(call add,INSTALL2_PACKAGES,volumes-profile-regular)
	@$(call add,INSTALL2_PACKAGES,open-iscsi)
	@$(call add,COMMON_PACKAGES,vim-console)
	@$(call add,MAIN_PACKAGES,solaar)
	@$(call add,MAIN_GROUPS,$(workstation_groups))
	@$(call add,MAIN_LISTS,workstation/extras)
	@$(call add,MAIN_LISTS,$(call tags,xorg vaapi))
	@$(call add,BASE_LISTS,workstation/base.pkgs)
	@$(call add,BASE_LISTS,$(call tags,desktop cups))
	@$(call add,LIVE_LISTS,workstation/live.pkgs)
	@$(call add,LIVE_LISTS,$(call tags,desktop sane))
	@$(call add,LIVE_LISTS,$(call tags,desktop office))
	@$(call add,THE_LISTS,workstation/mate)
	@$(call add,THE_LISTS,workstation/the.pkgs)
	@$(call add,THE_LISTS,$(call tags,regular desktop))
	@$(call add,THE_LISTS,$(call tags,base regular))
	@$(call add,THE_LISTS,$(call tags,base l10n))
	@$(call add,THE_LISTS,$(call tags,base desktop))
	@$(call add,THE_LISTS,$(call tags,archive extra))
	@$(call add,THE_LISTS,$(call tags,mobile mate))
	@$(call add,THE_KMODULES,staging)
	@$(call add,BASE_KMODULES,kvm virtualbox)
	@$(call add,CLEANUP_PACKAGES,xterm)
	@$(call add,EFI_BOOTARGS,lang=ru_RU)
	@$(call add,RESCUE_BOOTARGS,nomodeset vga=0)
	@$(call add,CONTROL,xdg-user-dirs:enabled)
	@$(call add,SERVICES_ENABLE,sshd)
	@$(call add,SERVICES_ENABLE,cups smb nmb httpd2 bluetoothd libvirtd)
	@$(call add,DEFAULT_SERVICES_ENABLE,fstrim.timer)
	@$(call add,DEFAULT_SERVICES_DISABLE,powertop bridge)
	@$(call set,META_PUBLISHER,BaseALT Ltd)
	@$(call set,META_VOL_SET,ALT)
	@$(call set,META_VOL_ID,ALT Workstation)
	@$(call set,META_APP_ID,8.1/$(ARCH))
	@$(call set,DOCS,alt-workstation)

endif
