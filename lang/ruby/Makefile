#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# To Do:
#  - dirs not removed when uninstalling!
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ruby
PKG_VERSION:=2.3.3
PKG_RELEASE:=1

PKG_LIBVER:=2.3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://cache.ruby-lang.org/pub/ruby/$(PKG_LIBVER)/
PKG_MD5SUM:=882e6146ed26c6e78c02342835f5d46b86de95f0dc4e16543294bc656594cc5b
PKG_MAINTAINER:=Luiz Angelo Daros de Luca <luizluca@gmail.com>
PKG_LICENSE:=BSD-2-Clause
PKG_LICENSE_FILES:=COPYING

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
	--with-out-ext=tk,tk/tkutil,win32,win32ole,dbm,gdbm,readline \

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
	--with-out-ext=tk,tk/tkutil,win32,win32ole

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
# if will fix when some LD_FLAGS is needef for libraries. As side effect, it will
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
	rm -f $(HOST_BUILD_PREFIX)/bin/rake
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

define Build/Clean
	$(call Build/Clean/Default)
	rm -f $(STAGING_DIR)/pkginfo/ruby*
	rm -f $(STAGING_DIR)/pkginfo/libruby*
endef

define Package/ruby/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/lib/ruby/$(PKG_LIBVER)
	$(INSTALL_DIR) $(1)/opt/lib/ruby/vendor_ruby/$(PKG_LIBVER)
	$(INSTALL_DIR) $(1)/opt/lib/ruby/site_ruby/$(PKG_LIBVER)
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/ruby $(1)/opt/lib/ruby/ruby$(PKG_LIBVER)-bin
	$(LN) /opt/lib/ruby/ruby$(PKG_LIBVER)-bin $(1)/opt/bin/ruby
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/ruby/vendor_ruby/$(PKG_LIBVER)/* $(1)/opt/lib/ruby/vendor_ruby/$(PKG_LIBVER)/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/ruby/site_ruby/$(PKG_LIBVER)/* $(1)/opt/lib/ruby/site_ruby/$(PKG_LIBVER)/
endef

define Package/libruby
$(call Package/ruby/Default)
  SUBMENU:=
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE+= (shared library)
  DEPENDS+= +libpthread +librt +libgmp
  ABI_VERSION:=$(PKG_LIBVER)
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
/opt/lib/ruby/$(PKG_LIBVER)/*/bigdecimal.so
/opt/lib/ruby/$(PKG_LIBVER)/bigdecimal/
/opt/lib/ruby/gems/$(PKG_LIBVER)/specifications/default/bigdecimal-*.gemspec
endef

define Package/ruby-cgi/files
/opt/lib/ruby/$(PKG_LIBVER)/cgi
/opt/lib/ruby/$(PKG_LIBVER)/cgi.rb
/opt/lib/ruby/$(PKG_LIBVER)/*/cgi/escape.so
endef

define Package/ruby-csv/files
/opt/lib/ruby/$(PKG_LIBVER)/csv.rb
endef

define Package/ruby-datetime/files
/opt/lib/ruby/$(PKG_LIBVER)/time.rb
/opt/lib/ruby/$(PKG_LIBVER)/date.rb
/opt/lib/ruby/$(PKG_LIBVER)/*/date_core.so
endef

define Package/ruby-dbm/description
 The DBM class provides a wrapper to a Unix-style dbm or Database Manager library.
 This package provides dbm.so file.

endef
define Package/ruby-dbm/files
/opt/lib/ruby/$(PKG_LIBVER)/*/dbm.so
endef

define Package/ruby-debuglib/files
/opt/lib/ruby/$(PKG_LIBVER)/profile.rb
/opt/lib/ruby/$(PKG_LIBVER)/profiler.rb
/opt/lib/ruby/$(PKG_LIBVER)/debug.rb
/opt/lib/ruby/$(PKG_LIBVER)/tracer.rb
/opt/lib/ruby/$(PKG_LIBVER)/benchmark.rb
/opt/lib/ruby/$(PKG_LIBVER)/*/objspace.so
endef

