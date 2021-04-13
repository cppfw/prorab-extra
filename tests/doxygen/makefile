include prorab.mk

include $(d)../common.mk

define this_rules
.PHONY: test
test::
$(.RECIPEPREFIX)@$(this_running) $(this_test)
$(.RECIPEPREFIX)+$(a)$(MAKE) -C $(d)doc clean
$(.RECIPEPREFIX)+$(a)$(MAKE) -C $(d)doc
$(.RECIPEPREFIX)$(a)if [ ! -f $(d)doc/doxygen.cfg ]; then $(this_err) "doc/doxygen.cfg file not found"; fi
$(.RECIPEPREFIX)$(a)cmp $(d)doc/doxygen.cfg $(d)samples/doxygen.cfg || $(this_err) "doc/doxygen.cfg contents are not as expected";
$(.RECIPEPREFIX)+$(a)$(MAKE) -C $(d)doc clean
$(.RECIPEPREFIX)$(a)if [ -f $(d)doc/doxygen.cfg ]; then $(this_err) "doc/doxygen.cfg file remained after clean"; fi
$(.RECIPEPREFIX)$(a)if [ -d $(d)doc/doxygen ]; then $(this_err) "doc/doxygen directory remained after clean"; fi
$(.RECIPEPREFIX)+$(a)$(MAKE) -C $(d)doc install DESTDIR=$(abspath $(d)tmp)
$(.RECIPEPREFIX)$(a)if [ ! -d $(d)tmp/usr/local/share/doc/libtestdoc-doc ]; then $(this_err) "tmp/usr/local/share/doc/libtestdoc-doc directory not found"; fi
$(.RECIPEPREFIX)+$(a)$(MAKE) -C $(d)doc uninstall DESTDIR=$(abspath $(d)tmp)
$(.RECIPEPREFIX)$(a)if [ -d $(d)tmp/usr/local/share/doc/libtestdoc-doc ]; then $(this_err) "tmp/usr/local/share/doc/libtestdoc-doc directory remained after uninstall"; fi
$(.RECIPEPREFIX)@$(this_pass)
endef
$(eval $(this_rules))
