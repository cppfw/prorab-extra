include prorab.mk

include $(d)../common.mk

define this_rules

.PHONY: test
test::
$(.RECIPEPREFIX)@$(this_running) $(this_test)

$(.RECIPEPREFIX)$(a)cp -r $(d)prj $(d)tmp
$(.RECIPEPREFIX)+$(a)if $(MAKE) --directory $(d)tmp test; then myci-error.sh "test unexpectedly succeeded"; fi
$(.RECIPEPREFIX)+$(a)$(MAKE) --directory $(d)tmp apply-license
# apply license second time
$(.RECIPEPREFIX)+$(a)$(MAKE) --directory $(d)tmp apply-license
$(.RECIPEPREFIX)+$(a)$(MAKE) --directory $(d)tmp test

clean::
$(.RECIPEPREFIX)$(a)rm --force --recursive $(d)tmp

endef
$(eval $(this_rules))