define Package/ruby-did-you-mean/files
/opt/lib/ruby/gems/$(PKG_LIBVER)/specifications/did_you_mean-*.gemspec
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/did_you_mean-*/
endef
define Package/ruby-did-you-mean/files-excluded
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/did_you_mean-*/benchmark
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/did_you_mean-*/doc
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/did_you_mean-*/evaluation
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/did_you_mean-*/test
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/did_you_mean-*/*.md
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
/opt/lib/ruby/$(PKG_LIBVER)/digest
/opt/lib/ruby/$(PKG_LIBVER)/digest.rb
/opt/lib/ruby/$(PKG_LIBVER)/*/digest.so
/opt/lib/ruby/$(PKG_LIBVER)/*/digest/*
endef

define Package/ruby-drb/files
/opt/lib/ruby/$(PKG_LIBVER)/drb.rb
/opt/lib/ruby/$(PKG_LIBVER)/drb
endef

define Package/ruby-enc/files
/opt/lib/ruby/$(PKG_LIBVER)/*/enc/encdb.so
/opt/lib/ruby/$(PKG_LIBVER)/*/enc/iso_8859_1.so
/opt/lib/ruby/$(PKG_LIBVER)/*/enc/utf_*.so
/opt/lib/ruby/$(PKG_LIBVER)/*/enc/euc_jp.so
endef

define Package/ruby-enc-extra/files
/opt/lib/ruby/$(PKG_LIBVER)/*/enc
endef
define Package/ruby-enc-extra/files-excluded
$(call Package/ruby-enc/files)
endef

define Package/ruby-erb/files
/opt/bin/erb
/opt/lib/ruby/$(PKG_LIBVER)/erb.rb
endef

define Package/ruby-fiddle/files
/opt/lib/ruby/$(PKG_LIBVER)/fiddle.rb
/opt/lib/ruby/$(PKG_LIBVER)/fiddle/
/opt/lib/ruby/$(PKG_LIBVER)/*/fiddle.so
endef

define Package/ruby-filelib/files
/opt/lib/ruby/$(PKG_LIBVER)/tmpdir.rb
/opt/lib/ruby/$(PKG_LIBVER)/tempfile.rb
/opt/lib/ruby/$(PKG_LIBVER)/pathname.rb
/opt/lib/ruby/$(PKG_LIBVER)/*/pathname.so
/opt/lib/ruby/$(PKG_LIBVER)/find.rb
/opt/lib/ruby/$(PKG_LIBVER)/fileutils.rb
endef

define Package/ruby-gdbm/files
/opt/lib/ruby/$(PKG_LIBVER)/*/gdbm.so
endef

define Package/ruby-gems/files
/opt/lib/ruby/$(PKG_LIBVER)/ubygems.rb
/opt/lib/ruby/$(PKG_LIBVER)/rubygems.rb
/opt/lib/ruby/$(PKG_LIBVER)/rubygems
endef
define Package/ruby-gems/files-excluded
/opt/lib/ruby/$(PKG_LIBVER)/rubygems/test_case.rb
/opt/lib/ruby/$(PKG_LIBVER)/rubygems/package/tar_test_case.rb
/opt/lib/ruby/$(PKG_LIBVER)/rubygems/installer_test_case.rb
endef
define Package/ruby-gems/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/gem $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/lib/ruby/gems/$(PKG_LIBVER)/specifications/default
	$(INSTALL_DIR) $(1)/opt/lib/ruby/gems/$(PKG_LIBVER)/gems
	$(INSTALL_DIR) $(1)/opt/lib/ruby/gems/$(PKG_LIBVER)/doc
	$(INSTALL_DIR) $(1)/opt/lib/ruby/gems/$(PKG_LIBVER)/cache
	$(INSTALL_DIR) $(1)/opt/lib/ruby/gems/$(PKG_LIBVER)/extensions
	$(INSTALL_DIR) $(1)/opt/lib/ruby/gems/$(PKG_LIBVER)/build_info
	$(call RubyBuildPackage/install,gems,$(1))
endef

define Package/ruby-io-console/files
/opt/lib/ruby/$(PKG_LIBVER)/*/io/console.so
/opt/lib/ruby/$(PKG_LIBVER)/io/console/
/opt/lib/ruby/gems/$(PKG_LIBVER)/specifications/default/io-console-*.gemspec
endef

define Package/ruby-irb/files
/opt/lib/ruby/$(PKG_LIBVER)/irb
/opt/lib/ruby/$(PKG_LIBVER)/irb.rb
endef
define Package/ruby-irb/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/irb $(1)/opt/bin/
	$(call RubyBuildPackage/install,irb,$(1))
endef

