include prorab.mk

# include guard
ifneq ($(prorab_doxygen_included),true)
    prorab_doxygen_included := true

    .PHONY: doc

    # doxygen docs are only possible for libraries, so install path is lib*-doc
    define prorab-build-doxygen
        # need empty line here to avoid merging with adjacent macro instantiations

        all: doc

        doc:: $(prorab_this_dir)doxygen

        $(prorab_this_dir)doxygen.cfg: $(prorab_this_dir)doxygen.cfg.in $(prorab_this_dir)../debian/changelog
$(.RECIPEPREFIX)$(a)myci-apply-version.sh -v $$(shell myci-deb-version.sh $(prorab_this_dir)../debian/changelog) $$(firstword $$^)

        $(prorab_this_dir)doxygen: $(prorab_this_dir)doxygen.cfg
$(.RECIPEPREFIX)@echo "Building docs"
$(.RECIPEPREFIX)$(a)(cd $(prorab_this_dir); doxygen doxygen.cfg || true)

        clean::
$(.RECIPEPREFIX)$(a)rm -rf $(prorab_this_dir)doxygen
$(.RECIPEPREFIX)$(a)rm -rf $(prorab_this_dir)doxygen.cfg
$(.RECIPEPREFIX)$(a)rm -rf $(prorab_this_dir)doxygen_sqlite3.db

        install:: $(prorab_this_dir)doxygen
$(.RECIPEPREFIX)$(a)install -d $(DESTDIR)$(PREFIX)/share/doc/lib$(this_name)-doc
$(.RECIPEPREFIX)$(a)install -m 644 $(prorab_this_dir)doxygen/* $(DESTDIR)$(PREFIX)/share/doc/lib$(this_name)-doc || true #ignore error, not all systems have doxygen

        uninstall::
$(.RECIPEPREFIX)$(a)rm -rf $(DESTDIR)$(PREFIX)/share/doc/lib$(this_name)-doc

        # need empty line here to avoid merging with adjacent macro instantiations
    endef

endif
