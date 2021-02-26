#
# Copyright (C) 2012-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libdaq
PKG_VERSION:=2.2.2
PKG_RELEASE:=3

PKG_SOURCE_URL:=https://www.snort.org/downloads/snortplus/
PKG_SOURCE:=daq-$(PKG_VERSION).tar.gz
PKG_HASH:=7cd818cabb1ad35360e83076e54775f07165ee71407dc672d147e27d3cd37f7b
PKG_BUILD_DIR:=$(BUILD_DIR)/daq-$(PKG_VERSION)

PKG_LICENSE:=GPL-2.0
PKG_MAINTAINER:=W. Michael Petullo <mike@flyn.org>

PKG_INSTALL:=1

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

define Build/InstallDev
	$(INSTALL_DIR) $(STAGING_DIR)/opt/include/daq2
	$(CP) $(PKG_INSTALL_DIR)/opt/include/*.h $(STAGING_DIR)/opt/include/daq2/
	$(INSTALL_DIR) $(STAGING_DIR)/opt/lib/daq2
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/lib* $(STAGING_DIR)/opt/lib/daq2/
	$(INSTALL_DIR) $(STAGING_DIR)/opt/lib/daq2/daq
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/daq/* $(STAGING_DIR)/opt/lib/daq2/daq/
	$(INSTALL_DIR) $(STAGING_DIR)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/daq-modules-config $(STAGING_DIR)/opt/bin/
	$(SED) 's,^\(prefix\|exec_prefix\)=.*,\1=$(STAGING_DIR)/opt,g' $(STAGING_DIR)/opt/bin/daq-modules-config
	$(INSTALL_DIR) $(2)/bin
	$(LN) ../../opt/bin/daq-modules-config $(2)/bin/daq-modules-config
endef

define Package/libdaq/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.so* $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/daq
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/daq/*.so* $(1)/opt/lib/daq/
endef

$(eval $(call BuildPackage,libdaq))
