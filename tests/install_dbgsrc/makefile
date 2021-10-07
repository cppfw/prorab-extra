include prorab.mk

include $(d)../common.mk

define this_rules

.PHONY: test
test::
$(.RECIPEPREFIX)@$(this_running) $(this_test)

$(.RECIPEPREFIX)$(a)rm -rf $(d)tmp

$(.RECIPEPREFIX)+$(a)$(MAKE) --directory $(d)prj
$(.RECIPEPREFIX)$(a)if [ -d $(d)tmp ]; then myci-error.sh "'tmp' directory unexpectedly present after simple make"; fi

$(.RECIPEPREFIX)+$(a)$(MAKE) --directory $(d)prj PREFIX=/usr DESTDIR=$(d)tmp install
$(.RECIPEPREFIX)$(a)if [ -d $(d)tmp ]; then myci-error.sh "'tmp' directory unexpectedly present after simple make install"; fi

$(.RECIPEPREFIX)+$(a)$(MAKE) --directory $(d)prj PREFIX=/usr DESTDIR=$(d)tmp install PRORAB_INSTALL_DBGSRC=false
$(.RECIPEPREFIX)$(a)if [ -d $(d)tmp ]; then myci-error.sh "'tmp' directory unexpectedly present after make install PRORAB_INSTALL_DBGSRC=false"; fi

$(.RECIPEPREFIX)+$(a)$(MAKE) --directory $(d)prj PREFIX=/usr DESTDIR=$(d)tmp install PRORAB_INSTALL_DBGSRC=true
$(.RECIPEPREFIX)$(a)if [ ! -d $(d)tmp ]; then myci-error.sh "'tmp' directory is not present after make install PRORAB_INSTALL_DBGSRC=true"; fi
$(.RECIPEPREFIX)$(a)if [ ! -f $(d)tmp/usr/src/libtest3/test/source.c ]; then myci-error.sh "'source.c' file is not present after make install PRORAB_INSTALL_DBGSRC=true"; fi
$(.RECIPEPREFIX)$(a)if [ ! -f $(d)tmp/usr/src/libtest3/test/source.h ]; then myci-error.sh "'source.c' file is not present after make install PRORAB_INSTALL_DBGSRC=true"; fi
$(.RECIPEPREFIX)$(a)if [ ! -f $(d)tmp/usr/src/libtest3/test/source.cpp ]; then myci-error.sh "'source.c' file is not present after make install PRORAB_INSTALL_DBGSRC=true"; fi
$(.RECIPEPREFIX)$(a)if [ ! -f $(d)tmp/usr/src/libtest3/test/source.hpp ]; then myci-error.sh "'source.c' file is not present after make install PRORAB_INSTALL_DBGSRC=true"; fi
$(.RECIPEPREFIX)$(a)if [ ! -f $(d)tmp/usr/src/libtest3/test/subdir/source.c ]; then myci-error.sh "'source.c' file is not present after make install PRORAB_INSTALL_DBGSRC=true"; fi
$(.RECIPEPREFIX)$(a)if [ ! -f $(d)tmp/usr/src/libtest3/test/subdir/source.h ]; then myci-error.sh "'source.c' file is not present after make install PRORAB_INSTALL_DBGSRC=true"; fi
$(.RECIPEPREFIX)$(a)if [ ! -f $(d)tmp/usr/src/libtest3/test/subdir/source.cpp ]; then myci-error.sh "'source.c' file is not present after make install PRORAB_INSTALL_DBGSRC=true"; fi
$(.RECIPEPREFIX)$(a)if [ ! -f $(d)tmp/usr/src/libtest3/test/subdir/source.hpp ]; then myci-error.sh "'source.c' file is not present after make install PRORAB_INSTALL_DBGSRC=true"; fi

clean::
$(.RECIPEPREFIX)$(a)rm -rf $(d)tmp

endef
$(eval $(this_rules))
