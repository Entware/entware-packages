# $Id: Makefile 5624 2006-11-23 00:29:07Z nbd $

include $(TOPDIR)/rules.mk

PKG_NAME:=tayga
PKG_VERSION:=0.9.2
PKG_RELEASE:=2a

PKG_SOURCE:=tayga-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://www.litech.org/tayga/
PKG_HASH:=2b1f7927a9d2dcff9095aff3c271924b052ccfd2faca9588b277431a44f0009c
PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/tayga
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Out-of-kernel stateless NAT64 implementation for Linux
  URL:=http://www.litech.org/tayga/
  MAINTAINER:=Ondrej Caletka <ondrej@caletka.cz>
endef

define Package/tayga/description
  TAYGA is an out-of-kernel stateless NAT64 implementation for
  Linux.  It uses the TUN driver to exchange packets with the
  kernel, which is the same driver used by OpenVPN and QEMU/KVM.
endef

define Package/tayga/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tayga $(1)/opt/sbin/
endef

$(eval $(call BuildPackage,tayga))
