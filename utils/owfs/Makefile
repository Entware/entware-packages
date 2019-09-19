#
# Copyright (C) 2008-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=owfs
PKG_VERSION:=3.2p3
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/owfs/owfs/releases/download/v$(PKG_VERSION)
PKG_HASH:=b8d33eba57d4a2f6c8a11ff23f233e3248bd75a42c8219b058a888846edd8717

PKG_MAINTAINER:=Jo-Philipp Wich <jo@mein.io>
PKG_LICENSE:=GPL-2.0
PKG_CPE_ID:=cpe:/a:owfs:owfs

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

PKG_CONFIG_DEPENDS:= \
  CONFIG_LIBOW_MASTER_USB \
  CONFIG_LIBOW_MASTER_I2C \
  CONFIG_LIBOW_MASTER_W1 \
  CONFIG_LIBOW_ZEROCONF \
  CONFIG_LIBOW_DEBUG \
  CONFIG_LIBOW_OWTRAFFIC

include $(INCLUDE_DIR)/package.mk

#
# templates
#

define Package/owfs/Default
  TITLE:=OWFS (1-Wire File System)
  URL:=https://github.com/owfs/owfs
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Filesystem
endef

define Package/owfs/Default/description
  OWFS is a suite of programs that designed to make the 1-wire bus and its
  devices easily accessible. The underlying principle is to create a virtual
  filesystem, with the unique ID being the directory, and the individual
  properties of the device are represented as simple files that can be read
  and written.

  Details of the individual slave or master design are hidden behind a
  consistent interface. The goal is to provide an easy set of tools for a
  software designer to create monitoring or control applications. There are
  some performance enhancements in the implementation, including data caching,
  parallel access to bus masters, and aggregation of device communication.
  Still the fundemental goal has been ease of use, flexibility and correctness
  rather than speed.
endef

define Package/owfs/Server
  $(call Package/owfs/Default)
  DEPENDS:=+libow +libpthread
endef

define Package/owfs/Library
  $(call Package/owfs/Default)
  SECTION:=libs
  CATEGORY:=Libraries
endef

define Package/owfs/Utility
  $(call Package/owfs/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+libow
endef

#
# shared libraries
#

define Package/libow
  $(call Package/owfs/Library)
  DEPENDS:= \
    +libpthread \
    +LIBOW_MASTER_USB:libusb-compat
  TITLE:=OWFS - common shared library
endef

define Package/libow/config
  source "$(SOURCE)/Config.in"
endef

define Package/libow/description
  $(call Package/owfs/Default/description)

  This package contains the OWFS library.
endef

define Package/libow-capi
  $(call Package/owfs/Library)
  DEPENDS:=+libow
  TITLE:=OWFS - C-API library
endef

define Package/libow-capi/description
  $(call Package/owfs/Default/description)

  This package contains the OWFS C-API library.
endef

#
# utilities
#

define Package/owshell
  $(call Package/owfs/Utility)
  TITLE:=OWFS - shell utilities
endef

define Package/owshell/description
  $(call Package/owfs/Default/description)

  This package contains the OWFS shell utilities.
endef

define Package/owfs
  $(call Package/owfs/Utility)
  # libfuse depends on kmod-fuse, no need to declare dependency
  DEPENDS+= +libfuse +fuse-utils
  TITLE:=OWFS - fuse file system
endef

define Package/owfs/description
  $(call Package/owfs/Default/description)

  This package contains the OWFS fuse filesystem.
endef

#
# network daemons
#

define Package/owhttpd
  $(call Package/owfs/Server)
  TITLE:=OWFS - http server
endef

define Package/owhttpd/description
  $(call Package/owfs/Default/description)

  This package contains the OWFS http server.
endef

define Package/owftpd
  $(call Package/owfs/Server)
  TITLE:=OWFS - ftp server
endef

define Package/owftpd/description
  $(call Package/owfs/Default/description)

  This package contains the OWFS ftp server.
endef

define Package/owserver
  $(call Package/owfs/Server)
  TITLE:=OWFS - network server
endef

define Package/owserver/description
  $(call Package/owfs/Default/description)

  This package contains the OWFS network server.
endef

CONFIGURE_ARGS += \
	--enable-owftpd \
	--enable-owserver \
	--enable-owhttpd \
	--enable-owfs \
	--with-fuseinclude="$(STAGING_DIR)/opt/include" \
	--with-fuselib="$(STAGING_DIR)/opt/lib" \
	--enable-shared \
	--disable-parport \
	--disable-ownet \
	--disable-owpython \
	--disable-owphp \
	--disable-owtcl \
	--disable-swig \
	--disable-avahi \
	$(if $(CONFIG_LIBOW_MASTER_USB),--enable-usb,--disable-usb) \
	$(if $(CONFIG_LIBOW_MASTER_W1),--enable-w1,--disable-w1) \
	$(if $(CONFIG_LIBOW_MASTER_I2C),--enable-i2c,--disable-i2c) \
	$(if $(CONFIG_LIBOW_ZEROCONF),--enable-zero,--disable-zero) \
	$(if $(CONFIG_LIBOW_DEBUG),--enable-debug,--disable-debug) \
	$(if $(CONFIG_LIBOW_OWTRAFFIC),--enable-owtraffic,--disable-owtraffic)

CONFIGURE_VARS += \
	LDFLAGS="$(TARGET_LDFLAGS) -Wl,-rpath-link=$(STAGING_DIR)/opt/lib -Wl,-rpath-link=$(TOOLCHAIN_DIR)/lib" \
	lt_cv_sys_lib_dlsearch_path_spec="$(STAGING_DIR)/opt/lib" \
	lt_cv_sys_lib_search_path_spec="$(STAGING_DIR)/opt/lib" \
	shrext_cmds=".so" \

MAKE_FLAGS += \
	CC="$(TARGET_CC)" \
	HOST_CPU="$(PKGARCH)"

define Build/InstallDev
	$(INSTALL_DIR) $(STAGING_DIR)/opt/include
	$(CP)	$(PKG_INSTALL_DIR)/opt/include/ow{capi,fs_config}.h $(STAGING_DIR)/opt/include/
	$(INSTALL_DIR) $(STAGING_DIR)/opt/lib
	$(CP)	$(PKG_INSTALL_DIR)/opt/lib/libow{,capi}*.so* $(STAGING_DIR)/opt/lib/
endef

define Package/owfs/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/owfs $(1)/opt/bin/
endef

define Package/owshell/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/owget $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/owread $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/owwrite $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/owdir $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/owpresent $(1)/opt/bin/
endef


define Package/owserver/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/owserver $(1)/opt/bin/
endef

define Package/owhttpd/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/owhttpd $(1)/opt/bin/
endef

define Package/owftpd/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/owftpd $(1)/opt/bin/
endef


define Package/libow/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libow-*.so.* $(1)/opt/lib/
endef

define Package/libow-capi/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libowcapi-*.so.* $(1)/opt/lib/
endef


$(eval $(call BuildPackage,owfs))
$(eval $(call BuildPackage,owshell))

$(eval $(call BuildPackage,owserver))
$(eval $(call BuildPackage,owhttpd))
$(eval $(call BuildPackage,owftpd))

$(eval $(call BuildPackage,libow))
$(eval $(call BuildPackage,libow-capi))
