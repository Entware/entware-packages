#
# Copyright (C) 2009-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=conntrack-tools
PKG_VERSION:=1.4.7
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://www.netfilter.org/projects/conntrack-tools/files
PKG_HASH:=099debcf57e81690ced57f516b493588a73518f48c14d656f823b29b4fc24b5d

PKG_MAINTAINER:=Jo-Philipp Wich <jo@mein.io>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:netfilter:conntrack-tools

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1
PKG_BUILD_DEPENDS:=libtirpc

include $(INCLUDE_DIR)/package.mk

define Package/conntrack-tools/default
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libnetfilter-conntrack +libnetfilter-cttimeout +libnetfilter-cthelper +libnetfilter-queue
  SUBMENU:=Firewall
  URL:=https://conntrack-tools.netfilter.org/
endef

define Package/conntrack
$(call Package/conntrack-tools/default)
  TITLE:=Connection tracking tool
endef

define Package/conntrack/description
 Conntrack is a userspace command line program targeted at system
 administrators. It enables them to view and manage the in-kernel
 connection tracking state table.
endef

CONFIGURE_ARGS += \
	--with-libtirpc

define Package/conntrack/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/conntrack $(1)/opt/sbin/
endef

define Package/conntrackd
$(call Package/conntrack-tools/default)
  TITLE:=Connection tracking daemon
endef

define Package/conntrackd/conffiles
/opt/etc/conntrackd/
endef

define Package/conntrackd/description
 Conntrackd can replicate the status of the connections that are
 currently being processed by your stateful firewall based on Linux.
 Conntrackd can also run as statistics daemon.
endef

define Package/conntrackd/install
	$(INSTALL_DIR) \
		$(1)/opt/etc/conntrackd \
		$(1)/opt/sbin
	$(INSTALL_BIN) 	$(PKG_INSTALL_DIR)/opt/sbin/conntrackd $(1)/opt/sbin/
endef

$(eval $(call BuildPackage,conntrack))
$(eval $(call BuildPackage,conntrackd))
