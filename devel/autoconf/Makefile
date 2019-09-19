#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=autoconf
PKG_VERSION:=2.69
PKG_RELEASE:=3

PKG_SOURCE_URL:=@GNU/autoconf
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_HASH:=64ebcec9f8ac5b2487125a86a7760d2591ac9e1d3dbd59489633f9de62a57684
PKG_MAINTAINER:=Heinrich Schuchardt <xypron.glpk@gmx.de>
PKG_LICENSE:=GPL-3.0-or-later

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

CONFIGURE_VARS += M4=m4 EMACS=no

define Package/autoconf
  SECTION:=devel
  CATEGORY:=Development
  TITLE:=autoconf
  URL:=https://www.gnu.org/software/autoconf/
  DEPENDS:=+m4 +perl +perlbase-data +perlbase-file +perlbase-getopt \
  +perlbase-dynaloader +perlbase-text
endef

define Package/autoconf/description
  Autoconf is an extensible package of M4 macros that produce shell scripts to
  automatically configure software source code packages.
endef

define Build/Install
	$(SED) 's/@PERL@/\/usr\/bin\/perl/g' $(PKG_BUILD_DIR)/bin/Makefile.in
	$(call Build/Install/Default)
endef

define Package/autoconf/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(SED) 's|$(STAGING_DIR_HOST)|/opt|g' $(PKG_INSTALL_DIR)/opt/bin/autom4te
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/share/autoconf
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/share/autoconf/INSTALL \
	$(1)/opt/share/autoconf/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/share/autoconf/autom4te.cfg \
	$(1)/opt/share/autoconf/
	$(INSTALL_DIR) $(1)/opt/share/autoconf/Autom4te
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/share/autoconf/Autom4te/* \
	$(1)/opt/share/autoconf/Autom4te/
	$(INSTALL_DIR) $(1)/opt/share/autoconf/autoconf
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/share/autoconf/autoconf/* \
	$(1)/opt/share/autoconf/autoconf/
	$(INSTALL_DIR) $(1)/opt/share/autoconf/autoscan
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/share/autoconf/autoscan/* \
	$(1)/opt/share/autoconf/autoscan/
	$(INSTALL_DIR) $(1)/opt/share/autoconf/autotest
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/share/autoconf/autotest/* \
	$(1)/opt/share/autoconf/autotest/
	$(INSTALL_DIR) $(1)/opt/share/autoconf/m4sugar
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/share/autoconf/m4sugar/* \
	$(1)/opt/share/autoconf/m4sugar/
	find $(PKG_INSTALL_DIR)/opt/bin -type f | xargs $(SED) 's|/usr/bin/perl|/opt/bin/perl|'
endef

$(eval $(call BuildPackage,autoconf))
