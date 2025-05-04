include prorab.mk

# include guard
ifneq ($(prorab_doxygen_included),true)
    prorab_doxygen_included := true

    .PHONY: doc

    # doxygen docs are only possible for libraries, so install path is lib*-doc
    define prorab-build-doxygen

        $(if $(this_name),,$(error prorab-build-doxygen: this_name is not defined))

        $(eval prorab_private_version := $(if $(this_version),$(this_version),$$(shell myci-deb-version.sh $(d)../debian/changelog)))

        $(if $(prorab_private_version),,$(error prorab-build-doxygen: this_version is not defined))

        all: doc

        # NOTE: prorab_private_out_dir is defined by prorab.mk

        doc:: $(d)$(prorab_private_out_dir)doxygen.cfg

        $(d)$(prorab_private_out_dir)doxygen.cfg: $(d)doxygen.cfg.in
$(if $(prorab_private_out_dir),$(.RECIPEPREFIX)$(a)mkdir -p $(d)$(prorab_private_out_dir))
$(.RECIPEPREFIX)$(a)myci-apply-version.sh --version $(prorab_private_version) $$(firstword $$^) --out-dir $(d)$(prorab_private_out_dir)

        $(d)$(prorab_private_out_dir)doxygen: $(d)$(prorab_private_out_dir)doxygen.cfg
$(.RECIPEPREFIX)@echo "build docs"
$(.RECIPEPREFIX)$(a)(cd $(d)$(prorab_private_out_dir); doxygen doxygen.cfg || true) # ignore error, not all systems have doxygen

        clean::
$(.RECIPEPREFIX)$(a)rm -rf $(d)$(prorab_private_out_dir)doxygen
$(.RECIPEPREFIX)$(a)rm -rf $(d)$(prorab_private_out_dir)doxygen.cfg
$(.RECIPEPREFIX)$(a)rm -rf $(d)$(prorab_private_out_dir)doxygen_sqlite3.db

        install:: $(d)$(prorab_private_out_dir)doxygen
$(.RECIPEPREFIX)$(a)install -d $(DESTDIR)$(PREFIX)/share/doc/lib$(this_name)-doc
$(.RECIPEPREFIX)$(a)install -m 644 $(d)$(prorab_private_out_dir)doxygen/* $(DESTDIR)$(PREFIX)/share/doc/lib$(this_name)-doc || true # ignore error, not all systems have doxygen

        uninstall::
$(.RECIPEPREFIX)$(a)rm -rf $(DESTDIR)$(PREFIX)/share/doc/lib$(this_name)-doc

    endef

endif
