#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=bluez
PKG_VERSION:=5.47
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@KERNEL/linux/bluetooth/
PKG_HASH:=cf75bf7cd5d564f21cc4a2bd01d5c39ce425397335fd47d9bbe43af0a58342c8

PKG_LICENSE:=GPL-2.0+
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Nicolas Thill <nico@openwrt.org>

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/bluez/Default
  TITLE:=Bluetooth
  URL:=http://www.bluez.org/
endef

define Package/bluez-examples
$(call Package/bluez/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE+= python example apps
  DEPENDS:=+python
endef

define Package/bluez-examples/description
  contains many examples apps for bluetooth, requiring python
endef

define Package/bluez-libs
$(call Package/bluez/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE+= library
  DEPENDS:=+libpthread
endef

define Package/bluez-utils
$(call Package/bluez/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE+= utilities
  DEPENDS:=+bluez-libs +libpthread +librt +glib2 +libncurses +libreadline $(INTL_DEPENDS) $(ICONV_DEPENDS)
endef

define Package/bluez-daemon
$(call Package/bluez/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE+= daemon
  DEPENDS:=+bluez-libs +bluez-utils +dbus +libical $(INTL_DEPENDS) $(ICONV_DEPENDS)
endef

define Package/bluez-daemon/conffiles
/opt/etc/bluetooth/main.conf
/opt/etc/bluetooth/network.conf
/opt/etc/bluetooth/input.conf
/opt/etc/bluetooth/audio.conf
/opt/etc/config/bluetooth
endef

CONFIGURE_ARGS += \
	--enable-static \
	--enable-shared \
	--enable-client \
	--enable-datafiles \
	--enable-experimental \
	--enable-library \
	--enable-monitor \
	--enable-obex \
	--enable-threads \
	--enable-tools \
	--disable-android \
	--disable-cups \
	--disable-manpages \
	--disable-sixaxis \
	--disable-systemd \
	--disable-test \
	--disable-udev \
	--enable-deprecated

TARGET_CPPFLAGS += \
	-D_GNU_SOURCE

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/bluetooth $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libbluetooth.{a,so*} $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/bluez.pc $(1)/opt/lib/pkgconfig/
endef

define Package/bluez-examples/install
	$(INSTALL_DIR) $(1)/opt/bin/bluez
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/test/* $(1)/opt/bin/bluez/
	$(SED) 's,/usr/bin/python,/opt/bin/python,g' $(1)/opt/bin/bluez/*
endef

define Package/bluez-libs/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libbluetooth.so.* $(1)/opt/lib/
endef

define Package/bluez-utils/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/bccmd $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/bluemoon $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/btmon $(1)/opt/bin/
	$(CP) $(PKG_BUILD_DIR)/tools/btmgmt $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ciptool $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/hciattach $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/hciconfig $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/hcidump $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/hcitool $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/hex2hcd $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/l2ping $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/l2test $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/rctest $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/rfcomm $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/sdptool $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/attrib/gatttool $(1)/opt/bin/
endef

define Package/bluez-daemon/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/bluetooth/bluetoothd $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/bluetoothctl $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/bluetooth/obexd $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/etc/config
	$(INSTALL_DATA) ./files/bluetooth.config $(1)/opt/etc/config/bluetooth
	$(INSTALL_DIR) $(1)/opt/etc/bluetooth
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/main.conf $(1)/opt/etc/bluetooth/main.conf
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/profiles/network/network.conf $(1)/opt/etc/bluetooth/network.conf
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/profiles/input/input.conf $(1)/opt/etc/bluetooth/input.conf
	$(INSTALL_DATA) ./files/audio.conf $(1)/opt/etc/bluetooth/audio.conf
endef

$(eval $(call BuildPackage,bluez-examples))
$(eval $(call BuildPackage,bluez-libs))
$(eval $(call BuildPackage,bluez-utils))
$(eval $(call BuildPackage,bluez-daemon))
