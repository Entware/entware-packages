#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=aiccu
PKG_VERSION:=20070115
PKG_RELEASE:=14

PKG_SOURCE:=$(PKG_NAME)_$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.sixxs.net/archive/sixxs/aiccu/unix
PKG_MD5SUM:=c9bcc83644ed788e22a7c3f3d4021350
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=doc/LICENSE

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/aiccu
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libpthread
  TITLE:=SixXS Automatic IPv6 Connectivity Client Utility
  URL:=http://www.sixxs.net/tools/aiccu/
  MAINTAINER:=Ondrej Caletka <ondrej@caletka.cz>
endef

define Build/Configure
	$(SED) "s,strip,/bin/true," $(PKG_BUILD_DIR)/unix-console/Makefile
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" OS_NAME="Linux" OS_VERSION="$(LINUX_VERSION)" \
		EXTRA_CFLAGS="$(TARGET_CFLAGS)" \
		EXTRA_LDFLAGS="$(TARGET_LDFLAGS) -pthread" \
		DEBUG=0
endef

define Package/aiccu/conffiles
/opt/etc/aiccu.conf
endef

define Package/aiccu/install
	$(INSTALL_DIR) $(1)/opt/sbin $(1)/opt/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/unix-console/$(PKG_NAME) $(1)/opt/sbin/
	$(INSTALL_BIN) ./files/S50aiccu $(1)/opt/etc/init.d/
	$(INSTALL_CONF) ./files/aiccu.conf $(1)/opt/etc/
endef

$(eval $(call BuildPackage,aiccu))
