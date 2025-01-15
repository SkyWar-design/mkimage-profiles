# install locales
# setup locale
# setup console keyboard (kbd)
# setup X11 keyboard (xkb)
# install/setup additional packages

# TODO: KEYMAP for default keymap?
use/l10n:
	@$(call add_feature)
	@$(call add,THE_LISTS,$(call tags,base l10n))
	@$(call add,LOCALES,en_US)
	@$(call add,XKB_KEYMAPS,us)
	@$(call try,LOCALE,en_US)
	@$(call xport,LOCALE)
	@$(call xport,LOCALES)
	@$(call xport,XKB_KEYMAPS)
	@$(call xport,XKB_SWITCH)
	@$(call xport,GNOME_KB_SWITCH)

# see also alterator-sysconfig backend
use/l10n/xkb/switch/ctrl_shift: use/l10n
	@$(call set,XKB_SWITCH,grp:ctrl_shift_toggle)
	@$(call set,GNOME_KB_SWITCH,<Ctrl>Shift_L)

use/l10n/xkb/switch/alt_shift: use/l10n
	@$(call set,XKB_SWITCH,grp:alt_shift_toggle)
	@$(call set,GNOME_KB_SWITCH,<Shift>Alt_L)

use/l10n/simple_ru_RU: use/l10n
	@$(call add,LOCALES,ru_RU)
	@$(call set,LOCALE,ru_RU)
	@$(call add,XKB_KEYMAPS,ru)
	@$(call set,KEYTABLE,ruwin_alt_sh-UTF-8)

# FIXME: derive from locale by default if possible
use/l10n/ru_RU: use/l10n/xkb/switch/alt_shift
	@$(call add,LOCALES,ru_RU)
	@$(call set,LOCALE,ru_RU)
	@$(call add,XKB_KEYMAPS,ru)
	@$(call set,KEYTABLE,ruwin_alt_sh-UTF-8)

# NB: BOOT_LANG is used within mkimage internally
use/l10n/default/ru_RU: use/l10n/ru_RU
	@$(call set,GLOBAL_BOOT_LANG,ru_RU)
