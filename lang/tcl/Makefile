#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: downgraded from 8.6.9 to 8.5.18, upstream package is broken
# Threads support is broken on MIPS
# Missing tcl files added to package (/opt/lib/tcl*)
# Added host build

include $(TOPDIR)/rules.mk

PKG_NAME:=tcl
TCL_MAJOR_VERSION:=8.5
PKG_VERSION:=${TCL_MAJOR_VERSION}.18
PKG_RELEASE:=1b

PKG_SOURCE:=$(PKG_NAME)$(PKG_VERSION)-src.tar.gz
PKG_SOURCE_URL:=@SF/$(PKG_NAME)
PKG_HASH:=032be57a607bdf252135b52fac9e3a7016e526242374ac7637b083ecc4c5d3c9
PKG_LICENSE:=TCL
PKG_LICENSE_FILES:=license.terms
PKG_MAINTAINER:=Joe Mistachkin <joe@mistachkin.com>
PKG_CPE_ID:=cpe:/a:tcl_tk:tcl_tk

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)$(PKG_VERSION)
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/$(PKG_NAME)$(PKG_VERSION)

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk

define Package/tcl
  SUBMENU:=Tcl
  SECTION:=lang
  CATEGORY:=Languages
#  DEPENDS:=+libpthread
  TITLE:=The Tcl language
  URL:=https://www.tcl.tk/
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
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/tclConfig.sh $(1)/opt/lib/

	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/tcl.pc \
		$(1)/opt/lib/pkgconfig
	$(SED) 's,/opt/include,$$$${prefix}/include,g' $(1)/opt/lib/pkgconfig/tcl.pc
	$(SED) 's,/opt/lib,$$$${prefix}/lib,g' $(1)/opt/lib/pkgconfig/tcl.pc
endef

define Package/tcl/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.so $(1)/opt/lib

	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/bin

	$(CP) -a $(PKG_INSTALL_DIR)/opt/lib/tcl8 $(1)/opt/lib/
	$(CP) -a $(PKG_INSTALL_DIR)/opt/lib/tcl$(TCL_MAJOR_VERSION) $(1)/opt/lib/
	$(LN) tclsh$(TCL_MAJOR_VERSION) $(1)/opt/bin/tclsh
endef

define Host/Configure
	$(call Host/Configure/Default,$(1),$(2),$(CONFIGURE_PATH)/$(3))
endef

define Host/Compile
	+$(HOST_MAKE_VARS) \
	$(MAKE) $(HOST_JOBS) -C $(HOST_BUILD_DIR)/$(MAKE_PATH) \
		$(HOST_MAKE_FLAGS) \
		$(1)
endef

define Host/Install
	$(call Host/Compile,install)
	(cd $(HOST_BUILD_PREFIX)/bin; test -f tclsh || ln -s tclsh$(TCL_MAJOR_VERSION) tclsh)
endef

$(eval $(call HostBuild))
$(eval $(call BuildPackage,tcl))
