include prorab.mk

# include guard
ifneq ($(prorab_clang_format_included),true)
    prorab_clang_format_included := true

# macosx and msys2 at the moment doesn't provide clang-format version 15, so just
# don't perform clang-format cheks on macosx.
# TODO: remove the ifneq when macosx homebrew and msys2 adds a package for clang-format 15
ifneq ($(os),linux)
    prorab-clang-format :=
else

# clang-format 15 is only available for x86_64 so far.
# TODO: remove the ifneq when clang-format 15 is in Debian stable.
ifneq ($(shell arch),x86_64)
	prorab-clang-format :=
else

    define prorab-clang-format

        $(eval prorab_private_src_suffixes := $(if $(this_src_suffixes),$(this_src_suffixes),c h cpp hpp cxx hxx))
        $(eval prorab_private_src_dir := $(if $(this_src_dir),$(this_src_dir),.))

        $(eval prorab_private_format_find_patterns := -name *.$(firstword $(prorab_private_src_suffixes)) \
                $(foreach s,$(wordlist 2,$(words $(prorab_private_src_suffixes)),$(prorab_private_src_suffixes)),-or -name *.$(s)))
        $(eval prorab_private_format_srcs := $(shell cd $(d) && find $(prorab_private_src_dir) -type f $(prorab_private_format_find_patterns)))

        test::
$(.RECIPEPREFIX)@echo "check format"
$(.RECIPEPREFIX)$(a)(cd $(d) && clang-format --dry-run --Werror $(prorab_private_format_srcs))

        apply-format::
$(.RECIPEPREFIX)@echo "apply format"
$(.RECIPEPREFIX)$(a)(cd $(d) && clang-format -i --Werror $(prorab_private_format_srcs))

    endef

endif
endif

endif
