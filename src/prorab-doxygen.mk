include prorab.mk

# include guard
ifneq ($(prorab_doxygen_included),true)
    prorab_doxygen_included := true

    .PHONY: doc

    # doxygen docs are only possible for libraries, so install path is lib*-doc
    define prorab-build-doxygen
        # need empty line here to avoid merging with adjacent macro instantiations

        all: doc

        doc:: $(d)doxygen

        $(d)doxygen.cfg: $(d)doxygen.cfg.in $(d)../debian/changelog
$(.RECIPEPREFIX)$(a)myci-apply-version.sh -v $$(shell myci-deb-version.sh $(d)../debian/changelog) $$(firstword $$^)

        $(d)doxygen: $(d)doxygen.cfg
$(.RECIPEPREFIX)@echo "Building docs"
$(.RECIPEPREFIX)$(a)(cd $(d); doxygen doxygen.cfg || true)

        clean::
$(.RECIPEPREFIX)$(a)rm -rf $(d)doxygen
$(.RECIPEPREFIX)$(a)rm -rf $(d)doxygen.cfg
$(.RECIPEPREFIX)$(a)rm -rf $(d)doxygen_sqlite3.db

        install:: $(d)doxygen
$(.RECIPEPREFIX)$(a)install -d $(DESTDIR)$(PREFIX)/share/doc/lib$(this_name)-doc
$(.RECIPEPREFIX)$(a)install -m 644 $(d)doxygen/* $(DESTDIR)$(PREFIX)/share/doc/lib$(this_name)-doc || true #ignore error, not all systems have doxygen

        uninstall::
$(.RECIPEPREFIX)$(a)rm -rf $(DESTDIR)$(PREFIX)/share/doc/lib$(this_name)-doc

        # need empty line here to avoid merging with adjacent macro instantiations
    endef

endif
