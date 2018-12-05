#
# Copyright (C) 2006-2016 OpenWrt.org
# Copyright (C) 2017-2018 Luiz Angelo Daros de Luca <luizluca@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# To Do:
#  - dirs not removed when uninstalling! opkg bug?
#
# Entware - edited with-out-ext for host build. More host gems are needed for rake->mkvtoolnix build system

include $(TOPDIR)/rules.mk

PKG_NAME:=ruby
PKG_VERSION:=2.5.3
PKG_RELEASE:=1

# First two numbes
PKG_ABI_VERSION:=$(subst $(space),.,$(wordlist 1, 2, $(subst .,$(space),$(PKG_VERSION))))

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://cache.ruby-lang.org/pub/ruby/$(PKG_ABI_VERSION)/
PKG_HASH:=1cc9d0359a8ea35fc6111ec830d12e60168f3b9b305a3c2578357d360fcf306f
PKG_MAINTAINER:=Luiz Angelo Daros de Luca <luizluca@gmail.com>
PKG_LICENSE:=BSD-2-Clause
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:ruby-lang:ruby

PKG_BUILD_DEPENDS:=ruby/host
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

HOST_CONFIGURE_ARGS += \
	--disable-install-doc \
	--disable-install-rdoc \
	--disable-install-capi \
	--without-gmp \
	--with-out-ext=-test-/array/resize,-test-/bignum,-test-/bug-3571,-test-/bug-5832,-test-/bug_reporter,-test-/class,-test-/debug,-test-/dln/empty,-test-/exception,-test-/fatal,-test-/file,-test-/float,-test-/funcall,-test-/gvl/call_without_gvl,-test-/hash,-test-/integer,-test-/iseq_load,-test-/iter,-test-/load/dot.dot,-test-/marshal/compat,-test-/marshal/internal_ivar,-test-/marshal/usr,-test-/memory_status,-test-/method,-test-/notimplement,-test-/num2int,-test-/path_to_class,-test-/popen_deadlock,-test-/postponed_job,-test-/printf,-test-/proc,-test-/rational,-test-/recursion,-test-/st/foreach,-test-/st/numhash,-test-/st/update,-test-/string,-test-/struct,-test-/symbol,-test-/time,-test-/tracepoint,-test-/typeddata,-test-/vm,-test-/wait_for_single_fd,-test-/win32/console,-test-/win32/dln,-test-/win32/fd_setsize,bigdecimal,cgi/escape,continuation,coverage,dbm,etc,fcntl,fiber,fiddle,gdbm,io/console,io/nonblock,io/wait,mathn/complex,mathn/rational,nkf,objspace,openssl,racc/cparse,rbconfig/sizeof,readline,ripper,rubyvm,sdbm,socket,syslog,win32,win32ole,win32/resolv,zlib

# Does not compile with this. Workaround is --without-gmp
# https://bugs.ruby-lang.org/issues/11940
	#--with-static-linked-ext \

# even not used, host build with restricted exts results in gems not being
# compiled for target (probably some cross compiling problem like checking
# host for selecting target features)
#	--with-out-ext \
#	--with-ext=thread,stringio \

CONFIGURE_ARGS += \
	--enable-shared \
	--enable-static \
	--disable-rpath \
	$(call autoconf_bool,CONFIG_IPV6,ipv6) \
	--disable-install-doc \
	--disable-install-capi \
	--with-ruby-version=minor \
	--with-iconv-dir=$(ICONV_PREFIX) \
	--with-out-ext=win32,win32ole

ifndef CONFIG_RUBY_DIGEST_USE_OPENSSL
CONFIGURE_ARGS += \
	--with-bundled-sha1\
	--with-bundled-md5\
	--with-bundled-rmd160\
	--with-bundled-sha2 \

endif

TARGET_LDFLAGS += -L$(PKG_BUILD_DIR)

# Ruby uses DLDFLAGS and not LDFLAGS for libraries. LDFLAGS is only for execs.
# However, DLDFLAGS from configure is not passed to Makefile when target is linux.
# XLDFLAGS is used by both libraries and execs. This is somehow brute force but
# it will fix when some LD_FLAGS is needed for libraries. As side effect, it will
# duplicate ld args for binaries.
CONFIGURE_VARS += XLDFLAGS="$(TARGET_LDFLAGS)"

