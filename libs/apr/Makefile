#
# Copyright (C) 2007-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=apr
PKG_VERSION:=1.7.0
PKG_RELEASE:=4

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=@APACHE/apr/
PKG_HASH:=e2e148f0b2e99b8e5c6caa09f6d4fb4dd3e83f744aa72a952f94f5a14436f7ea

PKG_MAINTAINER:=Thomas Heil <heil@terminal-consulting.de>

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

PKG_CPE_ID:=cpe:/a:apache:apr

PKG_BUILD_PARALLEL:=1

PKG_FIXUP:=autoreconf

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libapr
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+libpthread +librt +libuuid
  TITLE:=Apache Portable Runtime Library
  URL:=https://apr.apache.org/
endef

TARGET_CFLAGS += $(FPIC) -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE

CONFIGURE_ARGS += \
	--with-devrandom=/dev/urandom \
	$(call autoconf_bool,CONFIG_IPV6,ipv6)

# XXX: ac_cv_sizeof_struct_iovec=1 is just to trick configure
# XXX: don't set apr_cv_use_lfs64=yes, see
#      https://www.openwall.com/lists/musl/2020/02/03/18
# XXX: the atomic builtins used require 8-byte intrinsics, which are available
#      on all 64-bit architectures and some arm as well as x86 32-bit platforms
CONFIGURE_VARS += \
	ap_cv_atomic_builtins=$(if $(CONFIG_ARCH_64BIT),yes,no) \
	ac_cv_file__dev_zero=yes \
	ac_cv_func_pthread_mutexattr_setpshared=yes \
	ac_cv_func_sem_open=yes \
	ac_cv_func_setpgrp_void=yes \
	ac_cv_mmap__dev_zero=yes \
	ac_cv_negative_eai=yes \
	ac_cv_o_nonblock_inherited=no \
	ac_cv_sizeof_struct_iovec=1 \
	ac_cv_struct_rlimit=yes \
	apr_cv_accept4=yes \
	apr_cv_dup3=yes \
	apr_cv_epoll=yes \
	apr_cv_epoll_create1=yes \
	apr_cv_gai_addrconfig=yes \
	apr_cv_mutex_recursive=yes \
	apr_cv_mutex_robust_shared=yes \
	apr_cv_process_shared_works=yes \
	apr_cv_pthreads_lib=-lpthread \
	apr_cv_sock_cloexec=yes \
	apr_cv_tcp_nodelay_with_cork=yes

ifeq ($(call qstrip,$(CONFIG_LIBC)),musl)
CONFIGURE_VARS += \
	ac_cv_strerror_r_rc_int=yes
endif

ifneq ($(CONFIG_ARCH_64BIT),y)
CONFIGURE_VARS += \
	ac_cv_sizeof_pid_t=4
endif

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/bin $(1)/opt/include/apr-1 \
		$(1)/opt/lib/pkgconfig $(1)/opt/share/build-1
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/apr-1-config \
						$(1)/opt/bin
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/include/apr-1/* \
					$(1)/opt/include/apr-1
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libapr-1.{a,so*} $(1)/opt/lib
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/apr-1.pc \
						$(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/share/build-1/* $(1)/opt/share/build-1
	$(SED) '/^prefix=\|^exec_prefix=/s|/opt|$(STAGING_DIR)/opt|' \
					$(1)/opt/bin/apr-1-config
	$(SED) '/^bindir=/s|/opt|$$$${prefix}|' $(1)/opt/bin/apr-1-config
	$(SED) '/^datadir=/s|/opt|$$$${prefix}|' $(1)/opt/bin/apr-1-config
	$(SED) '/^datarootdir=/s|/opt|$$$${prefix}|' $(1)/opt/bin/apr-1-config
	$(SED) 's,/opt/share/build-1,$(STAGING_DIR)/opt/share/build-1,g' \
				$(1)/opt/share/build-1/apr_rules.mk
	$(INSTALL_DIR) $(2)/bin
	$(LN) ../../opt/bin/apr-1-config $(2)/bin/apr-1-config
endef

define Package/libapr/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libapr-1.so.* $(1)/opt/lib
endef

$(eval $(call BuildPackage,libapr))
