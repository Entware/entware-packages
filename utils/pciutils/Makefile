#
# Copyright (C) 2007-2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pciutils
PKG_VERSION:=3.6.2
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@KERNEL/software/utils/pciutils
PKG_HASH:=db452ec986edefd88af0d222d22f6102f8030a8633fdfe846c3ae4bde9bb93f3

PKG_MAINTAINER:=Lucian Cristian <lucian.cristian@gmail.com>
PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING

PKG_USE_MIPS16:=0
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/pciutils
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Linux PCI Utilities
  URL:=http://mj.ucw.cz/pciutils.shtml
  DEPENDS:=+libkmod +libpci
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


PCI_IDS_VER:=0.324
PCI_IDS_FILE:=pci.ids.$(PCI_IDS_VER)
define Download/pci_ids
  FILE:=$(PCI_IDS_FILE)
  URL_FILE:=pci.ids
  URL:=@GITHUB/vcrhonek/hwdata/v$(PCI_IDS_VER)
  HASH:=6dba287b4aaafb9582d6139eda22ee6580651b8557828b9598d99078a5f4217e
endef
$(eval $(call Download,pci_ids))

define Build/Prepare
	$(call Build/Prepare/Default)
	$(RM) $(PKG_BUILD_DIR)/pci.ids
	$(CP) $(DL_DIR)/$(PCI_IDS_FILE) $(PKG_BUILD_DIR)/pci.ids
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
	$(INSTALL_DIR) $(1)/opt/include/pci
	$(CP) $(foreach i,pci.h config.h header.h types.h, \
		$(PKG_BUILD_DIR)/lib/$(i)) $(1)/opt/include/pci
endef

define Package/pciutils/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/{lspci,setpci,update-pciids} $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/share
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/share/pci.ids $(1)/opt/share/
endef

define Package/libpci/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/lib/*.so* $(1)/opt/lib/
endef

define Package/pciutils/postinst
#!/bin/sh
 cd /opt/share; /opt/sbin/update-pciids; rm pci.ids.gz.old
 exit 0
endef


$(eval $(call BuildPackage,libpci))
$(eval $(call BuildPackage,pciutils))
