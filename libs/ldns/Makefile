#
# Copyright (C) 2011-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ldns
PKG_VERSION:=1.8.3
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.nlnetlabs.nl/downloads/ldns
PKG_HASH:=c3f72dd1036b2907e3a56e6acf9dfb2e551256b3c1bbd9787942deeeb70e7860

PKG_MAINTAINER:=Eric Luehrsen <ericluehrsen@gmail.com>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE
PKG_CPE_ID:=cpe:/a:nlnetlabs:ldns

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libldns/Default
  URL:=http://www.nlnetlabs.nl/projects/ldns/
  DEPENDS:=+libopenssl
endef

define Package/libldns
  $(call Package/libldns/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=A library to simplify DNS programming
endef

define Package/libldns/description
  The goal of ldns is to simplify DNS programming, it supports recent RFCs like
  the DNSSEC documents, and allows developers to easily create software
  conforming to current RFCs, and experimental software for current Internet
  Drafts.
endef

define Package/drill
  $(call Package/libldns/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE:=DNS(SEC) information tool
  DEPENDS+= +libldns
endef

define Package/drill/description
  ldns includes the drill tool, which is much like dig from BIND. It was
  designed with DNSSEC in mind and should be a useful debugging/query tool
  for DNSSEC.
endef

define Package/ldns-examples
  $(call Package/libldns/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE:=Example programs from NLNetLabs ldns library
  DEPENDS+= +libldns +libpcap +drill
endef

define Package/ldns-examples/description
  A few example programs are included in the source of ldns. They include tools
  which can create DNSSEC keys and DNSSEC zone files.
endef

CONFIGURE_ARGS += \
	--disable-dsa \
	--disable-gost \
	--enable-ecdsa \
	--with-drill \
	--with-examples \
	--with-ssl="$(STAGING_DIR)/opt"

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/ldns $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libldns.{a,so*} $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_BUILD_DIR)/packaging/libldns.pc $(1)/opt/lib/pkgconfig
endef

define Package/libldns/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libldns.so.* $(1)/opt/lib/
endef

define Package/drill/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/drill $(1)/opt/bin/
endef

define Package/ldns-examples/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-chaos $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-compare-zones $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-dane $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-dpa $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-gen-zone $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-key2ds $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-keyfetcher $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-keygen $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-mx $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-notify $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-nsec3-hash $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-read-zone $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-revoke $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-rrsig $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-signzone $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-test-edns $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-testns $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-update $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-verify-zone $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-version $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-walk $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-zcat $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldns-zsplit $(1)/opt/bin/
endef

$(eval $(call BuildPackage,libldns))
$(eval $(call BuildPackage,drill))
$(eval $(call BuildPackage,ldns-examples))
