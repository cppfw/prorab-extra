include prorab.mk

# include guard
ifneq ($(prorab_test_included),true)
    prorab_test_included := true

    prorab-private-lib-path-run = \
            $(if $(filter $(os),windows), \
                    cp $(d)$1/*.dll $(d)$(this_out_dir) && (cd $(d) && $2), \
                    $(if $(filter $(os),macosx), \
                            (export DYLD_LIBRARY_PATH=$1; cd $(d) && $2), \
                            $(if $(filter $(os),linux), \
                                    (export LD_LIBRARY_PATH=$1; cd $(d) && $2), \
                                    $(error "unknown OS") \
                                ) \
                        ) \
                )

    define prorab-test

    $(if $(this_test_cmd),,$(error prorab-test: this_test_cmd is not defined))
    $(if $(this_test_deps),,$(error prorab-test: this_test_deps is not defined, set to $$(prorab_space) if no dependencies needed))
    $(if $(this_test_ld_path),,$(error prorab-test: this_test_ld_path is not defined))

    test:: $(this_test_deps)
$(.RECIPEPREFIX)@myci-running-test.sh $(notdir $(abspath $(d)))
$(.RECIPEPREFIX)$(a)$(call prorab-private-lib-path-run,$(this_test_ld_path),$(this_test_cmd)) || myci-error.sh "test failed"
$(.RECIPEPREFIX)@myci-passed.sh

    endef

endif
