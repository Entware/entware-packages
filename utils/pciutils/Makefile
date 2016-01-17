#
# Copyright (C) 2007-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pciutils
PKG_VERSION:=3.4.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@KERNEL/software/utils/pciutils
PKG_MD5SUM:=46674cdbf2f72e4cfef75fea1b1ec5c8
PKG_MAINTAINER:=Álvaro Fernández Rojas <noltari@gmail.com>

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING

PKG_USE_MIPS16:=0
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/pciutils
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Linux PCI Utilities
  URL:=http://mj.ucw.cz/pciutils.shtml
  DEPENDS:=+libkmod +zlib
endef

define Package/pciutils/description
 contains collection of programs for inspecting and manipulating configuration
 of PCI devices
endef

define Package/pciutils/postinst
#!/bin/sh
 cd /opt/share; /opt/sbin/update-pciids; rm pci.ids.gz.old
 exit 0
endef

MAKE_FLAGS += \
	CFLAGS="$(TARGET_CFLAGS) -I$(STAGING_DIR)/opt/include" \
	PREFIX="/opt" \
	HOST="$(GNU_TARGET_NAME)" \
	ZLIB="yes"

ifneq ($(CONFIG_USE_GLIBC),)
TARGET_LDFLAGS += -lresolv
endif

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_BUILD_DIR)/lib/libpci.a $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/include/pci
	$(CP) $(foreach i,pci.h config.h header.h types.h, \
		$(PKG_BUILD_DIR)/lib/$(i)) $(1)/opt/include/pci
endef

define Package/pciutils/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/{lspci,setpci,update-pciids} $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/share
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/share/pci.ids.gz $(1)/opt/share/
endef

$(eval $(call BuildPackage,pciutils))