define Package/ruby-json/files
/opt/lib/ruby/$(PKG_LIBVER)/json.rb
/opt/lib/ruby/$(PKG_LIBVER)/json
/opt/lib/ruby/$(PKG_LIBVER)/*/json
/opt/lib/ruby/gems/$(PKG_LIBVER)/specifications/default/json-*.gemspec
endef
define Package/ruby-json/files-excluded
$(call Package/ruby-psych/files)
endef

define Package/ruby-logger/files
/opt/lib/ruby/$(PKG_LIBVER)/logger.rb
/opt/lib/ruby/$(PKG_LIBVER)/syslog/logger.rb
/opt/lib/ruby/$(PKG_LIBVER)/*/syslog.so
endef

define Package/ruby-math/files
/opt/lib/ruby/$(PKG_LIBVER)/prime.rb
/opt/lib/ruby/$(PKG_LIBVER)/mathn.rb
/opt/lib/ruby/$(PKG_LIBVER)/cmath.rb
/opt/lib/ruby/$(PKG_LIBVER)/*/mathn
/opt/lib/ruby/$(PKG_LIBVER)/matrix.rb
/opt/lib/ruby/$(PKG_LIBVER)/matrix
endef

define Package/ruby-minitest/files
/opt/lib/ruby/gems/$(PKG_LIBVER)/specifications/minitest-*.gemspec
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/minitest-*
endef
define Package/ruby-minitest/files-excluded
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/minitest-*/test
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/minitest-*/*.rdoc
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/minitest-*/*.txt
endef

define Package/ruby-misc/files
/opt/lib/ruby/$(PKG_LIBVER)/English.rb
/opt/lib/ruby/$(PKG_LIBVER)/abbrev.rb
/opt/lib/ruby/$(PKG_LIBVER)/base64.rb
/opt/lib/ruby/$(PKG_LIBVER)/delegate.rb
/opt/lib/ruby/$(PKG_LIBVER)/e2mmap.rb
/opt/lib/ruby/$(PKG_LIBVER)/expect.rb
/opt/lib/ruby/$(PKG_LIBVER)/getoptlong.rb
/opt/lib/ruby/$(PKG_LIBVER)/open3.rb
/opt/lib/ruby/$(PKG_LIBVER)/ostruct.rb
/opt/lib/ruby/$(PKG_LIBVER)/scanf.rb
/opt/lib/ruby/$(PKG_LIBVER)/securerandom.rb
/opt/lib/ruby/$(PKG_LIBVER)/set.rb
/opt/lib/ruby/$(PKG_LIBVER)/shellwords.rb
/opt/lib/ruby/$(PKG_LIBVER)/tsort.rb
/opt/lib/ruby/$(PKG_LIBVER)/weakref.rb
/opt/lib/ruby/$(PKG_LIBVER)/*/continuation.so
/opt/lib/ruby/$(PKG_LIBVER)/*/coverage.so
/opt/lib/ruby/$(PKG_LIBVER)/*/etc.so
/opt/lib/ruby/$(PKG_LIBVER)/*/fcntl.so
/opt/lib/ruby/$(PKG_LIBVER)/*/fiber.so
/opt/lib/ruby/$(PKG_LIBVER)/*/pty.so
/opt/lib/ruby/$(PKG_LIBVER)/*/stringio.so
/opt/lib/ruby/$(PKG_LIBVER)/*/strscan.so
endef

define Package/ruby-mkmf/files
/opt/lib/ruby/$(PKG_LIBVER)/mkmf.rb
/opt/lib/ruby/$(PKG_LIBVER)/un.rb
endef

define Package/ruby-multithread/files
/opt/lib/ruby/$(PKG_LIBVER)/monitor.rb
/opt/lib/ruby/$(PKG_LIBVER)/timeout.rb
/opt/lib/ruby/$(PKG_LIBVER)/thwait.rb
/opt/lib/ruby/$(PKG_LIBVER)/mutex_m.rb
/opt/lib/ruby/$(PKG_LIBVER)/sync.rb
/opt/lib/ruby/$(PKG_LIBVER)/*/thread.so
/opt/lib/ruby/$(PKG_LIBVER)/*/io/wait.so
/opt/lib/ruby/$(PKG_LIBVER)/*/io/nonblock.so
endef

define Package/ruby-net/files
/opt/lib/ruby/$(PKG_LIBVER)/open-uri.rb
/opt/lib/ruby/$(PKG_LIBVER)/net/*
endef

define Package/ruby-net-telnet/files
/opt/lib/ruby/gems/$(PKG_LIBVER)/specifications/net-telnet-*.gemspec
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/net-telnet-*/
endef
define Package/ruby-net-telnet/files-excluded
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/net-telnet-*/*.md
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/net-telnet-*/*.txt
endef

