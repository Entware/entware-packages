#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libpsl
PKG_VERSION:=0.21.5
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/rockdaboot/libpsl/releases/download/$(PKG_VERSION)
PKG_HASH:=1dcc9ceae8b128f3c0b3f654decd0e1e891afc6ff81098f227ef260449dae208

PKG_MAINTAINER:=W. Michael Petullo <mike@flyn.org>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk
include $(INCLUDE_DIR)/meson.mk

define Package/libpsl
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=C library to handle the Public Suffix List
  URL:=https://github.com/rockdaboot/libpsl
  DEPENDS:=+libidn2 +libunistring $(INTL_DEPENDS)
  ABI_VERSION:=5
endef

define Package/libpsl/description
  C library to handle the Public Suffix List
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include $(1)/opt/lib $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/include/libpsl.h $(1)/opt/include/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libpsl.so* $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libpsl.pc $(1)/opt/lib/pkgconfig/
endef

define Package/libpsl/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libpsl.so.* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,libpsl))
