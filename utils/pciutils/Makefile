#
# Copyright (C) 2007-2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pciutils
PKG_VERSION:=3.8.0
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@KERNEL/software/utils/pciutils
PKG_HASH:=91edbd0429a84705c9ad156d4ff38ccc724d41ea54c4c5b88e38e996f8a34f05

PKG_MAINTAINER:=Lucian Cristian <lucian.cristian@gmail.com>
PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/pciutils
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Linux PCI Utilities
  URL:=http://mj.ucw.cz/pciutils.shtml
  DEPENDS:=+libkmod +libpci +pciids
endef

define Package/pciutils/description
 contains collection of programs for inspecting and manipulating configuration
 of PCI devices
endef

define Package/libpci
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Linux PCI Libraries
  URL:=http://mj.ucw.cz/pciutils.shtml
endef

TARGET_CFLAGS += $(FPIC)

MAKE_FLAGS += \
	CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS)" \
	PREFIX="/opt" \
	HOST="Linux" \
	HWDB="no" \
	ZLIB="no" \
	SHARED="yes"

ifneq ($(CONFIG_USE_GLIBC),)
TARGET_LDFLAGS += -lresolv
endif

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libpci.so.3 \
		$(PKG_INSTALL_DIR)/opt/lib/libpci.so
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.so* $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_BUILD_DIR)/lib/libpci.pc $(1)/opt/lib/pkgconfig
	$(SED) 's,/opt/include,$$$${prefix}/include,g' $(1)/opt/lib/pkgconfig/libpci.pc
	$(SED) 's,/opt/lib,$$$${prefix}/lib,g' $(1)/opt/lib/pkgconfig/libpci.pc
	$(INSTALL_DIR) $(1)/opt/include/pci
	$(CP) $(foreach i,pci.h config.h header.h types.h, \
		$(PKG_BUILD_DIR)/lib/$(i)) $(1)/opt/include/pci
endef

define Package/pciutils/install
	$(INSTALL_DIR) $(1)/opt/sbin $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/lspci $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/setpci $(1)/opt/sbin/
endef

define Package/libpci/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.so* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,libpci))
$(eval $(call BuildPackage,pciutils))
