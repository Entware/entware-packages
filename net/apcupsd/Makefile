#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=apcupsd
PKG_VERSION:=3.14.14
PKG_RELEASE:=2

PKG_MAINTAINER:=Othmar Truniger <github@truniger.ch>
PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/apcupsd
PKG_HASH:=db7748559b6b4c3784f9856561ef6ac6199ef7bd019b3edcd7e0a647bf8f9867

PKG_BUILD_DEPENDS:=libgd

include $(INCLUDE_DIR)/package.mk

define Package/apcupsd
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libpthread +libusb-compat
  TITLE:=UPS control software
  URL:=http://www.apcupsd.org/
endef

define Package/apcupsd-cgi
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libpthread +libgd
  TITLE:=UPS control software CGI module
  URL:=http://www.apcupsd.org/
endef

CONFIGURE_VARS += SHUTDOWN=/sbin/halt

define Build/Configure
	$(CP) $(SCRIPT_DIR)/config.* $(PKG_BUILD_DIR)/autoconf/
	$(call Build/Configure/Default, \
		--with-distname=unknown \
		--sysconfdir=/opt/etc/apcupsd \
		--with-cgi-bin=/opt/etc/apcupsd \
		--datarootdir=/opt/share \
		--enable-cgi \
		--enable-usb \
		--enable-modbus-usb \
		--without-x \
	)
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		LD="$(TARGET_CC)" \
		all install
endef

define Package/apcupsd/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/apcupsd $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/smtp $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/apctest $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/apcaccess $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/etc/apcupsd
	$(INSTALL_CONF) ./files/apcupsd.conf $(1)/opt/etc/apcupsd/
	$(INSTALL_CONF) ./files/apcupsd_mail.conf $(1)/opt/etc/apcupsd/
	$(INSTALL_BIN) ./files/changeme $(1)/opt/etc/apcupsd/
	$(INSTALL_BIN) ./files/commfailure $(1)/opt/etc/apcupsd/
	$(INSTALL_BIN) ./files/commok $(1)/opt/etc/apcupsd/
	$(INSTALL_BIN) ./files/offbattery $(1)/opt/etc/apcupsd/
	$(INSTALL_BIN) ./files/onbattery $(1)/opt/etc/apcupsd/
	$(INSTALL_BIN) ./files/apccontrol $(1)/opt/etc/apcupsd/
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN)	./files/S17apcupsd $(1)/opt/etc/init.d/
endef

define Package/apcupsd-cgi/install
	$(INSTALL_DIR) $(1)/opt/share/www/cgi-bin/apcupsd
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/etc/apcupsd/*.cgi $(1)/opt/share/www/cgi-bin/apcupsd
	$(INSTALL_DIR) $(1)/opt/etc/apcupsd
	$(INSTALL_CONF) ./files/apcupsd.css $(1)/opt/etc/apcupsd/
	$(INSTALL_CONF) ./files/hosts.conf $(1)/opt/etc/apcupsd/
	$(INSTALL_CONF) ./files/multimon.conf $(1)/opt/etc/apcupsd/
endef

define Package/apcupsd/conffiles
/opt/etc/apcupsd/apcupsd.conf
/opt/etc/apcupsd/apcupsd_mail.conf
/opt/etc/apcupsd/changeme
/opt/etc/apcupsd/commfailure
/opt/etc/apcupsd/commok
/opt/etc/apcupsd/offbattery
/opt/etc/apcupsd/onbattery
endef

define Package/apcupsd-cgi/conffiles
/opt/etc/apcupsd/apcupsd.css
/opt/etc/apcupsd/hosts.conf
/opt/etc/apcupsd/multimon.conf
endef

$(eval $(call BuildPackage,apcupsd))
$(eval $(call BuildPackage,apcupsd-cgi))