MAKE_FLAGS += \
	DESTDIR="$(PKG_INSTALL_DIR)" \
	SHELL="/bin/bash"

define Build/InstallDev
	( cd $(PKG_INSTALL_DIR); $(TAR) -cf - \
		. \
	) | ( cd $(1); $(TAR) -xf - )
endef

define Host/Install
	# When ruby version is updated, make install asks in some cases before replace
	# an existing different file. Remove them before install and avoid the interaction
	rm -f $(STAGING_DIR_HOSTPKG)/bin/rake
	$(call Host/Install/Default)
endef

define Package/ruby/Default
  SUBMENU:=Ruby
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Ruby scripting language
  URL:=http://www.ruby-lang.org/
endef

define Package/ruby/Default/description
 Ruby is the interpreted scripting language for quick and easy
 object-oriented programming.  It has many features to process text files
 and to do system management tasks (as in perl).  It is simple,
 straight-forward, and extensible.

endef

define Package/ruby
$(call Package/ruby/Default)
  TITLE+= (interpreter)
  DEPENDS:=+libruby
endef

define Package/ruby/description
$(call Package/ruby/Default/description)
endef

define RubyDependency
    $(eval \
        $(call Package/Default)
        $(call Package/ruby-$(1))
        FILTER_CONFIG:=$$(strip \
            $$(foreach config_dep, \
                $$(filter @%, \
                    $$(foreach v, \
                        $$(DEPENDS), \
                        $$(if $$(findstring :,$$v),,$$v) \
                    ) \
                ), \
                $$(subst @,,$$(config_dep)) \
            ) \
        )
        ifneq (,$$(FILTER_CONFIG))
           FILTER_CONFIG:=($$(subst $$(space),&&,$$(FILTER_CONFIG))):
        endif
    ) \
    +$(FILTER_CONFIG)ruby-$(1)
endef

define Package/ruby/config
    comment "Standard Library"
      depends on PACKAGE_ruby

    config PACKAGE_ruby-stdlib
      depends on PACKAGE_ruby
      default m if ALL
      prompt "Select Ruby Complete Standard Library (ruby-stdlib)"

endef

define Package/ruby/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/lib/ruby/$(PKG_ABI_VERSION)
	$(INSTALL_DIR) $(1)/opt/lib/ruby/vendor_ruby/$(PKG_ABI_VERSION)
	$(INSTALL_DIR) $(1)/opt/lib/ruby/site_ruby/$(PKG_ABI_VERSION)
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/ruby $(1)/opt/lib/ruby/ruby$(PKG_ABI_VERSION)-bin
	#$(INSTALL_BIN) ./files/ruby $(1)/opt/bin/ruby
	$(LN) /opt/lib/ruby/ruby$(PKG_ABI_VERSION)-bin $(1)/opt/bin/ruby
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/ruby/vendor_ruby/$(PKG_ABI_VERSION)/* $(1)/opt/lib/ruby/vendor_ruby/$(PKG_ABI_VERSION)/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/ruby/site_ruby/$(PKG_ABI_VERSION)/* $(1)/opt/lib/ruby/site_ruby/$(PKG_ABI_VERSION)/
	#$(SED) "s%@RUBY_LIBPATH@%/opt/lib/ruby/$(PKG_ABI_VERSION)%" $(1)/opt/bin/ruby
	#$(SED) "s%@RUBY_BINPATH@%/opt/lib/ruby/ruby$(PKG_ABI_VERSION)-bin%" $(1)/opt/bin/ruby
endef

define Package/libruby
$(call Package/ruby/Default)
  SUBMENU:=
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE+= (shared library)
  DEPENDS+= +libpthread +librt +libgmp
  ABI_VERSION:=$(PKG_ABI_VERSION)
endef
define Package/libruby/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libruby.so.* $(1)/opt/lib/
endef

RUBY_STDLIB :=
define Package/ruby-stdlib
$(call Package/ruby/Default)
  TITLE:=Ruby standard libraries (metadata for all stdlib subsets)
  DEPENDS:=ruby $(foreach subpackage,$(RUBY_STDLIB),$(strip $(call RubyDependency,$(subpackage))))
  HIDDEN:=1
endef

define Package/ruby-stdlib/description
 This metapackage currently install all ruby-* packages,
 providing a complete Ruby Standard Library.

endef

# nothing to do
define Package/ruby-stdlib/install
	/bin/true
endef

define Package/ruby-bigdecimal/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/bigdecimal.so
/opt/lib/ruby/$(PKG_ABI_VERSION)/bigdecimal/
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/bigdecimal-*.gemspec
endef

define Package/ruby-cgi/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/cgi
/opt/lib/ruby/$(PKG_ABI_VERSION)/cgi.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/cgi/escape.so
endef

define Package/ruby-cmath/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/cmath.rb
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/cmath-*.gemspec
endef

define Package/ruby-csv/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/csv.rb
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/csv-*.gemspec
endef

define Package/ruby-date/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/date.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/date_core.so
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/date-*.gemspec
endef

define Package/ruby-dbm/description
 The DBM class provides a wrapper to a Unix-style dbm or Database Manager library.
 This package provides dbm.so file.

endef
define Package/ruby-dbm/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/dbm.so
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/dbm-*.gemspec
endef

define Package/ruby-debuglib/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/profile.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/profiler.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/debug.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/tracer.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/benchmark.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/objspace.so
endef

define Package/ruby-did-you-mean/files
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/did_you_mean-*.gemspec
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/did_you_mean-*/
endef
define Package/ruby-did-you-mean/files-excluded
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/did_you_mean-*/benchmark
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/did_you_mean-*/doc
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/did_you_mean-*/evaluation
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/did_you_mean-*/test
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/did_you_mean-*/*.md
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/did_you_mean-*/*.txt
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/did_you_mean-*/.travis.yml
endef