define Package/ruby-nkf/files
/opt/lib/ruby/$(PKG_LIBVER)/kconv.rb
/opt/lib/ruby/$(PKG_LIBVER)/*/nkf.so
endef

define Package/ruby-openssl/files
/opt/lib/ruby/$(PKG_LIBVER)/openssl
/opt/lib/ruby/$(PKG_LIBVER)/openssl.rb
/opt/lib/ruby/$(PKG_LIBVER)/*/openssl.so
endef

define Package/ruby-optparse/files
/opt/lib/ruby/$(PKG_LIBVER)/optparse.rb
/opt/lib/ruby/$(PKG_LIBVER)/optionparser.rb
/opt/lib/ruby/$(PKG_LIBVER)/optparse
endef

define Package/ruby-patterns/files
/opt/lib/ruby/$(PKG_LIBVER)/observer.rb
/opt/lib/ruby/$(PKG_LIBVER)/singleton.rb
/opt/lib/ruby/$(PKG_LIBVER)/forwardable.rb
endef

define Package/ruby-powerassert/files
/opt/lib/ruby/gems/$(PKG_LIBVER)/specifications/power_assert-*.gemspec
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/power_assert-*
endef
define Package/ruby-powerassert/files-excluded
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/power_assert-*/test
endef

define Package/ruby-prettyprint/files
/opt/lib/ruby/$(PKG_LIBVER)/pp.rb
/opt/lib/ruby/$(PKG_LIBVER)/prettyprint.rb
endef

define Package/ruby-pstore/files
/opt/lib/ruby/$(PKG_LIBVER)/pstore.rb
endef

define Package/ruby-psych/files
/opt/lib/ruby/$(PKG_LIBVER)/psych
/opt/lib/ruby/$(PKG_LIBVER)/psych.rb
/opt/lib/ruby/$(PKG_LIBVER)/psych_jars.rb
/opt/lib/ruby/$(PKG_LIBVER)/*/psych.so
/opt/lib/ruby/gems/$(PKG_LIBVER)/specifications/default/psych-*.gemspec
endef

define Package/ruby-racc/files
/opt/lib/ruby/$(PKG_LIBVER)/racc
/opt/lib/ruby/$(PKG_LIBVER)/*/racc/*.so
endef

define Package/ruby-rake/files
/opt/lib/ruby/gems/$(PKG_LIBVER)/specifications/rake-*.gemspec
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/rake-*/
endef
define Package/ruby-rake/files-excluded
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/rake-*/doc
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/rake-*/test
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/rake-*/*.rdoc
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/rake-*/*.txt
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/rake-10.4.2/lib/rake/runtest.rb
endef
define Package/ruby-rake/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/rake $(1)/opt/bin/;
	$(call RubyBuildPackage/install,rake,$(1))
endef

define Package/ruby-rbconfig/files
/opt/lib/ruby/$(PKG_LIBVER)/*/rbconfig.rb
/opt/lib/ruby/$(PKG_LIBVER)/rbconfig/*
/opt/lib/ruby/$(PKG_LIBVER)/*/rbconfig/*.so
endef

define Package/ruby-rdoc/files
	/opt/lib/ruby/$(PKG_LIBVER)/rdoc.rb
	/opt/lib/ruby/$(PKG_LIBVER)/rdoc
	/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/rdoc-*
	/opt/lib/ruby/gems/$(PKG_LIBVER)/specifications/default/rdoc-*.gemspec
endef
define Package/ruby-rdoc/files-excluded
	/opt/lib/ruby/$(PKG_LIBVER)/rdoc/test_case.rb
	/opt/lib/ruby/$(PKG_LIBVER)/rdoc/markup/formatter_test_case.rb
	/opt/lib/ruby/$(PKG_LIBVER)/rdoc/markup/text_formatter_test_case.rb
endef
define Package/ruby-rdoc/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/rdoc $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/ri $(1)/opt/bin/
	$(call RubyBuildPackage/install,rdoc,$(1))
endef

define Package/ruby-readline/files
/opt/lib/ruby/$(PKG_LIBVER)/*/readline.so
endef

define Package/ruby-rexml/files
/opt/lib/ruby/$(PKG_LIBVER)/rexml
endef

define Package/ruby-rinda/files
/opt/lib/ruby/$(PKG_LIBVER)/rinda
endef

