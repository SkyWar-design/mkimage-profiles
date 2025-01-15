use/atomic-installer:
	@$(call add_feature)
	@$(call add,LIVE_PACKAGES,git podman fuse-overlayfs golang btrfs-progs)
	@echo "Копирование содержимого rootfs/"
	@rsync -a features.in/atomic-installer/rootfs/ $(BUILDDIR)/