define Package/ruby-digest/description
 Provides digest* files. Can be configured to use OpenSSL or
 bundled hash functions.

endef
define Package/ruby-digest/config

	config RUBY_DIGEST_USE_OPENSSL
		bool "Use OpenSSL functions for ruby digest hash functions"
        depends on PACKAGE_ruby-digest
		help
			Ruby can use OpenSSL hash functions or compile alternative implementations. Using
			OpenSSL saves about 30KBytes (less when compressed) but requires OpenSSL (that
			is way bigger than that). However, if OpenSSL is already needed by another usage,
			as ruby-openssl or any other non ruby package, it is better to mark this option.
		default n

endef
define Package/ruby-digest/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/digest
/opt/lib/ruby/$(PKG_ABI_VERSION)/digest.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/digest.so
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/digest/*
endef

define Package/ruby-drb/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/drb.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/drb
endef

define Package/ruby-enc/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/enc/encdb.so
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/enc/iso_8859_1.so
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/enc/utf_*.so
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/enc/euc_jp.so
endef

define Package/ruby-enc-extra/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/enc
endef
define Package/ruby-enc-extra/files-excluded
$(call Package/ruby-enc/files)
endef

define Package/ruby-erb/files
/opt/bin/erb
/opt/lib/ruby/$(PKG_ABI_VERSION)/erb.rb
endef

define Package/ruby-etc/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/etc.so
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/etc-*.gemspec
endef

define Package/ruby-fcntl/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/fcntl.so
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/fcntl-*.gemspec
endef

define Package/ruby-fiddle/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/fiddle.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/fiddle/
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/fiddle.so
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/fiddle-*.gemspec
endef

define Package/ruby-filelib/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/tmpdir.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/tempfile.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/pathname.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/pathname.so
/opt/lib/ruby/$(PKG_ABI_VERSION)/find.rb
endef

define Package/ruby-fileutils/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/fileutils.rb
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/fileutils-*.gemspec
endef

define Package/ruby-gdbm/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/gdbm.so
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/gdbm-*.gemspec
endef

define Package/ruby-gems/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/rubygems.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/rubygems
endef
define Package/ruby-gems/files-excluded
/opt/lib/ruby/$(PKG_ABI_VERSION)/rubygems/test_case.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/rubygems/package/tar_test_case.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/rubygems/installer_test_case.rb
endef
define Package/ruby-gems/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/gem $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default
	$(INSTALL_DIR) $(1)/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems
	$(INSTALL_DIR) $(1)/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/doc
	$(INSTALL_DIR) $(1)/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/cache
	$(INSTALL_DIR) $(1)/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/extensions
	$(INSTALL_DIR) $(1)/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/build_info
	$(call RubyBuildPackage/install,gems,$(1))
endef


define Package/ruby-io-console/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/io/console.so
/opt/lib/ruby/$(PKG_ABI_VERSION)/io/console/
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/io-console-*.gemspec
endef

define Package/ruby-ipaddr/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/ipaddr.rb
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/ipaddr-*.gemspec
endef

define Package/ruby-irb/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/irb
/opt/lib/ruby/$(PKG_ABI_VERSION)/irb.rb
endef
define Package/ruby-irb/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/irb $(1)/opt/bin/
	$(call RubyBuildPackage/install,irb,$(1))
endef

define Package/ruby-json/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/json.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/json
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/json
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/json-*.gemspec
endef
define Package/ruby-json/files-excluded
$(call Package/ruby-psych/files)
endef

define Package/ruby-logger/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/logger.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/syslog/logger.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/syslog.so
endef

define Package/ruby-math/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/prime.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/matrix.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/matrix
endef

define Package/ruby-minitest/files
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/minitest-*.gemspec
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/minitest-*
endef
define Package/ruby-minitest/files-excluded
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/minitest-*/test
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/minitest-*/*.rdoc
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/minitest-*/*.txt
endef

