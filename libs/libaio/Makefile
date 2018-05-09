#
# Copyright (C) 2007-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libaio
PKG_VERSION:=0.3.110
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)_$(PKG_VERSION).orig.tar.gz
PKG_SOURCE_URL:=http://ftp.debian.org/debian/pool/main/liba/libaio/
PKG_HASH:=e019028e631725729376250e32b473012f7cb68e1f7275bfc1bbcdd0f8745f7e
PKG_MAINTAINER:=Steven Barth <cyrus@openwrt.org>
PKG_LICENSE:=LGPL-2.1

PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/libaio
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Linux kernel AIO interface access library
  URL:=http://lse.sourceforge.net/io/aio.html
endef

define Build/Configure
endef

LIBAIO_CFLAGS:=-nostdlib -nostartfiles -I. $(TARGET_CFLAGS) $(TARGET_CPPFLAGS) $(FPIC)

TARGET_CFLAGS += $(FPIC)

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		$(TARGET_CONFIGURE_OPTS) \
		ARCH="$(ARCH)" \
		CC="$(TARGET_CROSS)gcc" \
		LD="$(TARGET_CROSS)ld" \
		CFLAGS="$(LIBAIO_CFLAGS)" \
		all
	$(MAKE) -C $(PKG_BUILD_DIR) \
		prefix="$(PKG_INSTALL_DIR)/opt" \
		install
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/libaio.h $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libaio.{a,so*} $(1)/opt/lib/
endef

define Package/libaio/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libaio.so.* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,libaio))
