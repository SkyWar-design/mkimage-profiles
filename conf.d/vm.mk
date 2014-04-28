# virtual machines
ifeq (vm,$(IMAGE_CLASS))

vm/bare: vm/.bare +sysvinit
	@$(call add,BASE_PACKAGES,apt)

vm/net: vm/bare use/net-eth/dhcp use/net-ssh use/repo use/control/sudo-su
	@$(call add,BASE_PACKAGES,su)

# NB: use/x11 employs some installer-feature packages
vm/.desktop-bare: vm/net use/x11/xorg use/cleanup/installer use/repo; @:

vm/.desktop-base: vm/.desktop-bare \
	use/deflogin/altlinuxroot use/x11-autologin; @:

mixin/icewm: use/x11/lightdm/gtk +icewm; @:

vm/icewm: vm/.desktop-base mixin/icewm; @:

vm/icewm-setup: vm/.desktop-bare mixin/icewm use/oem use/x11-autostart
	@$(call set,BRANDING,simply-linux)
	@$(call add,THE_BRANDING,graphics)
	@$(call add,THE_LISTS,$(call tags,base l10n))

endif
