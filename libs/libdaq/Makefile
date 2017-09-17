#
# Copyright (C) 2012-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libdaq
PKG_VERSION:=2.0.4
PKG_RELEASE:=2

PKG_SOURCE_URL:=https://www.snort.org/downloads/snort/ \
	@SF/snort
PKG_SOURCE:=daq-$(PKG_VERSION).tar.gz
PKG_HASH:=a294aa3d01cd8902bf842d320e7f2c043af9ead95d0e7198c3b71a0dbc9d253c
PKG_BUILD_DIR:=$(BUILD_DIR)/daq-$(PKG_VERSION)

PKG_LICENSE:=GPL-2.0
PKG_MAINTAINER:=Luka Perkov <luka@openwrt.org>

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/libdaq
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=DAQ library
  URL:=$(PKG_SOURCE_URL)
  DEPENDS:=+libdnet +libpcap
endef

define Package/libdaq/description
 Data Acquisition library for packet I/O.
endef

CONFIGURE_ARGS+= \
	--disable-static \
	--disable-nfq-module \
	--with-dnet-includes="$(STAGING_DIR)/opt/include" \
	--with-dnet-libraries="$(STAGING_DIR)/opt/lib" \
	--with-libpcap-includes="$(STAGING_DIR)/opt/include" \
	--with-libpcap-libraries="$(STAGING_DIR)/opt/lib" \

define Build/Compile
	$(MAKE) $(MAKE_FLAGS) -C $(PKG_BUILD_DIR)
endef

define Build/Install
	$(MAKE) $(MAKE_FLAGS) -C $(PKG_BUILD_DIR) install DESTDIR=$(PKG_INSTALL_DIR)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(STAGING_DIR)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/*.h $(STAGING_DIR)/opt/include/
	$(INSTALL_DIR) $(STAGING_DIR)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/lib* $(STAGING_DIR)/opt/lib/
	$(INSTALL_DIR) $(STAGING_DIR)/opt/lib/daq
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/daq/* $(STAGING_DIR)/opt/lib/daq/
	$(INSTALL_DIR) $(STAGING_DIR)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/daq-modules-config $(STAGING_DIR)/opt/bin/
endef

define Package/libdaq/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.so* $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/daq
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/daq/*.so* $(1)/opt/lib/daq/
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/daq-modules-config $(1)/opt/bin/
endef

$(eval $(call BuildPackage,libdaq))
