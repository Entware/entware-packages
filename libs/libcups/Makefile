#
# Copyright (C) 2006-2012 OpenWrt.org
# Copyright (C) 2017-2018 Luiz Angelo Daros de Luca <luizluca@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: libcups/install section, cups package with all other stuff

include $(TOPDIR)/rules.mk

PKG_NAME:=cups
PKG_VERSION:=2.2.10
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-source.tar.gz
PKG_SOURCE_URL:=https://github.com/apple/cups/releases/download/v$(PKG_VERSION)/
PKG_HASH:=77c8b2b3bb7fe8b5fbfffc307f2c817b2d7ec67b657f261a1dd1c61ab81205bb
PKG_MAINTAINER:=Luiz Angelo Daros de Luca <luizluca@gmail.com>
PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE.txt

include $(INCLUDE_DIR)/package.mk

define Package/libcups/Default
  URL:=http://www.cups.org/
  SUBMENU:=Printing
endef

define Package/libcups
$(call Package/cups/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+zlib +libpthread +libpng +libjpeg +libusb-1.0
  TITLE:=Common UNIX Printing System - Core library
endef

define Package/cups
$(call Package/cups/Default)
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libcups +libstdcpp
  TITLE:=Common UNIX Printing System
endef

define Package/libcups/description
	Common UNIX Printing System - Core library
endef

define Package/cups/description
	Common UNIX Printing System
endef

TARGET_LDFLAGS+=-Wl,-rpath-link=$(STAGING_DIR)/opt/lib

CONFIGURE_ARGS+=--with-cups-user="nobody" \
		--with-cups-group="nogroup" \
		--without-perl \
		--without-python \
		--without-php \
		--enable-shared \
		--enable-libusb \
		--disable-acl \
		--disable-dbus \
		--disable-dnssd \
		--disable-launchd \
		--disable-pam \
		--disable-gnutls \
		--disable-cdsassl \
		--disable-ssl \
		--disable-gssapi \
		--with-cupsd-file-perm="0700" \
		--without-java \
		--disable-avahi \
		--disable-systemd \
		UNAME="Linux" \
		LIBS="$(TARGET_LDFLAGS) -lz -lpng -ljpeg"

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		$(TARGET_CONFIGURE_OPTS) \
		DSTROOT="$(PKG_INSTALL_DIR)" \
		STRIP="/bin/true" \
		all install
	$(INSTALL_DIR) $(PKG_INSTALL_DIR)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/cups-config $(PKG_INSTALL_DIR)/opt/bin
endef

define Build/InstallDev
	$(INSTALL_DIR) $(2)/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/cups-config $(2)/bin/
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/cups $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib*/libcups*.so* $(1)/opt/lib/
endef

define Package/cups/conffiles
/opt/etc/cups
endef

define Package/libcups/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib*/libcups*.so* $(1)/opt/lib/
endef

define Package/cups/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/{bin,sbin,etc,share,var} $(1)/opt/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/cups $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S60cupsd $(1)/opt/etc/init.d/
endef

$(eval $(call BuildPackage,libcups))
$(eval $(call BuildPackage,cups))
