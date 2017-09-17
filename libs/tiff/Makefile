#
# Copyright (C) 2006-2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=tiff
PKG_VERSION:=4.0.8
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://download.osgeo.org/libtiff
PKG_HASH:=59d7a5a8ccd92059913f246877db95a2918e6c04fb9d43fd74e5c3390dac2910

PKG_FIXUP:=autoreconf
PKG_REMOVE_FILES:=autogen.sh aclocal.m4

PKG_LICENSE:=BSD
PKG_LICENSE_FILES:=COPYRIGHT

PKG_INSTALL:=1

PKG_CONFIG_DEPENDS:=CONFIG_PACKAGE_libtiffxx

include $(INCLUDE_DIR)/uclibc++.mk
include $(INCLUDE_DIR)/package.mk

define Package/tiff/Default
  TITLE:=TIFF
  URL:=http://www.remotesensing.org/libtiff/
  MAINTAINER:=Jiri Slachta <jiri@slachta.eu>
endef

define Package/libtiff
$(call Package/tiff/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE+= library
  DEPENDS:=+zlib +libjpeg
endef

define Package/libtiffxx
$(call Package/tiff/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE+= library(c++ bindings)
  DEPENDS:=+libtiff $(CXX_DEPENDS)
endef

define Package/tiff-utils
$(call Package/tiff/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Image Manipulation
  TITLE+= utilities
  DEPENDS:=+libtiff
endef

TARGET_CFLAGS += $(FPIC)

define Build/Configure
	$(call Build/Configure/Default, \
		$(if $(CONFIG_PACKAGE_libtiffxx), \
			--enable-cxx, \
			--disable-cxx \
		) \
		--disable-lzma \
		--enable-ccitt \
		--enable-packbits \
		--enable-lzw \
		--enable-thunder \
		--enable-next \
		--enable-logluv \
		--enable-mdi \
		--enable-zlib \
		--enable-jpeg \
		--disable-old-jpeg \
		--disable-jbig \
		--without-x \
	)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/{lib,include}
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/lib* $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/include/* $(1)/opt/include/
endef

define Package/libtiff/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libtiff.so.* $(1)/opt/lib/
endef

define Package/libtiffxx/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libtiffxx.so.* $(1)/opt/lib/
endef

define Package/tiff-utils/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/bin/
endef

$(eval $(call BuildPackage,libtiff))
$(eval $(call BuildPackage,libtiffxx))
$(eval $(call BuildPackage,tiff-utils))
