include prorab.mk
include $(d)../../../../src/prorab-test.mk

this_name := dostuff

this_out_dir := out/rel

this_srcs := $(call prorab-src-dir, .)

this_cxxflags += -fPIC

this_ldlibs += -ldostuff
this_ldflags += -L $(d)../lib

$(eval $(prorab-build-app))

$(prorab_this_name): $(abspath $(d)../lib/libdostuff$(dot_so))

this_test_cmd := $(prorab_this_name)
this_test_deps := $(prorab_this_name)
this_test_ld_path := ../lib

$(eval $(prorab-test))

$(eval $(call prorab-include, ../lib/makefile))
