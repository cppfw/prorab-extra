include prorab.mk

# include guard
ifneq ($(prorab_clang_tidy_included),true)
    prorab_clang_tidy_included := true

define prorab-private-clang-tidy-single-source-file

    $(eval prorab_private_this_clang_tidy_flags := $(if $(this_clang_tidy_flags),$(this_clang_tidy_flags),--header-filter=.* --warnings-as-errors=*))
    $(eval prorab_private_this_clang_tidy_flags += $(if $(this_clang_tidy_checks),--checks="$(subst $(prorab_space),$(prorab_comma),$(this_clang_tidy_checks))",))

    .PHONY:
    clang-tidy__$1:
$(.RECIPEPREFIX)@echo "clang-tidy $1"
$(.RECIPEPREFIX)$(a)(cd $(d) && clang-tidy $1 $(prorab_private_this_clang_tidy_flags) -- $(this_cppflags) $(this_cxxflags))

endef

define prorab-clang-tidy

$(foreach f,$(this_srcs),$(eval $(call prorab-private-clang-tidy-single-source-file,$(f))))
test:: $(foreach f,$(this_srcs),clang-tidy__$(f))

endef

endif
