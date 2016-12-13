#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# The original Makefile splits backends into many small packages.

include $(TOPDIR)/rules.mk

PKG_NAME:=sane-backends
PKG_VERSION:=1.0.25
PKG_RELEASE:=2
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://fossies.org/linux/misc \
    https://alioth.debian.org/frs/download.php/file/4146/
PKG_MD5SUM:=f9ed5405b3c12f07c6ca51ee60225fe7
PKG_MAINTAINER:=Luiz Angelo Daros de Luca <luizluca@gmail.com>
PKG_LICENSE:=GPL-2.0 GPL-2.0+
PKG_LICENSE_FILES:=COPYING LICENSE

PKG_FIXUP:=autoreconf
PKG_REMOVE_FILES:=aclocal.m4

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
  DEPENDS:=+libjpeg +libtiff +libusb-compat +cups +libv4l +libpng
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
endef

$(eval $(call BuildPackage,sane-backends))
$(eval $(call BuildPackage,sane-libs))
$(eval $(call BuildPackage,sane-frontends))
