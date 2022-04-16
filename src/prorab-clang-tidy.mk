include prorab.mk

# include guard
ifneq ($(prorab_clang_tidy_included),true)
    prorab_clang_tidy_included := true

define prorab-private-clang-tidy-single-source-file

    .PHONY:
    clang-tidy__$1:
$(.RECIPEPREFIX)@echo "clang-tidy $1"
$(.RECIPEPREFIX)$(a)(cd $(d) && clang-tidy $1 -- $(this_cppflags) $(this_cxxflags))

endef

# macosx at the moment doesn't provide convenient way to install clang-tidy, so just
# don't perform clang-tidy cheks on macosx.
# TODO: remove the ifeq when macosx homebrew adds a formulae for clang-tidy
ifeq ($(os),macosx)
    prorab-clang-tidy :=
else
    define prorab-clang-tidy

        $(foreach f,$(this_srcs),$(eval $(call prorab-private-clang-tidy-single-source-file,$(f))))
        test:: $(foreach f,$(this_srcs),clang-tidy__$(f))

    endef
endif

endif
