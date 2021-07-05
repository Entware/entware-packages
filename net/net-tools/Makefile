#
# Copyright (C) 2006-2010 OpenWrt.org
# Copyright (C) 2016 Stijn Segers
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: net-tools-route renamed to net-tools package
# with all utilities compiled

include $(TOPDIR)/rules.mk

PKG_NAME:=net-tools
PKG_VERSION:=2.10
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://sourceforge.net/projects/net-tools/files/
PKG_HASH:=b262435a5241e89bfa51c3cabd5133753952f7a7b7b93f32e08cb9d96f580d69

PKG_MAINTAINER:=Stijn Segers <borromini.reg@protonmail.com>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/mii-tool
  SECTION:=net
  CATEGORY:=Network
  TITLE:=configure media type using MII commands
  URL:=http://net-tools.sourceforge.net/
endef

define Package/mii-tool/description
	The mii-tool command allows you to set or autodetect the media type
	or mii chipset-based ethernet devices. It traditionally had been
	distributed in the net-tools package. This is a single distribution
	optimized for embedded systems and fully automated cross/-sysroot-builds
endef

define Package/net-tools
  SECTION:=net
  CATEGORY:=Network
  TITLE:=net-tools utilities
  URL:=http://net-tools.sourceforge.net/
  PROVIDES:=route
#  ALTERNATIVES:=300:/sbin/route:/usr/libexec/net-tools-route
endef

define Package/net-tools/description
	Linux base networking tools.
endef

define Build/Configure
	# Failed configure.sh leaves stub config.h around.
	rm -f $(PKG_BUILD_DIR)/config.h
	( cd $(PKG_BUILD_DIR); yes $$$$'\n' | ./configure.sh config.in )
endef

define Package/mii-tool/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mii-tool $(1)/opt/sbin/
endef

define Package/net-tools/install
	$(INSTALL_DIR) $(1)/opt
	$(CP) $(PKG_INSTALL_DIR)/{bin,sbin} $(1)/opt
	$(RM) $(1)/opt/sbin/mii-tool
	mv $(1)/opt/bin/ifconfig $(1)/opt/sbin
endef

$(eval $(call BuildPackage,mii-tool))
$(eval $(call BuildPackage,net-tools))
