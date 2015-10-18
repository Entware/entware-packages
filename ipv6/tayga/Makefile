# $Id: Makefile 5624 2006-11-23 00:29:07Z nbd $

include $(TOPDIR)/rules.mk

PKG_NAME:=tayga
PKG_VERSION:=0.9.2
PKG_RELEASE:=2

PKG_SOURCE:=tayga-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://www.litech.org/tayga/
PKG_MD5SUM:=7a7b24165ce008df772f398d86fa280e
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
