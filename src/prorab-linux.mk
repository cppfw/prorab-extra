include prorab.mk

# include guard
ifneq ($(prorab_linux_included),true)
    prorab_linux_included := true

	ifeq ($(os),linux)
    	prorab_linux := $(shell (lsb_release --short --id 2>/dev/null || true) | tr '[:upper:]' '[:lower:]')
		prorab_linux_codename := $(shell lsb_release --codename --short 2>/dev/null || true)

		ifeq ($(prorab_linux),)
			prorab_linux := $(if $(shell pacman --version 2>/dev/null || true),"archlinux")
			prorab_linux_codename :=
		endif

		ifeq ($(prorab_linux),)
			prorab_linux_codename :=
		endif
	endif

endif # ~include guard
