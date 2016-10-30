#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=autossh
PKG_VERSION:=1.4e
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tgz
PKG_SOURCE_URL:=http://www.harding.motd.ca/autossh/
PKG_MD5SUM:=f86684b96e99d22b2e9d35dc63b0aa29
PKG_LICENSE:=0BSD

include $(INCLUDE_DIR)/package.mk

define Package/autossh
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Autossh client
  URL:=http://www.harding.motd.ca/autossh/
  MAINTAINER:=Christian Beier <cb@shoutrlabs.com>
  SUBMENU:=SSH
endef

define Build/Compile
	$(call Build/Compile/Default, -f Makefile \
		CFLAGS="$(TARGET_CFLAGS) -Wall -D\"SSH_PATH=\\\"\$$$$(SSH)\\\"\" -D\"VER=\\\"\$$$$(VER)\\\"\"" \
		LIBS=" -lnsl $(TARGET_LDFLAGS)" \
		all \
	)
endef

define Package/autossh/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/autossh $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S41autossh $(1)/opt/etc/init.d/
endef

$(eval $(call BuildPackage,autossh))