define Package/ruby-misc/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/English.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/abbrev.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/base64.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/delegate.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/e2mmap.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/expect.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/getoptlong.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/open3.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/ostruct.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/securerandom.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/set.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/shellwords.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/tsort.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/weakref.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/continuation.so
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/coverage.so
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/fiber.so
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/pty.so
endef

define Package/ruby-mkmf/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/mkmf.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/un.rb
endef

define Package/ruby-multithread/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/monitor.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/timeout.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/thwait.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/mutex_m.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/sync.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/io/wait.so
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/io/nonblock.so
endef

define Package/ruby-net/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/open-uri.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/net/*
endef

define Package/ruby-net-telnet/files
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/net-telnet-*.gemspec
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/net-telnet-*/
endef
define Package/ruby-net-telnet/files-excluded
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/net-telnet-*/*.md
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/net-telnet-*/*.txt
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/net-telnet-*/.travis.yml
endef

define Package/ruby-nkf/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/kconv.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/nkf.so
endef

define Package/ruby-openssl/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/openssl
/opt/lib/ruby/$(PKG_ABI_VERSION)/openssl.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/openssl.so
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/openssl-*.gemspec
endef

define Package/ruby-optparse/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/optparse.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/optionparser.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/optparse
endef

define Package/ruby-patterns/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/observer.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/singleton.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/forwardable.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/forwardable
endef

define Package/ruby-powerassert/files
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/power_assert-*.gemspec
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/power_assert-*
endef
define Package/ruby-powerassert/files-excluded
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/power_assert-*/*.rdoc
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/power_assert-*/.travis.yml
endef

define Package/ruby-prettyprint/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/pp.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/prettyprint.rb
endef

define Package/ruby-pstore/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/pstore.rb
endef

define Package/ruby-psych/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/psych
/opt/lib/ruby/$(PKG_ABI_VERSION)/psych.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/psych.so
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/psych-*.gemspec
endef

