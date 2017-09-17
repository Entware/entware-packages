#
# Copyright (C) 2017  Hauke Mehrtens <hauke@hauke-m.de>
# Copyright (C) 2016 - 2017  Stijn Tintel <stijn@linux-ipv6.be>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=openzwave
PKG_REV:=164
PKG_VERSION:=1.4.$(PKG_REV)
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://old.openzwave.com/downloads
PKG_HASH:=4ecf39787aaf278c203764069b581dbc26094ce57cafeab4a0c1f012d2c0ac69
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/openzwave/default
  URL:=http://openzwave.com
  MAINTAINER:=Stijn Tintel <stijn@linux-ipv6.be>
  DEPENDS:=+libpthread +libstdcpp
endef

define Package/openzwave/description
	Open-ZWave is a library that interfaces with selected Z-Wave PC controllers
endef

define Package/libopenzwave
$(call Package/openzwave/default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Open-ZWave Library
endef

define Package/openzwave
$(call Package/openzwave/default)
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Open-ZWave MinOZW test utility
  DEPENDS:=+libopenzwave +openzwave-config
endef

define Package/openzwave-config
$(call Package/openzwave/default)
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Open-ZWave Device Configs
endef

MAKE_FLAGS += \
	LD="$(TARGET_CROSS)g++" \
	LIBDIR="$(PKG_BUILD_DIR)" \
	PREFIX=$(CONFIGURE_PREFIX) \
	instlibdir=/opt/lib \
	pkgconfigdir=/opt/lib/pkgconfig \
	sysconfdir=/opt/etc/openzwave

define Build/Prepare
	$(call Build/Prepare/Default)
	rm $(PKG_BUILD_DIR)/cpp/src/platform/HidController.*
	sed -i -e '/hidapi/d;/HidController/d' $(PKG_BUILD_DIR)/distfiles.mk
endef

define Package/libopenzwave/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libopenzwave.so* $(1)/opt/lib/
endef

define Package/openzwave/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/MinOZW $(1)/opt/bin/
endef

define Package/openzwave-config/install
	$(INSTALL_DIR) $(1)/opt/etc/
	$(CP) $(PKG_INSTALL_DIR)/opt/etc/openzwave $(1)/opt/etc/
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/openzwave $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libopenzwave.* $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libopenzwave.pc $(1)/opt/lib/pkgconfig/
endef

$(eval $(call BuildPackage,libopenzwave))
$(eval $(call BuildPackage,openzwave))
$(eval $(call BuildPackage,openzwave-config))
