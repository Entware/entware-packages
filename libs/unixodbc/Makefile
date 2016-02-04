#
# Copyright (C) 2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=unixodbc
PKG_VERSION:=2.3.4
PKG_RELEASE:=2

PKG_SOURCE_URL:=ftp://ftp.unixodbc.org/pub/unixODBC/
PKG_SOURCE:=unixODBC-$(PKG_VERSION).tar.gz
PKG_MD5SUM:=bd25d261ca1808c947cb687e2034be81
PKG_BUILD_DIR:=$(BUILD_DIR)/unixODBC-$(PKG_VERSION)
PKG_MAINTAINER:=Thomas Heil <heil@terminal-consulting.de>
PKG_LICENSE:=prog GPL libs LGPL

include $(INCLUDE_DIR)/package.mk
CONFIGURE_ARGS += \
	--disable-gui \
	--with-pic \
	--enable-drivers

define Package/unixodbc/Default
  SUBMENU:=database
  TITLE:=unixODBC
  URL:=http://www.unixodbc.org/
endef

define Package/unixodbc
  $(call Package/unixodbc/Default)
  TITLE+= (libraries)
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+libltdl +libpthread
endef

define Package/unixodbc/description
  unixODBC is an Open Source ODBC sub-system and an ODBC SDK for Linux,
  Mac OSX, and UNIX.
endef

define Package/unixodbc-tools
  $(call Package/unixodbc/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE+= Tools
  DEPENDS:=+unixodbc +libncurses +libreadline
endef

define Package/unixodbc-tools/description
  Command Line Tools to help install a driver and work with SQL.
endef

define Package/pgsqlodbc
  $(call Package/unixodbc/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Postgresql driver for ODBC
  DEPENDS:=+unixodbc +libpq
endef

define Package/pgsqlodbc/description
	Postgresql driver for ODBC.
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		$(MAKE_FLAGS) \
		ARCH="$(ARCH)" \
		CC="$(TARGET_CC)"
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		$(MAKE_FLAGS) \
		ARCH="$(ARCH)" \
		install -i
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/*.h $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/* $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/etc
	$(CP) $(PKG_INSTALL_DIR)/opt/etc/odbc* $(1)/opt/etc/
	$(INSTALL_DIR) $(1)/opt/etc/ODBCDataSources
	$(TARGET_CC) $(TARGET_CFLAGS) -E ./files/unixodbc_conf.h | tr '@' '\#' >$(1)/opt/include/unixodbc_conf.h
endef

define Package/unixodbc/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libodbc[ci]*so* $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libodbc.*so* $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libnn*so* $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/etc
	$(CP) $(PKG_INSTALL_DIR)/opt/etc/odbc* $(1)/opt/etc/
endef

define Package/unixodbc-tools/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/bin/
endef

define Package/pgsqlodbc/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libodbcpsql*so* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,unixodbc))
$(eval $(call BuildPackage,unixodbc-tools))
$(eval $(call BuildPackage,pgsqlodbc))
