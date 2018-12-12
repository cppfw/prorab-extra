include prorab.mk

include $(d)../common.mk

define this_rules
.PHONY: test
test::
	@$(this_running) $(this_test)
	$(prorab_echo)rm -rf $(d)tmp
	$(prorab_echo)+$(MAKE) -C $(d)/pkg-config install DESTDIR=$(abspath $(d)tmp)
	$(prorab_echo)if [ ! -f $(d)tmp/usr/local/lib/pkgconfig/morda.pc ]; then $(this_err) "tmp/usr/local/lib/pkgconfig/morda.pc file not found"; fi
	$(prorab_echo)if [ ! -f $(d)tmp/usr/local/lib/pkgconfig/mordaaaaa.pc ]; then $(this_err) "tmp/usr/local/lib/pkgconfig/mordaaaaa.pc file not found"; fi
	$(prorab_echo)cmp $(d)tmp/usr/local/lib/pkgconfig/morda.pc $(d)samples/morda.pc || $(this_err) "morda.pc contents are not as expected";
	$(prorab_echo)cmp $(d)tmp/usr/local/lib/pkgconfig/mordaaaaa.pc $(d)samples/morda.pc || $(this_err) "mordaaaaa.pc contents are not as expected";
	$(prorab_echo)echo "test" | cat > $(d)tmp/usr/local/lib/pkgconfig/test.pc
	$(prorab_echo)+$(MAKE) -C $(d)/pkg-config uninstall DESTDIR=$(abspath $(d)tmp)
	$(prorab_echo)if [ -f $(d)tmp/usr/local/lib/pkgconfig/morda.pc ]; then $(this_err) "tmp/usr/local/lib/pkgconfig/morda.pc remained after uninstall"; fi
	$(prorab_echo)if [ -f $(d)tmp/usr/local/lib/pkgconfig/mordaaaaa.pc ]; then $(this_err) "tmp/usr/local/lib/pkgconfig/mordaaaaa.pc remained after uninstall"; fi
	$(prorab_echo)if [ ! -f $(d)tmp/usr/local/lib/pkgconfig/test.pc ]; then $(this_err) "tmp/usr/local/lib/pkgconfig/test.pc file not found"; fi
	@$(this_pass)

clean::
	$(prorab_echo)rm -rf $(d)tmp
endef
$(eval $(this_rules))

