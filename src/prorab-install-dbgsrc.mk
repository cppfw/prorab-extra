include prorab.mk

# include guard
ifneq ($(prorab_install_dbgsrc_included),true)
    prorab_install_dbgsrc_included := true

define prorab-private-install-dbgsrc

    $(eval this_prorab_install_dbgsrc_private_install_dir := $(abspath $(DESTDIR)/$(PREFIX)/src/lib$(this_name)$(this_soname)))

    install::
$(.RECIPEPREFIX)$(a)mkdir -p $(this_prorab_install_dbgsrc_private_install_dir)
$(.RECIPEPREFIX)$(a)cp -r $(d)$(this_src_dir) $(this_prorab_install_dbgsrc_private_install_dir)
# $(.RECIPEPREFIX)$(a)chmod -R 644 $(this_prorab_install_dbgsrc_private_install_dir)

endef

define prorab-install-dbgsrc

    $(if $(this_name),,$(error prorab-install-dbgsrc: this_name is not defined))
    $(if $(this_soname),,$(error prorab-install-dbgsrc: this_soname is not defined))
    $(if $(this_src_dir),,$(error prorab-install-dbgsrc: this_src_dir is not defined))

    # install target for debug sources is only generated if PRORAB_INSTALL_DBGSRC is set to true
    $(if $(filter $(this_no_install),true),
        ,
        $(if $(filter true, $(PRORAB_INSTALL_DBGSRC)),$(prorab-private-install-dbgsrc))
    )

endef

# ~include guard
endif