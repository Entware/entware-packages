#
# Copyright (C) 2014-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=triggerhappy
PKG_VERSION:=0.3.4-151001
PKG_REV:=7e5abc69f215678e93a6b999524981c8b40bdcd9
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=git://github.com/wertarbyte/triggerhappy
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)

PKG_MAINTAINER:=Ted Hess <thess@kitschensync.net>
PKG_LICENSE:=GPL-3.0+
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/package.mk

define Package/triggerhappy
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=handle input events and run configured programs
  URL:=http://github.com/wertarbyte/triggerhappy
endef

define Package/triggerhappy/description
	triggerhappy - handle input events and run configured programs
endef

MAKE_FLAGS += \
	$(TARGET_CONFIGURE_OPTS) \
	$(1)

define Package/triggerhappy/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/etc/triggerhappy
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/thd $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/th-cmd $(1)/opt/sbin
	$(INSTALL_BIN) ./files/triggerhappy-example.conf $(1)/opt/etc/triggerhappy
endef

$(eval $(call BuildPackage,triggerhappy))