define Package/ruby-racc/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/racc
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/racc/*.so
endef

define Package/ruby-rake/files
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/rake-*.gemspec
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/rake-*/
endef
define Package/ruby-rake/files-excluded
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/rake-*/doc
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/rake-*/*.rdoc
endef
define Package/ruby-rake/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/rake $(1)/opt/bin/;
	$(call RubyBuildPackage/install,rake,$(1))
endef

define Package/ruby-rbconfig/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/rbconfig.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/rbconfig/*.so
endef

define Package/ruby-rdoc/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/rdoc.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/rdoc
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/rdoc-*
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/rdoc-*.gemspec
endef
define Package/ruby-rdoc/files-excluded
/opt/lib/ruby/$(PKG_ABI_VERSION)/rdoc/test_case.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/rdoc/markup/formatter_test_case.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/rdoc/markup/text_formatter_test_case.rb
endef
define Package/ruby-rdoc/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/rdoc $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/ri $(1)/opt/bin/
	$(call RubyBuildPackage/install,rdoc,$(1))
endef

define Package/ruby-readline/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/readline.so
endef

define Package/ruby-rexml/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/rexml
endef

define Package/ruby-rinda/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/rinda
endef

define Package/ruby-ripper/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/ripper.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/ripper
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/ripper.so
endef

define Package/ruby-rss/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/rss
/opt/lib/ruby/$(PKG_ABI_VERSION)/rss.rb
endef

define Package/ruby-scanf/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/scanf.rb
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/scanf-*.gemspec
endef

define Package/ruby-sdbm/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/sdbm.so
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/sdbm-*.gemspec
endef

define Package/ruby-shell/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/shell.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/shell
endef

define Package/ruby-socket/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/resolv-replace.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/resolv.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/socket.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/socket.so
endef

define Package/ruby-stringio/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/stringio.so
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/stringio-*.gemspec
endef

define Package/ruby-strscan/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/strscan.so
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/strscan-*.gemspec
endef

define Package/ruby-testunit/files
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/test-unit-*.gemspec
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/test-unit-*
endef
define Package/ruby-testunit/files-excluded
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/test-unit-*/doc
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/test-unit-*/test
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/test-unit-*/sample
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/test-unit-*/*.md
endef

define Package/ruby-time/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/time.rb
endef

define Package/ruby-unicodenormalize/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/unicode_normalize
endef

define Package/ruby-uri/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/uri.rb
/opt/lib/ruby/$(PKG_ABI_VERSION)/uri
endef

define Package/ruby-webrick/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/webrick
/opt/lib/ruby/$(PKG_ABI_VERSION)/webrick.rb
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/webrick-*.gemspec
endef

define Package/ruby-xmlrpc/files
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/xmlrpc-*
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/xmlrpc-*.gemspec
endef
define Package/ruby-xmlrpc/files-excluded
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/xmlrpc-*/*.md
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/xmlrpc-*/*.txt
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/gems/xmlrpc-*/.travis.yml
endef

define Package/ruby-yaml/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/yaml
/opt/lib/ruby/$(PKG_ABI_VERSION)/yaml.rb
endef

