include prorab.mk

# include guard
ifneq ($(prorab_pkg_config_included),true)
    prorab_pkg_config_included := true

    define prorab-pkg-config

        $(if $(this_version),,$(error prorab-build-doxygen: this_version is not defined))

        # NOTE: prorab_private_out_dir is defined by prorab.mk

        install:: $(shell ls $(d)*.pc.in)
$(if $(prorab_private_out_dir),$(.RECIPEPREFIX)$(a)mkdir -p $(d)$(prorab_private_out_dir))
$(.RECIPEPREFIX)$(a)myci-apply-version.sh --version $(this_version) $(d)*.pc.in --out-dir $(d)$(prorab_private_out_dir)
$(.RECIPEPREFIX)$(a)install -d $(DESTDIR)$(PREFIX)/lib/pkgconfig
$(.RECIPEPREFIX)$(a)install -m 644 $(d)$(prorab_private_out_dir)*.pc $(DESTDIR)$(PREFIX)/lib/pkgconfig

        uninstall::
$(.RECIPEPREFIX)$(a)for f in $(notdir $(patsubst %.in,%,$(shell ls $(d)*.pc.in))); do rm $(DESTDIR)$(PREFIX)/lib/pkgconfig/$$$$f; done

    endef

endif
