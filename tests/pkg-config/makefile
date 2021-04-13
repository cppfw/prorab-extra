include prorab.mk

include $(d)../common.mk

define this_rules

.PHONY: test
test::
$(.RECIPEPREFIX)@$(this_running) $(this_test)
$(.RECIPEPREFIX)$(a)rm -rf $(d)tmp
$(.RECIPEPREFIX)+$(a)$(MAKE) -C $(d)pkg-config install DESTDIR=$(abspath $(d)tmp)
$(.RECIPEPREFIX)$(a)if [ ! -f $(d)tmp/usr/local/lib/pkgconfig/morda.pc ]; then $(this_err) "tmp/usr/local/lib/pkgconfig/morda.pc file not found"; fi
$(.RECIPEPREFIX)$(a)if [ ! -f $(d)tmp/usr/local/lib/pkgconfig/mordaaaaa.pc ]; then $(this_err) "tmp/usr/local/lib/pkgconfig/mordaaaaa.pc file not found"; fi
$(.RECIPEPREFIX)$(a)cmp $(d)tmp/usr/local/lib/pkgconfig/morda.pc $(d)samples/morda.pc || $(this_err) "morda.pc contents are not as expected";
$(.RECIPEPREFIX)$(a)cmp $(d)tmp/usr/local/lib/pkgconfig/mordaaaaa.pc $(d)samples/morda.pc || $(this_err) "mordaaaaa.pc contents are not as expected";
$(.RECIPEPREFIX)$(a)echo "test" | cat > $(d)tmp/usr/local/lib/pkgconfig/test.pc
$(.RECIPEPREFIX)+$(a)$(MAKE) -C $(d)/pkg-config uninstall DESTDIR=$(abspath $(d)tmp)
$(.RECIPEPREFIX)$(a)if [ -f $(d)tmp/usr/local/lib/pkgconfig/morda.pc ]; then $(this_err) "tmp/usr/local/lib/pkgconfig/morda.pc remained after uninstall"; fi
$(.RECIPEPREFIX)$(a)if [ -f $(d)tmp/usr/local/lib/pkgconfig/mordaaaaa.pc ]; then $(this_err) "tmp/usr/local/lib/pkgconfig/mordaaaaa.pc remained after uninstall"; fi
$(.RECIPEPREFIX)$(a)if [ ! -f $(d)tmp/usr/local/lib/pkgconfig/test.pc ]; then $(this_err) "tmp/usr/local/lib/pkgconfig/test.pc file not found"; fi
$(.RECIPEPREFIX)@$(this_pass)

clean::
$(.RECIPEPREFIX)$(a)rm -rf $(d)tmp

endef
$(eval $(this_rules))

