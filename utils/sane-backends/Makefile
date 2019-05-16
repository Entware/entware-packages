#
# Copyright (C) 2006-2016 OpenWrt.org
# Copyright (C) 2017-2019 Luiz Angelo Daros de Luca <luizluca@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: all backends merged into sane-backends

include $(TOPDIR)/rules.mk

PKG_NAME:=sane-backends
PKG_VERSION:=1.0.27
PKG_RELEASE:=3
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://fossies.org/linux/misc \
    https://alioth.debian.org/frs/download.php/file/4146/
PKG_HASH:=293747bf37275c424ebb2c833f8588601a60b2f9653945d5a3194875355e36c9
PKG_MAINTAINER:=Luiz Angelo Daros de Luca <luizluca@gmail.com>
PKG_LICENSE:=GPL-2.0 GPL-2.0+
PKG_LICENSE_FILES:=COPYING LICENSE
PKG_CPE_ID:=cpe:/a:sane-backends_project:sane-backends

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/sane-backends/Default
  TITLE:=Scanner Access Now Easy
  URL:=http://www.sane-project.org/
endef

define Package/sane-backends/Default/description
 SANE (Scanner Access Now Easy) is a universal scanner interface.
endef

define Package/sane-backends
$(call Package/sane-backends/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+sane-libs
  TITLE+= (backends)
endef

define Package/sane-backends/description
$(call Package/sane-backends/Default/description)
This package contains the SANE daemon.
endef

define Package/sane-libs
  $(call Package/sane-backends/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+libjpeg +libtiff +libusb-1.0 +cups +libv4l +libpng
  TITLE+= (libraries)
endef

define Package/sane-libs/description
$(call Package/sane-backends/Default/description)
This package contains the SANE shared libraries.
endef

define Package/sane-frontends
  $(call Package/sane-backends/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+sane-backends
  TITLE+= (frontends)
endef

define Package/sane-frontends/description
$(call Package/sane-backends/Default/description)
This package contains the SANE frontends.
endef

TARGET_LDFLAGS += \
	-Wl,-rpath-link $(STAGING_DIR)/opt/lib \
	-Wl,-rpath-link $(PKG_BUILD_DIR)/backend/.libs

CONFIGURE_ARGS+= \
	--enable-shared \
	--enable-static \
	--disable-translations \
	--disable-latex \
	--without-gphoto2 \
	--disable-debug \
	--without-snmp

CONFIGURE_VARS+= \
    ac_cv_func_mmap_fixed_mapped="yes" \

define Build/Configure
	mkdir -p $(PKG_BUILD_DIR)/backend/.libs
	$(Build/Configure/Default)
endef

define Package/sane-backends/conffiles
/opt/etc/sane.d/saned.conf
endef

define Package/sane-backends/install
	$(INSTALL_DIR) $(1)/opt/etc/sane.d
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/sane.d/*.conf $(1)/opt/etc/sane.d
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/* $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S01sane-backends $(1)/opt/etc/init.d
endef

define Package/sane-libs/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libsane.so.* $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/lib/sane
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/sane/libsane-*.so.* $(1)/opt/lib/sane
endef

define Package/sane-frontends/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/bin
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/sane $(1)/opt/include
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libsane.{a,so*} $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_BUILD_DIR)/tools/sane-backends.pc $(1)/opt/lib/pkgconfig/
endef

$(eval $(call BuildPackage,sane-backends))
$(eval $(call BuildPackage,sane-libs))
$(eval $(call BuildPackage,sane-frontends))
