#
# Copyright (C) 2007-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=apr
PKG_VERSION:=1.6.5
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=@APACHE/apr/
PKG_HASH:=a67ca9fcf9c4ff59bce7f428a323c8b5e18667fdea7b0ebad47d194371b0a105
PKG_MAINTAINER:=Thomas Heil <heil@terminal-consulting.de>
PKG_LICENSE:=Apache License

PKG_FIXUP:=autoreconf
PKG_REMOVE_FILES:=aclocal.m4 build/ltmain.sh

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libapr
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+libpthread +librt +libuuid
  TITLE:=Apache Portable Runtime Library
  URL:=https://apr.apache.org/
endef

TARGET_CFLAGS += $(FPIC)
TARGET_CPPFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE

CONFIGURE_ARGS += \
	--with-devrandom=/dev/urandom \
	--disable-dso \
	$(call autoconf_bool,CONFIG_IPV6,ipv6)

# XXX: ac_cv_sizeof_struct_iovec=1 is just to trick configure
CONFIGURE_VARS += \
	ac_cv_file__dev_zero=yes \
	ac_cv_func_setpgrp_void=yes \
	ac_cv_sizeof_struct_iovec=1 \
	ac_cv_struct_rlimit=yes \
	apr_cv_process_shared_works=no \
	apr_cv_mutex_robust_shared=no \
	apr_cv_tcp_nodelay_with_cork=yes \
	apr_cv_use_lfs64=yes \
	apr_cv_pthreads_lib="-lpthread" \
	apr_cv_mutex_recursive=yes \

ifneq ($(CONFIG_ARCH_64BIT),y)
CONFIGURE_VARS += \
	ac_cv_sizeof_pid_t=4 \

endif

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/bin $(1)/opt/include/apr-1 $(1)/opt/lib $(1)/opt/lib/pkgconfig $(1)/opt/share/build-1
	$(CP)   $(PKG_INSTALL_DIR)/opt/bin/apr-1-config \
		$(1)/opt/bin/
	$(CP)   $(PKG_INSTALL_DIR)/opt/include/apr-1/* \
		$(1)/opt/include/apr-1/
	$(CP)   $(PKG_INSTALL_DIR)/opt/lib/libapr-1.{la,a,so*} \
		$(1)/opt/lib/
	$(CP)   $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/apr-1.pc \
		$(1)/opt/lib/pkgconfig/
	$(CP)   $(PKG_INSTALL_DIR)/opt/share/build-1/* \
		$(1)/opt/share/build-1/
	$(SED) 's,^datadir=\"/opt/share\",datadir=\"$(STAGING_DIR)/opt/share\",g' $(1)/opt/bin/apr-1-config
	$(SED) 's,^installbuilddir=\"/opt/share/build-1\",installbuilddir=\"$(STAGING_DIR)/opt/share/build-1\",g' $(1)/opt/bin/apr-1-config
	$(SED) 's,^libdir=\"$$$${exec_prefix}/lib,libdir=\"$(STAGING_DIR)/opt/lib,g' $(1)/opt/bin/apr-1-config
	$(SED) 's,^includedir=\"$$$${prefix}/include/,includedir=\"$(STAGING_DIR)/opt/include/,g' $(1)/opt/bin/apr-1-config
	$(SED) 's,-L$$$$libdir,,g' $(1)/opt/bin/apr-1-config
	$(SED) 's,-R$$$$libdir,,g' $(1)/opt/bin/apr-1-config
	$(SED) 's,/opt/share/build-1,$(STAGING_DIR)/opt/share/build-1,g' $(1)/opt/share/build-1/apr_rules.mk
endef

define Package/libapr/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libapr-1.so.* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,libapr))
