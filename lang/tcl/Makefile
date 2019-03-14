#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: downgraded from 8.6.9 to 8.5.18, upstream package is broken
# Threads support is broken on MIPS
# Missing tcl files added to package (/opt/lib/tcl*)

include $(TOPDIR)/rules.mk

PKG_NAME:=tcl
PKG_VERSION:=8.5.18
PKG_RELEASE:=1a

PKG_SOURCE:=$(PKG_NAME)$(PKG_VERSION)-src.tar.gz
PKG_SOURCE_URL:=@SF/$(PKG_NAME)
PKG_HASH:=032be57a607bdf252135b52fac9e3a7016e526242374ac7637b083ecc4c5d3c9

PKG_LICENSE:=TCL
PKG_LICENSE_FILES:=license.terms
PKG_MAINTAINER:=Joe Mistachkin <joe@mistachkin.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)$(PKG_VERSION)

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/tcl
  SUBMENU:=Tcl
  SECTION:=lang
  CATEGORY:=Languages
#  DEPENDS:=+libpthread
  TITLE:=The Tcl language
  URL:=http://www.tcl.tk/
endef

define Package/tcl/description
  Tcl, or Tool Command Language, is a an elegant, versatile, feature-rich,
  simple-to-learn yet very powerful industrial-strength open-source
  programming language and development platform. It is renowned for its
  stability and utility, and its emphasis on providing a cross-platform
  programming API makes it an ideal choice for an enormous variety of
  programming jobs.
endef

CONFIGURE_PATH := unix

CONFIGURE_VARS += \
	tcl_cv_strtod_unbroken=ok

#CONFIGURE_ARGS += \
#	--enable-threads

MAKE_PATH := unix

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/*.h $(1)/opt/include/

	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libtcl*.{a,so*} $(1)/opt/lib/
endef

define Package/tcl/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.so $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/tcl8 $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/tcl8.5 $(1)/opt/lib/

	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/bin
endef

$(eval $(call BuildPackage,tcl))