define Package/ruby-ripper/files
/opt/lib/ruby/$(PKG_LIBVER)/ripper.rb
/opt/lib/ruby/$(PKG_LIBVER)/ripper
/opt/lib/ruby/$(PKG_LIBVER)/*/ripper.so
endef

define Package/ruby-rss/files
/opt/lib/ruby/$(PKG_LIBVER)/rss
/opt/lib/ruby/$(PKG_LIBVER)/rss.rb
endef

define Package/ruby-sdbm/files
/opt/lib/ruby/$(PKG_LIBVER)/*/sdbm.so
endef

define Package/ruby-shell/files
/opt/lib/ruby/$(PKG_LIBVER)/shell.rb
/opt/lib/ruby/$(PKG_LIBVER)/shell
endef

define Package/ruby-socket/files
/opt/lib/ruby/$(PKG_LIBVER)/ipaddr.rb
/opt/lib/ruby/$(PKG_LIBVER)/resolv-replace.rb
/opt/lib/ruby/$(PKG_LIBVER)/resolv.rb
/opt/lib/ruby/$(PKG_LIBVER)/socket.rb
/opt/lib/ruby/$(PKG_LIBVER)/*/socket.so
endef

define Package/ruby-testunit/files
/opt/lib/ruby/gems/$(PKG_LIBVER)/specifications/test-unit-*.gemspec
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/test-unit-*
endef
define Package/ruby-testunit/files-excluded
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/test-unit-*/doc
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/test-unit-*/test
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/test-unit-*/sample
/opt/lib/ruby/gems/$(PKG_LIBVER)/gems/test-unit-*/*.md
endef

define Package/ruby-unicodenormalize/files
/opt/lib/ruby/$(PKG_LIBVER)/unicode_normalize.rb
/opt/lib/ruby/$(PKG_LIBVER)/unicode_normalize
endef

define Package/ruby-uri/files
/opt/lib/ruby/$(PKG_LIBVER)/uri.rb
/opt/lib/ruby/$(PKG_LIBVER)/uri
endef

define Package/ruby-webrick/files
/opt/lib/ruby/$(PKG_LIBVER)/webrick
/opt/lib/ruby/$(PKG_LIBVER)/webrick.rb
endef

define Package/ruby-xmlrpc/files
/opt/lib/ruby/$(PKG_LIBVER)/xmlrpc
/opt/lib/ruby/$(PKG_LIBVER)/xmlrpc.rb
endef

define Package/ruby-yaml/files
/opt/lib/ruby/$(PKG_LIBVER)/yaml
/opt/lib/ruby/$(PKG_LIBVER)/yaml.rb
endef

define Package/ruby-zlib/files
/opt/lib/ruby/$(PKG_LIBVER)/*/zlib.so
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

