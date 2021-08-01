include prorab.mk

# include guard
ifneq ($(prorab_linux_included),true)
    prorab_linux_included := true

	ifeq ($(os),linux)
    	prorab_linux := $(shell lsb_release --id --short | tr '[:upper:]' '[:lower:]')
		prorab_linux_codename := $(shell lsb_release --codename --short)
	endif

endif # ~include guard
