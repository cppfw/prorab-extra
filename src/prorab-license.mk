include prorab.mk

# include guard
ifneq ($(prorab_license_included),true)
    prorab_license_included := true

# TODO: deprecated target, remove
apply-license: license

define prorab-license

    $(if $(this_license_file),,$(error prorab-license: this_license_file is not defined))

    test::
$(.RECIPEPREFIX)$(a)echo "check license"
$(.RECIPEPREFIX)$(a)myci-license.sh --license $(d)$(this_license_file) --dir $(d)$(this_src_dir) --check

    license::
$(.RECIPEPREFIX)$(a)echo "apply license"
$(.RECIPEPREFIX)$(a)myci-license.sh --license $(d)$(this_license_file) --dir $(d)$(this_src_dir)

endef

# ~include guard
endif
