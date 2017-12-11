#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
#include $(INCLUDE_DIR)/uclibc++.mk

PKG_NAME:=smartmontools
PKG_VERSION:=6.6
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/smartmontools
PKG_HASH:=51f43d0fb064fccaf823bbe68cf0d317d0895ff895aa353b3339a3b316a53054
PKG_MAINTAINER:=Maxim Storchak <m.storchak@gmail.com>
PKG_LICENSE:=GPL-2.0+
PKG_LICENSE_FILES:=COPYING

PKG_FIXUP:=autoreconf

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/smartmontools/Default
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+libstdcpp
  TITLE:=S.M.A.R.T Monitoring
  URL:=http://smartmontools.sourceforge.net/
endef

define Package/smartmontools
  $(call Package/smartmontools/Default)
  TITLE+= Tool
endef

define Package/smartmontools/description
  smartmontools contains utility programs (smartctl) to
  control/monitor storage systems using the Self-Monitoring, Analysis
  and Reporting Technology System (S.M.A.R.T.) built into most modern
  ATA and SCSI disks. It is derived from smartsuite.
endef

define Package/smartd
  $(call Package/smartmontools/Default)
  TITLE+= Daemon
endef

define Package/smartd/description
  smartmontools contains utility programs (smartd) to
  control/monitor storage systems using the Self-Monitoring, Analysis
  and Reporting Technology System (S.M.A.R.T.) built into most modern
  ATA and SCSI disks. It is derived from smartsuite.
endef

# uses GNU configure

CONFIGURE_VARS += \
	CXXFLAGS="$$$$CXXFLAGS -fno-builtin -fno-rtti" \
	CPPFLAGS="$$$$CPPFLAGS" \
	LDFLAGS="$$$$LDFLAGS" \
	LIBS="-nodefaultlibs -lc -lm $(LIBGCC_S) -lc -lstdc++" \

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		BUILD_INFO='"(localbuild)"' \
		LD="$(TARGET_CXX)"
endef

define Package/smartmontools/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/smartctl $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/update-smart-drivedb $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/share/smartmontools
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/share/smartmontools/drivedb.h $(1)/opt/share/smartmontools/
endef

define Package/smartd/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/smartd $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/smartd.conf $(1)/opt/etc/
	$(INSTALL_BIN) ./files/S20smartmontools $(1)/opt/etc/init.d
endef

define Package/smartd/conffiles
/opt/etc/smartd.conf
endef

$(eval $(call BuildPackage,smartmontools))
$(eval $(call BuildPackage,smartd))