$(eval $(call BuildPackage,ruby))
$(eval $(call BuildPackage,libruby))
$(eval $(call RubyBuildPackage,bigdecimal,Arbitrary-precision decimal floating-point library,))
$(eval $(call RubyBuildPackage,cgi,CGI support toolkit,+ruby-filelib +ruby-pstore))
$(eval $(call RubyBuildPackage,csv,CSV library,+ruby-patterns +ruby-datetime +ruby-enc))
$(eval $(call RubyBuildPackage,datetime,date library))
$(eval $(call RubyBuildPackage,dbm,support for dbm,+libdb47))
$(eval $(call RubyBuildPackage,debuglib,debug library,+ruby-multithread +ruby-prettyprint))
$(eval $(call RubyBuildPackage,did-you-mean,did you mean? experience,+ruby-misc))
$(eval $(call RubyBuildPackage,digest,Digest Library,+RUBY_DIGEST_USE_OPENSSL:libopenssl))
$(eval $(call RubyBuildPackage,drb,distributed object system,+ruby-filelib +ruby-patterns +ruby-socket))
$(eval $(call RubyBuildPackage,enc,character re-coding library charset (small subset),))
$(eval $(call RubyBuildPackage,enc-extra,character re-coding library charset (extra subset),+ruby-enc))
$(eval $(call RubyBuildPackage,erb,(embedded interpreter),+ruby-cgi))
$(eval $(call RubyBuildPackage,fiddle,libffi wrapper,+libffi))
$(eval $(call RubyBuildPackage,filelib,file utils library,+ruby-enc +ruby-misc))
$(eval $(call RubyBuildPackage,gdbm,support for gdbm,+libgdbm))
$(eval $(call RubyBuildPackage,gems,gems packet management,+ruby-net +ruby-rdoc))
$(eval $(call RubyBuildPackage,io-console,Console interface,))
$(eval $(call RubyBuildPackage,irb,(interactive shell),+ruby-debuglib +ruby-filelib +ruby-math))
$(eval $(call RubyBuildPackage,json,support for JSON,+ruby-datetime +ruby-misc))
$(eval $(call RubyBuildPackage,logger,logger and syslog library,+ruby-multithread))
$(eval $(call RubyBuildPackage,math,math library,+ruby-patterns))
$(eval $(call RubyBuildPackage,minitest,Gem minitest,+ruby-gems))
$(eval $(call RubyBuildPackage,misc,standard libraries subset (miscellaneous files),))
$(eval $(call RubyBuildPackage,mkmf,makefile library,+ruby-filelib +ruby-optparse +ruby-rbconfig))
$(eval $(call RubyBuildPackage,multithread,multithread library,+ruby-misc))
$(eval $(call RubyBuildPackage,net,Network Protocols Library,+ruby-datetime +ruby-digest +ruby-filelib +ruby-uri))
$(eval $(call RubyBuildPackage,net-telnet,telnet client,+ruby-net))
$(eval $(call RubyBuildPackage,nkf,Network Kanji Filter,+ruby-enc))
$(eval $(call RubyBuildPackage,openssl,support for openssl,+ruby-enc +ruby-multithread +libopenssl))
$(eval $(call RubyBuildPackage,optparse,command-line option analysis,+ruby-misc))
$(eval $(call RubyBuildPackage,patterns,design patterns implementation,+ruby-multithread))
$(eval $(call RubyBuildPackage,powerassert,Gem power_assert,+ruby-ripper))
$(eval $(call RubyBuildPackage,prettyprint,PrettyPrint library,+ruby-misc))
$(eval $(call RubyBuildPackage,pstore,file based persistence,+ruby-digest +ruby-enc))
$(eval $(call RubyBuildPackage,psych,YAML parser and emitter,+ruby-bigdecimal +ruby-datetime +ruby-misc +ruby-enc +libyaml))
$(eval $(call RubyBuildPackage,racc,LALR parser generator,))
$(eval $(call RubyBuildPackage,rake,Rake (make replacement),+ruby-datetime +ruby-filelib +ruby-optparse +ruby-patterns +ruby-rbconfig))
$(eval $(call RubyBuildPackage,rbconfig,RbConfig,))
$(eval $(call RubyBuildPackage,rdoc,documentation generator,+ruby-erb +ruby-irb +ruby-json +ruby-racc +ruby-rake +ruby-yaml +ruby-zlib))
$(eval $(call RubyBuildPackage,readline,support for readline,+libncurses +libreadline))
$(eval $(call RubyBuildPackage,rexml,XML toolkit,+ruby-patterns +ruby-enc))
$(eval $(call RubyBuildPackage,rinda,Linda paradigm implementation,+ruby-drb))
$(eval $(call RubyBuildPackage,ripper,script parser,))
$(eval $(call RubyBuildPackage,rss,RSS toolkit,+ruby-net +ruby-nkf +ruby-rexml))
$(eval $(call RubyBuildPackage,sdbm,simple file-based key-value dbm implementation,))
$(eval $(call RubyBuildPackage,shell,idiomatic Ruby interface,+ruby-patterns))
$(eval $(call RubyBuildPackage,socket,socket support,+ruby-multithread))
$(eval $(call RubyBuildPackage,testunit,Gem test-unit,+ruby-csv +ruby-erb +ruby-optparse +ruby-powerassert +ruby-prettyprint +ruby-rexml +ruby-yaml))
$(eval $(call RubyBuildPackage,unicodenormalize,String additions for Unicode normalization,+ruby-enc +ruby-enc-extra))
$(eval $(call RubyBuildPackage,uri,library to handle URI,+ruby-socket +ruby-enc))
$(eval $(call RubyBuildPackage,webrick,Web server toolkit,+ruby-erb +ruby-net +ruby-patterns +ruby-rbconfig))
$(eval $(call RubyBuildPackage,xmlrpc,XML-RPC toolkit,+ruby-rexml +ruby-webrick))
$(eval $(call RubyBuildPackage,yaml,YAML toolkit,+ruby-dbm +ruby-pstore +ruby-psych))
$(eval $(call RubyBuildPackage,zlib,support for zlib,+zlib))
$(eval $(call BuildPackage,ruby-stdlib))
$(eval $(call HostBuild))
