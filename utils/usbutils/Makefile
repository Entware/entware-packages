#
# Copyright (C) 2007-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: ALTERNATIVES

include $(TOPDIR)/rules.mk

PKG_NAME:=usbutils
PKG_VERSION:=017
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@KERNEL/linux/utils/usb/usbutils
PKG_HASH:=a6a25ffdcf9103e38d7a44732aca17073f4e602b92e4ae55625231a82702e05b

PKG_MAINTAINER:=Felix Fietkau <nbd@nbd.name>
PKG_LICENSE:=GPL-2.0-only
PKG_LICENSE_FILES:=COPYING

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/usbutils
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+libusb-1.0 +libudev +librt +libpthread +usbids
  TITLE:=USB devices listing utilities
  URL:=http://www.linux-usb.org/
  ALTERNATIVES:=300:/opt/bin/lsusb:/opt/libexec/lsusb
endef

CONFIGURE_ARGS+= \
	--datadir=/opt/share/hwdata

define Package/usbutils/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/usbreset $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/libexec
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/lsusb $(1)/opt/libexec/
endef

$(eval $(call BuildPackage,usbutils))
