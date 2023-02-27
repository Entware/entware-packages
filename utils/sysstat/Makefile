#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: coreutils-date, findutils, xz deps, sysstat{,.ioconf} configs

include $(TOPDIR)/rules.mk

PKG_NAME:=sysstat
PKG_VERSION:=12.4.5
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=http://pagesperso-orange.fr/sebastien.godard/
PKG_HASH:=ef445acea301bbb996e410842f6290a8d049e884d4868cfef7e85dc04b7eee5b

PKG_MAINTAINER:=Marko Ratkaj <markoratkaj@gmail.com>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:sysstat_project:sysstat

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/sysstat
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Sysstat performance monitoring tools
  URL:=http://pagesperso-orange.fr/sebastien.godard/index.html
  DEPENDS:=+coreutils-date +findutils +xz $(INTL_DEPENDS)
  ALTERNATIVES:=300:/opt/bin/iostat:/opt/libexec/iostat-sysstat
endef

define Package/sysstat/description
 The sysstat utilities are a collection of performance monitoring tools for
 Linux. These include sar, sadf, mpstat, iostat, pidstat and sa tools.
endef

define Package/sysstat/conffiles
/opt/etc/sysstat/sysstat.ioconf
/opt/etc/sysstat/sysstat
endef

# XXX 
TARGET_CFLAGS += $(TARGET_LDFLAGS)
TARGET_LDFLAGS += $(if $(INTL_FULL),-lintl)

CONFIGURE_ARGS += \
	--disable-documentation \
	--disable-sensors \
	CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)"

CONFIGURE_VARS += \
	rcdir="/opt/etc" \
	sa_lib_dir="/opt/lib/sysstat" \
	sa_dir="/opt/var/log/sysstat" \
	conf_dir="/opt/etc/sysstat"

# XXX Entware specific: added iostat alternative to busybox iostat
define Package/sysstat/install
	$(INSTALL_DIR) $(1)/opt/lib/sysstat
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/lib/sysstat/{sadc,sa1,sa2} $(1)/opt/lib/sysstat/
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/{sar,sadf,mpstat,pidstat} $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/libexec
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/iostat $(1)/opt/libexec/iostat-sysstat
	$(INSTALL_DIR) $(1)/opt/etc/sysstat
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/sysstat/sysstat{,.ioconf} $(1)/opt/etc/sysstat/
	$(INSTALL_DIR) $(1)/opt/var/log/sysstat
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99sysstat $(1)/opt/etc/init.d/
endef

$(eval $(call BuildPackage,sysstat))
