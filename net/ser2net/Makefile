#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ser2net
PKG_VERSION:=4.3.6
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/ser2net
PKG_HASH:=65515c7e9a5289167ae64c4032450904449a87ce20653241022af4f5db2e9510

PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Michael Heimpold <mhei@heimpold.de>

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

CONFIGURE_ARGS += \
	--with-pam=no \
	--with-pthreads \
	--with-sysfs-led-support

define Package/ser2net
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Serial to Network Proxy
  URL:=https://sourceforge.net/projects/ser2net/
  DEPENDS:=+libgensio +libyaml +libpthread
endef

define Package/ser2net/description
  This project provides a proxy that allows telnet/tcp connections to be made to
  serial ports on a machine.
endef

define Package/ser2net/conffiles
/opt/etc/ser2net/ser2net.yaml
/opt/etc/ser2net.conf
endef

define Package/ser2net/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/ser2net $(1)/opt/sbin/

	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_CONF) ./files/ser2net.conf $(1)/opt/etc/

	$(INSTALL_DIR) $(1)/opt/etc/ser2net
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/ser2net.yaml $(1)/opt/etc/ser2net

	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S50ser2net $(1)/opt/etc/init.d
endef

$(eval $(call BuildPackage,ser2net))
