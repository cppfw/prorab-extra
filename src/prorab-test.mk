include prorab.mk

# include guard
ifneq ($(prorab_test_included),true)
    prorab_test_included := true

    prorab-private-lib-path-run = \
            $(if $(filter $(os),windows), \
                    (cd $(d) && cp $(patsubst %,%/*.dll,$(strip $1)) $(this_out_dir) && $2), \
                    $(if $(filter $(os),macosx), \
                            (export DYLD_LIBRARY_PATH=$(subst $(prorab_space),:,$(strip $1)); cd $(d) && $2), \
                            $(if $(filter $(os),linux), \
                                    (export LD_LIBRARY_PATH=$(subst $(prorab_space),:,$(strip $1)); cd $(d) && $2), \
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

    # NOTE: the prorab-run uses same input variable names as prorab-test
    define prorab-run

    $(if $(this_run_name),,$(error prorab-run: this_run_name is not defined))
    $(if $(this_test_cmd),,$(error prorab-run: this_test_cmd is not defined))
    $(if $(this_test_deps),,$(error prorab-run: this_test_deps is not defined, set to $$(prorab_space) if no dependencies needed))
    $(if $(this_test_ld_path),,$(error prorab-run: this_test_ld_path is not defined))

    run_$(this_run_name): $(this_test_deps)
$(.RECIPEPREFIX)$(a)$(call prorab-private-lib-path-run,$(this_test_ld_path),$(this_test_cmd))

    endef

endif
