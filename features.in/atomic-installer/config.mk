use/atomic-installer:
	@$(call add_feature)
	@$(call add,LIVE_PACKAGES,git podman fuse-overlayfs golang btrfs-progs)
	@$(call add,DEPENDENCIES,sub/rootfs@/)