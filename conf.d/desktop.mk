# desktop distributions
ifeq (distro,$(IMAGE_CLASS))

distro/.desktop-base: distro/.installer use/syslinux/ui/vesamenu use/x11/xorg
	@$(call set,INSTALLER,desktop)

distro/.desktop-mini: distro/.desktop-base use/x11/xdm +power; @:

distro/.desktop-network: distro/.desktop-mini use/virtualbox/guest
	@$(call add,BASE_LISTS,$(call tags,(base || desktop) && network))

distro/icewm: distro/.desktop-network use/lowmem +icewm; @:
distro/tde: distro/.desktop-mini +tde; @:
distro/ltsp-tde: distro/tde +ltsp; @:
distro/ltsp-icewm: distro/icewm +ltsp; @:
distro/desktop-systemd: distro/icewm use/systemd; @:

endif
