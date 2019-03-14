#
# Copyright (C) 2010 Gianluigi Tiesi <sherpya@netfarm.it>
# Copyright (C) 2011-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: bump from 1.0.110~bpo9+1 to 1.0.114

include $(TOPDIR)/rules.mk

PKG_NAME:=debootstrap
PKG_VERSION:=1.0.114
PKG_RELEASE:=1
PKG_MAINTAINER:=Daniel Golle <daniel@makrotopia.org>

PKG_SOURCE:=$(PKG_NAME)_$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://ftp.debian.org/debian/pool/main/d/debootstrap
PKG_HASH:=a8e1456816a9ed55bf329de1cc93a199ad2099a21a66804b78e1aa0e170a9c92
PKG_LICENSE:=Unique
PKG_LICENSE_FILES:=debian/copyright

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_UNPACK:=tar -C $(PKG_BUILD_DIR) -xzf $(DL_DIR)/$(PKG_SOURCE) --strip-components 1

DEBIAN_ARCH:=$(subst x86_64,amd64,$(subst aarch64,arm64,$(subst arm,armel,$(ARCH))))

include $(INCLUDE_DIR)/package.mk

# on Qnap NASes mount applet from busybox does not work correctly (both from firmare and entware).
# we will use mount-utils

define Package/debootstrap
  SECTION:=admin
  CATEGORY:=Administration
  TITLE:=Bootstrap a basic Debian system
  URL:=http://wiki.debian.org/Debootstrap
  DEPENDS:= +coreutils +coreutils-chroot +coreutils-sha1sum +coreutils-readlink +mount-utils +ar +xz
endef

define Package/debootstrap/description
 debootstrap is used to create a Debian base system from scratch, without
 requiring the availability of dpkg or apt. It does this by downloading .deb
 files from a mirror site, and carefully unpacking them into a directory which
 can eventually be chrooted into.
endef

define Build/Compile
# file pkgdetails.c was imported from debian package base-installer version 1.185
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
