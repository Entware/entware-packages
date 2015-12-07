#
# Copyright (C) 2010-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# This is the last version, working on kernel 2.6.22

include $(TOPDIR)/rules.mk

PKG_NAME:=usbip
PKG_VERSION:=0.1.7
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/usbip
PKG_MD5SUM:=d1094b6d4449787864f8be001639232c

PKG_BUILD_DEPENDS:=glib2 sysfsutils
PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/usbip/Common
  TITLE:=USB-over-IP
  URL:=http://usbip.sourceforge.net/
  MAINTAINER:=Nuno Goncalves <nunojpg@gmail.com>
endef

define Package/usbip/Default
$(call Package/usbip/Common)
  SECTION:=net
  CATEGORY:=Network
endef

define Package/usbip
$(call Package/usbip/Default)
  TITLE+= (common)
  DEPENDS+= +libsysfs +libwrap
endef

define Package/usbip-client
$(call Package/usbip/Default)
  TITLE+= (client)
  DEPENDS+= usbip +glib2
endef

define Package/usbip-server
$(call Package/usbip/Default)
  TITLE+= (server)
  DEPENDS+= usbip +glib2
endef

CONFIGURE_PATH:=./src
MAKE_PATH:=./src
LIBTOOL_PATHS:=./src

CFLAGS+="$(TARGET_CFLAGS) -I$(STAGING_DIR)/opt/include"

define Package/usbip/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/libusbip.so.* \
		$(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/share/usbip
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/share/usbip/usb.ids \
		$(1)/opt/share/usbip/
endef

define Package/usbip-client/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/bin/usbip \
		$(1)/opt/bin/
endef

define Package/usbip-server/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/bin/usbipd \
		$(1)/opt/bin/
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/bin/bind_driver \
		$(1)/opt/bin/usbip_bind_driver
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(CP) \
		./files/S74usbipd \
		$(1)/opt/etc/init.d
endef

$(eval $(call BuildPackage,usbip))
$(eval $(call BuildPackage,usbip-client))
$(eval $(call BuildPackage,usbip-server))
