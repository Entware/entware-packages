#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=bluez
PKG_VERSION:=5.50
PKG_RELEASE:=5

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@KERNEL/linux/bluetooth/
PKG_HASH:=5ffcaae18bbb6155f1591be8c24898dc12f062075a40b538b745bfd477481911

PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=
PKG_CPE_ID:=cpe:/a:bluez:bluez

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/bluez/Default
  TITLE:=Bluetooth
  URL:=http://www.bluez.org/
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
  DEPENDS:=+bluez-libs
endef

define Package/bluez-utils-extra
$(call Package/bluez/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE+= additional utilities
  DEPENDS:=+bluez-libs +libpthread +librt +glib2 +libncurses +libreadline $(INTL_DEPENDS) $(ICONV_DEPENDS) +dbus
endef

define Package/bluez-daemon
$(call Package/bluez/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE+= daemon
  DEPENDS:=+bluez-libs +bluez-utils +bluez-utils-extra +glib2 +libncurses +libreadline +dbus +libical $(INTL_DEPENDS) $(ICONV_DEPENDS)
endef

define Package/bluez-daemon/conffiles
/opt/etc/bluetooth/main.conf
/opt/etc/bluetooth/network.conf
/opt/etc/bluetooth/input.conf
/opt/etc/bluetooth/keys
/opt/etc/config/bluetooth
endef

TARGET_CFLAGS += -D_GNU_SOURCE -ffunction-sections -fdata-sections
TARGET_LDFLAGS += -Wl,--gc-sections

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

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/bluetooth $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libbluetooth.{a,so*} $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/bluez.pc $(1)/opt/lib/pkgconfig/
endef

define Package/bluez-libs/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libbluetooth.so.* $(1)/opt/lib/
endef

define Package/bluez-utils/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tools/bdaddr $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/bccmd $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/bluemoon $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/btattach $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/btmon $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/ciptool $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/hciattach $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/hciconfig $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/hcidump $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/hcitool $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/hex2hcd $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/l2ping $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/l2test $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/rctest $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/rfcomm $(1)/opt/bin/
endef

define Package/bluez-utils-extra/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tools/btmgmt $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/mpris-proxy $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/sdptool $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/attrib/gatttool $(1)/opt/bin/
endef

define Package/bluez-daemon/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/lib/bluetooth/bluetoothd $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/bluetoothctl $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/lib/bluetooth/obexd $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/etc/dbus-1/system.d/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/bluetooth.conf $(1)/opt/etc/dbus-1/system.d/bluetooth.conf
	$(INSTALL_DIR) $(1)/opt/etc/bluetooth
	$(INSTALL_DIR) $(1)/opt/etc/bluetooth/keys
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/main.conf $(1)/opt/etc/bluetooth/main.conf
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/profiles/network/network.conf $(1)/opt/etc/bluetooth/network.conf
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/profiles/input/input.conf $(1)/opt/etc/bluetooth/input.conf
endef

$(eval $(call BuildPackage,bluez-libs))
$(eval $(call BuildPackage,bluez-utils))
$(eval $(call BuildPackage,bluez-utils-extra))
$(eval $(call BuildPackage,bluez-daemon))
