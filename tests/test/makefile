include prorab.mk

include $(d)../common.mk

define this_rules

.PHONY: test
test::
$(.RECIPEPREFIX)@$(this_running) $(this_test)

# test prorab-test
$(.RECIPEPREFIX)+$(a)$(MAKE) -C $(d)prj clean
$(.RECIPEPREFIX)$(a)rm -f $(d)prj/app/out_file.txt
$(.RECIPEPREFIX)+$(a)$(MAKE) -C $(d)prj
$(.RECIPEPREFIX)$(a)if [ -f $(d)prj/app/out_file.txt ]; then $(this_err) "prj/app/out_file.txt file unexpectedly found"; fi
$(.RECIPEPREFIX)+$(a)$(MAKE) -C $(d)prj test
$(.RECIPEPREFIX)$(a)if [ ! -f $(d)prj/app/out_file.txt ]; then $(this_err) "prj/app/out_file.txt file not found"; fi
$(.RECIPEPREFIX)$(a)cmp $(d)prj/app/out_file.txt $(d)prj/app/out_file.txt.cmp; \
        if [ $$$$? -ne 0 ]; then myci-error.sh "out_file.txt did not match etalon sample"; exit 1; fi;

$(.RECIPEPREFIX)+$(a)$(MAKE) -C $(d) clean

# test prorab-run
$(.RECIPEPREFIX)$(a)if [ -f $(d)prj/app/out_file.txt ]; then $(this_err) "prj/app/out_file.txt file unexpectedly found"; fi
$(.RECIPEPREFIX)+$(a)$(MAKE) -C $(d)prj run_dostuff
$(.RECIPEPREFIX)$(a)cmp $(d)prj/app/out_file.txt $(d)prj/app/out_file.txt.cmp; \
        if [ $$$$? -ne 0 ]; then myci-error.sh "out_file.txt did not match etalon sample"; exit 1; fi;

$(.RECIPEPREFIX)+$(a)$(MAKE) -C $(d)prj clean

$(.RECIPEPREFIX)@$(this_pass)

clean::
$(.RECIPEPREFIX)+$(a)$(MAKE) -C $(d)prj clean
$(.RECIPEPREFIX)$(a)rm -f $(d)prj/app/out_file.txt

endef
$(eval $(this_rules))