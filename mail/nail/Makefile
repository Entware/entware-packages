#
# Copyright (C) 2007-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=nail
PKG_VERSION:=12.5
PKG_RELEASE:=5
PKG_LICENSE:=BSD-2-Clause

PKG_SOURCE:=heirloom-mailx_$(PKG_VERSION).orig.tar.gz
PKG_SOURCE_URL:=http://ftp.de.debian.org/debian/pool/main/h/heirloom-mailx/
PKG_HASH:=015ba4209135867f37a0245d22235a392b8bbed956913286b887c2e2a9a421ad
PKG_BUILD_DIR:=$(BUILD_DIR)/heirloom-mailx-$(PKG_VERSION)

PKG_INSTALL:=0

include $(INCLUDE_DIR)/package.mk

define Package/nail
  SECTION:=mail
  CATEGORY:=Mail
  TITLE:=Heirloom mailx (nail)
  URL:=http://heirloom.sourceforge.net/mailx.html
  MAINTAINER:=Dmitry V. Zimin <pfzim@mail.ru>
  DEPENDS:=+libopenssl
endef

define Package/nail/description
  Heirloom mailx (formerly known as "nail") is intended provide
  the functionality of the POSIX mailx command with additional
  support for MIME messages, IMAP (including caching), POP3,
  SMTP, S/MIME, message threading/sorting, scoring, and filtering
endef

define Package/nail/conffiles
/opt/etc/nail.rc
endef

define Build/Install
	$(INSTALL_DIR) $(PKG_INSTALL_DIR)/opt/bin
	$(CP) $(PKG_BUILD_DIR)/mailx $(PKG_INSTALL_DIR)/opt/bin/
	$(INSTALL_DIR) $(PKG_INSTALL_DIR)/opt/etc
	$(CP) $(PKG_BUILD_DIR)/nail.rc $(PKG_INSTALL_DIR)/opt/etc/
endef

define Package/nail/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/etc/* $(1)/opt/etc/
endef

$(eval $(call BuildPackage,nail))