define Package/ruby-zlib/files
/opt/lib/ruby/$(PKG_ABI_VERSION)/*/zlib.so
/opt/lib/ruby/gems/$(PKG_ABI_VERSION)/specifications/default/zlib-*.gemspec
endef

RUBY_FILES = $(strip $(call Package/ruby-$(1)/files))
RUBY_FILES_EXCLUDED = $(strip $(call Package/ruby-$(1)/files-excluded))

# 1: short name
# 2: install dir
define RubyBuildPackage/install
	( \
	  cd $(PKG_INSTALL_DIR) && \
	  $(TAR) -cf - \
	    $(if $(RUBY_FILES_EXCLUDED),--exclude-from <(ls -1d $(patsubst /%,%,$(RUBY_FILES_EXCLUDED)))) \
	    --files-from <(ls -1d $(patsubst /%,%,$(RUBY_FILES))) \
	) | ( \
	  [ -n "$(2)" ] && cd $(2) && $(TAR) -xf - \
	)
endef

# 1: short name
# 2: description
# 3: dependencies on other packages
define RubyBuildPackage
  RUBY_STDLIB += $(1)

  # Package definition
  ifndef Package/ruby-$(1)
    define Package/ruby-$(1)
      $(call Package/ruby/Default)
      TITLE:=Ruby $(2)
      DEPENDS:=ruby $(3)
    endef
  endif

  ifndef Package/ruby-$(1)/description
    define Package/ruby-$(1)/description
      This package contains the ruby $(2).

    endef
  endif

  # Description
  ifndef Package/ruby-$(1)/install
    ifndef Package/ruby-$(1)/files
       $$(error It must exists either a Package/ruby-$(1)/install or Package/ruby-$(1)/files)
    endif

    define Package/ruby-$(1)/description +=

Provides:
$(patsubst /%,
 - /%,$(RUBY_FILES))

    endef

    ifneq ($(RUBY_FILES_EXCLUDED),)
      define Package/ruby-$(1)/description +=

Except:
$(patsubst /%,
 - /%,$(RUBY_FILES_EXCLUDED))

      endef
    endif

    Package/ruby-$(1)/install=$(call RubyBuildPackage/install,$(1),$$(1))
  endif

  $$(eval $$(call BuildPackage,ruby-$(1)))
endef

$(eval $(call BuildPackage,libruby))
$(eval $(call BuildPackage,ruby))
$(eval $(call RubyBuildPackage,bigdecimal,Arbitrary-precision decimal floating-point library,))
$(eval $(call RubyBuildPackage,cgi,CGI support toolkit,+ruby-filelib +ruby-pstore +ruby-stringio))
$(eval $(call RubyBuildPackage,cmath,Trigonometric and transcendental functions for complex numbers,))
$(eval $(call RubyBuildPackage,csv,CSV Reading and Writing,+ruby-date +ruby-enc +ruby-misc +ruby-patterns +ruby-stringio))
$(eval $(call RubyBuildPackage,date,Comparable module for handling dates,))
$(eval $(call RubyBuildPackage,dbm,Wrapper for the UNIX-style Database Manager Library,+libdb47))
$(eval $(call RubyBuildPackage,debuglib,debug library,+ruby-misc +ruby-prettyprint))
$(eval $(call RubyBuildPackage,did-you-mean,did you mean? experience,+ruby-misc))
$(eval $(call RubyBuildPackage,digest,Digest Library,+RUBY_DIGEST_USE_OPENSSL:libopenssl))
$(eval $(call RubyBuildPackage,drb,distributed object system,+ruby-filelib +ruby-ipaddr +ruby-patterns))
$(eval $(call RubyBuildPackage,enc,character re-coding library charset (small subset),))
$(eval $(call RubyBuildPackage,enc-extra,character re-coding library charset (extra subset),+ruby-enc))
$(eval $(call RubyBuildPackage,erb,(embedded interpreter),+ruby-cgi +ruby-strscan))
$(eval $(call RubyBuildPackage,etc,Access to information typically stored in UNIX /etc directory,))
$(eval $(call RubyBuildPackage,fcntl,Loads constants defined in the OS fcntl.h C header file,))
$(eval $(call RubyBuildPackage,fiddle,Libffi wrapper for Ruby,+libffi))
$(eval $(call RubyBuildPackage,filelib,file utils library,+ruby-fileutils +ruby-misc))
$(eval $(call RubyBuildPackage,fileutils,File utility methods for copying moving removing etc,+ruby-enc +ruby-etc))
$(eval $(call RubyBuildPackage,gdbm,Ruby extension for GNU dbm,+libgdbm))
$(eval $(call RubyBuildPackage,gems,gems packet management,+ruby-net +ruby-rdoc))
$(eval $(call RubyBuildPackage,io-console,Console interface,))
$(eval $(call RubyBuildPackage,ipaddr,Set of methods to manipulate an IP address,+ruby-socket))
$(eval $(call RubyBuildPackage,irb,(interactive shell),+ruby-debuglib +ruby-filelib))
$(eval $(call RubyBuildPackage,json,JSON Implementation for Ruby,+ruby-date +ruby-misc))
$(eval $(call RubyBuildPackage,logger,logger and syslog library,+ruby-multithread))
$(eval $(call RubyBuildPackage,math,math library,+ruby-patterns +ruby-misc))
$(eval $(call RubyBuildPackage,minitest,Gem minitest,+ruby-gems))
$(eval $(call RubyBuildPackage,misc,standard libraries subset (miscellaneous files),))
$(eval $(call RubyBuildPackage,mkmf,makefile library,+ruby-filelib +ruby-optparse +ruby-rbconfig))
$(eval $(call RubyBuildPackage,multithread,multithread library,+ruby-misc))
$(eval $(call RubyBuildPackage,net,Network Protocols Library,+ruby-time +ruby-digest +ruby-filelib +ruby-socket +ruby-stringio +ruby-strscan +ruby-uri))
$(eval $(call RubyBuildPackage,net-telnet,telnet client,+ruby-net))
$(eval $(call RubyBuildPackage,nkf,Network Kanji Filter,+ruby-enc))
$(eval $(call RubyBuildPackage,openssl,SSL TLS and general purpose cryptography,+ruby-enc +ruby-multithread +ruby-stringio +libopenssl))
$(eval $(call RubyBuildPackage,optparse,command-line option analysis,+ruby-misc +ruby-time))
$(eval $(call RubyBuildPackage,patterns,design patterns implementation,))
$(eval $(call RubyBuildPackage,powerassert,Gem power_assert,+ruby-prettyprint +ruby-ripper))
$(eval $(call RubyBuildPackage,prettyprint,PrettyPrint library,+ruby-etc))
$(eval $(call RubyBuildPackage,pstore,file based persistence,+ruby-digest +ruby-enc))
$(eval $(call RubyBuildPackage,psych,YAML parser and emitter,+ruby-bigdecimal +ruby-date +ruby-enc +ruby-stringio +ruby-strscan +libyaml))
$(eval $(call RubyBuildPackage,racc,LALR parser generator,))
$(eval $(call RubyBuildPackage,rake,Rake (make replacement),+ruby-fileutils +ruby-multithread +ruby-optparse +ruby-patterns +ruby-rbconfig))
$(eval $(call RubyBuildPackage,rbconfig,RbConfig,))
$(eval $(call RubyBuildPackage,rdoc,RDoc produces HTML and command-line documentation for Ruby projects,+ruby-debuglib +ruby-did-you-mean +ruby-erb +ruby-json +ruby-racc +ruby-rake +ruby-ripper +ruby-yaml +ruby-zlib))
$(eval $(call RubyBuildPackage,readline,support for readline,+libncurses +libreadline))
$(eval $(call RubyBuildPackage,rexml,XML toolkit,+ruby-enc +ruby-misc +ruby-patterns +ruby-stringio))
$(eval $(call RubyBuildPackage,rinda,Linda paradigm implementation,+ruby-drb))
$(eval $(call RubyBuildPackage,ripper,script parser,))
$(eval $(call RubyBuildPackage,rss,RSS toolkit,+ruby-net +ruby-nkf +ruby-rexml))
$(eval $(call RubyBuildPackage,scanf,Implementation of the C function scanf(3),))
$(eval $(call RubyBuildPackage,sdbm,simple file-based key-value dbm implementation,))
$(eval $(call RubyBuildPackage,shell,idiomatic Ruby interface,+ruby-patterns +ruby-multithread))
$(eval $(call RubyBuildPackage,socket,socket support,+ruby-multithread))
$(eval $(call RubyBuildPackage,stringio,Pseudo `IO` class from/to `String`,))
$(eval $(call RubyBuildPackage,strscan,Lexical scanning operations on a String,))
$(eval $(call RubyBuildPackage,testunit,Gem test-unit,+ruby-csv +ruby-erb +ruby-optparse +ruby-powerassert +ruby-rexml +ruby-yaml))
$(eval $(call RubyBuildPackage,time,Extends Time with additional methods for parsing and converting Times,+ruby-date))
$(eval $(call RubyBuildPackage,unicodenormalize,String additions for Unicode normalization,+ruby-enc +ruby-enc-extra))
$(eval $(call RubyBuildPackage,uri,library to handle URI,+ruby-enc))
$(eval $(call RubyBuildPackage,webrick,HTTP server toolkit,+ruby-erb +ruby-net +ruby-patterns +ruby-rbconfig))
$(eval $(call RubyBuildPackage,xmlrpc,XML-RPC toolkit,+ruby-rexml +ruby-webrick))
$(eval $(call RubyBuildPackage,yaml,YAML toolkit,+ruby-dbm +ruby-pstore +ruby-psych))
$(eval $(call RubyBuildPackage,zlib,compression/decompression library interface,+zlib))
$(eval $(call BuildPackage,ruby-stdlib))
$(eval $(call HostBuild))
