#
# Copyright (C) 2010 Gianluigi Tiesi <sherpya@netfarm.it>
# Copyright (C) 2011-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware-3x: upgraded version to 1.0.87, removed dependencies (using installed busybox)
include $(TOPDIR)/rules.mk

PKG_NAME:=debootstrap
PKG_VERSION:=1.0.87
PKG_RELEASE:=1a
PKG_MAINTAINER:=Daniel Golle <daniel@makrotopia.org>

PKG_SOURCE=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://anonscm.debian.org/git/d-i/debootstrap.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBDIR=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=c4ad96b3972426df3d261d33a5025335fef86f79
PKG_LICENSE:=Unique
PKG_LICENSE_FILES:=debian/copyright

DEBIAN_ARCH:=$(subst x86_64,amd64,$(subst arm,armel,$(ARCH)))

include $(INCLUDE_DIR)/package.mk

define Package/debootstrap
  SECTION:=admin
  CATEGORY:=Administration
  TITLE:=Bootstrap a basic Debian system
  URL:=http://wiki.debian.org/Debootstrap
endef

define Package/debootstrap/description
 debootstrap is used to create a Debian base system from scratch, without
 requiring the availability of dpkg or apt. It does this by downloading .deb
 files from a mirror site, and carefully unpacking them into a directory which
 can eventually be chrooted into.
endef

define Build/Compile
# file pkgdetails.c was imported from debian package base-installer version 1.167
	$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS) ./files/pkgdetails.c -o $(PKG_BUILD_DIR)/pkgdetails
endef

define Package/debootstrap/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/$(PKG_NAME) $(1)/opt/sbin
	$(SED) 's/@VERSION@/$(PKG_VERSION)/g' $(1)/opt/sbin/debootstrap
	$(INSTALL_DIR) $(1)/opt/share/debootstrap
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/pkgdetails $(1)/opt/share/debootstrap
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/functions $(1)/opt/share/debootstrap
	$(INSTALL_DIR) $(1)/opt/share/debootstrap/scripts
	$(CP) $(PKG_BUILD_DIR)/scripts/* $(1)/opt/share/debootstrap/scripts
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) ./files/{install,start}-debian $(1)/opt/bin
	$(SED) 's/@ARCH@/$(DEBIAN_ARCH)/g' $(1)/opt/bin/install-debian
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99debian $(1)/opt/etc/init.d
endef

$(eval $(call BuildPackage,debootstrap))
