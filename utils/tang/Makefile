#
# Author: Tibor Dudlák
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: optional /opt/etc/services, shebangs at /opt/libexec/tangd-*

include $(TOPDIR)/rules.mk

PKG_NAME:=tang
PKG_VERSION:=10
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/latchset/$(PKG_NAME)/releases/download/v$(PKG_VERSION)/
PKG_HASH:=082f17e031708ab5e2f88c9b767d228bcf92a0d089fdb164d4ae93845cbd2a48

PKG_MAINTAINER:=Tibor Dudlák <tibor.dudlak@gmail.com>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=COPYING

PKG_INSTALL:=1
PKG_BUILD_DEPENDS:=meson/host

include $(INCLUDE_DIR)/package.mk
include ../../devel/meson/meson.mk

define Package/tang
  SECTION:=utils
  TITLE:=tang v$(PKG_VERSION) - daemon for binding data to the presence of a third party
  DEPENDS:=+libhttp-parser +xinetd +jose +bash
  URL:=https://github.com/latchset/tang
endef

define Package/tang/description
	Tang is a small daemon for binding data to the presence of a third party.
endef

define Package/tang/conffiles
/opt/etc/xinetd.d/tangdx
/opt/share/tang/db/
endef

define Package/tang/install
	$(INSTALL_DIR)	$(1)/opt/libexec
	$(INSTALL_DIR)	$(1)/opt/etc/xinetd.d/
	$(INSTALL_BIN)	$(PKG_INSTALL_DIR)/opt/libexec/tangd*	$(1)/opt/libexec/
	$(INSTALL_BIN)	./files/tangdw				$(1)/opt/libexec/
	$(CP)		./files/tangdx				$(1)/opt/etc/xinetd.d/
	$(SED) 's,^#!.*bash,#!/opt/bin/bash,' $(1)/opt/libexec/tangd-*
endef

define Package/tang/postinst
#!/bin/sh
	mkdir -p /opt/share/tang/db
	if [ -z "$(ls -A /opt/share/tang/db)" ]; then
		/opt/libexec/tangd-keygen /opt/share/tang/db/
	fi
endef

$(eval $(call BuildPackage,tang))
