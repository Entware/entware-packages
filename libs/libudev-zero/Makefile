# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: keep ver. 0.4.8; INPUT_PROP_MAX && INPUT_PROP_CNT since linux-2.6.38

include $(TOPDIR)/rules.mk

PKG_NAME:=libudev-zero
PKG_VERSION:=0.4.8
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/illiliti/libudev-zero/tar.gz/$(PKG_VERSION)?
PKG_HASH:=19e8af430997283a8a830797634757c299da13e9ca5a151bb919d45b46f5e95d

PKG_MAINTAINER:=Daniel Golle <daniel@makrotopia.org>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=COPYING

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libudev-zero
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Drop-in replacement for libudev
  URL:=https://github.com/illiliti/libudev-zero
  DEPENDS:=+libevdev
  PROVIDES:=libudev
  CONFLICTS:=libudev eudev udev
endef

MAKE_FLAGS += \
	PREFIX=/opt

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/libudev.h $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libudev.{a,so*} $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libudev.pc $(1)/opt/lib/pkgconfig/
endef

define Package/libudev-zero/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libudev.so* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,libudev-zero))
