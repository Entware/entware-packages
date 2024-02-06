include $(TOPDIR)/rules.mk

PKG_NAME:=libyubikey
PKG_VERSION:=1.13
PKG_RELEASE:=2

PKG_SOURCE:=libyubikey-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://developers.yubico.com/yubico-c/Releases
PKG_HASH:=04edd0eb09cb665a05d808c58e1985f25bb7c5254d2849f36a0658ffc51c3401
PKG_MAINTAINER:=Stuart B. Wilkins <stuwilkins@mac.com>
PKG_LICENSE_FILES:=COPYING
PKG_LICENSE:=BSD-2-Clause

include $(INCLUDE_DIR)/package.mk

define Package/libyubikey
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=The Yubico yubikey c library
  URL:=https://developers.yubico.com/yubico-c/
endef

define Package/libyubikey/description
	The c library for the yubikey from Yubico
endef

define Build/InstallDev
	$(INSTALL_DIR) $(STAGING_DIR)/opt/include
	$(CP) $(PKG_BUILD_DIR)/yubikey.h $(STAGING_DIR)/opt/include
	$(INSTALL_DIR) $(STAGING_DIR)/opt/lib
	$(CP) $(PKG_BUILD_DIR)/.libs/libyubikey.so* $(STAGING_DIR)/opt/lib
endef

CONFIGURE_ARGS += \
	--enable-shared \
	--disable-static

define Package/libyubikey/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/.libs/modhex $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/.libs/ykgenerate $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/.libs/ykparse $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_BUILD_DIR)/.libs/libyubikey.so.* $(1)/opt/lib
endef

$(eval $(call BuildPackage,libyubikey))
