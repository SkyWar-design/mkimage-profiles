+pulse: use/sound/pulse; @:

# "bare" ALSA (which is good enough for many of us) with persistent levels
use/sound:
	@$(call add_feature)
	@$(call add,THE_KMODULES,alsa sound)
	@$(call add,THE_PACKAGES,amixer alsa-utils aplay udev-alsa)

# PulseAudio (useful for per-app levels, dynamic devices and networked sound)
use/sound/pulse: use/sound
	@$(call add,THE_LISTS,pulseaudio)
