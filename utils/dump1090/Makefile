#
# Copyright (C) 2013-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dump1090
PKG_VERSION:=3.7.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/flightaware/dump1090
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_MIRROR_HASH:=d7ed250d624eae2eec6c0a2dd410986f42230bf929dab67893ea3bf1cab8a203

PKG_MAINTAINER:=Álvaro Fernández Rojas <noltari@gmail.com>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING LICENSE

PKG_BUILD_DEPENDS:=libusb
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/dump1090/Default
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Mode S decoder for the Realtek RTL2832U
  URL:=https://github.com/mutability/dump1090
endef

define Package/dump1090
  $(call Package/dump1090/Default)
  TITLE+= (dump1090)
  DEPENDS+=+librtlsdr +libncurses
endef

define Package/view1090
  $(call Package/dump1090/Default)
  TITLE+= (view1090)
  DEPENDS+=+libncurses
endef

define Package/dump1090/description
 Dump1090 is a Mode S decoder specifically designed for RTLSDR devices.
endef

define Package/view1090/description
 View1090 is a Mode S messages viewer for dump1090 devices.
endef

MAKE_FLAGS += \
	BLADERF=no \
	CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS)" \
	UNAME="Linux"

TARGET_CFLAGS += -ffunction-sections -fdata-sections -flto
TARGET_LDFLAGS += -Wl,--gc-sections,--as-needed

define Package/dump1090/install
	$(INSTALL_DIR) $(1)/opt/share/dump1090
	$(CP) $(PKG_BUILD_DIR)/public_html/* $(1)/opt/share/dump1090
	$(LN) /opt/var/run/dump1090 $(1)/opt/share/dump1090/data
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/dump1090 $(1)/opt/bin
endef

define Package/view1090/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/view1090 $(1)/opt/bin
endef

$(eval $(call BuildPackage,dump1090))
$(eval $(call BuildPackage,view1090))
