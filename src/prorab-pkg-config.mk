include prorab.mk

#once
ifneq ($(prorab_pkg_config_included),true)
    prorab_pkg_config_included := true


    define prorab-pkg-config
        #need empty line here to avoid merging with adjacent macro instantiations

        install:: $(shell ls $(d)*.pc.in)
		$(prorab_echo)myci-apply-version.sh -v `myci-deb-version.sh $(d)../debian/changelog` $(d)*.pc.in
		$(prorab_echo)install -d $(DESTDIR)$(PREFIX)/lib/pkgconfig
		$(prorab_echo)install -m 644 $(d)*.pc $(DESTDIR)$(PREFIX)/lib/pkgconfig

        uninstall::
		$(prorab_echo)for f in $(notdir $(patsubst %.in,%,$(shell ls $(d)*.pc.in))); do \
		    rm $(DESTDIR)$(PREFIX)/lib/pkgconfig/$$$$f; \
		done

        #need empty line here to avoid merging with adjacent macro instantiations
    endef

endif
