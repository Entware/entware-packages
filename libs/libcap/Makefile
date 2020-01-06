#
# Copyright (C) 2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libcap
PKG_VERSION:=2.27
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@KERNEL/linux/libs/security/linux-privs/libcap2
PKG_HASH:=dac1792d0118bee6aae6ba7fb93ff1602c6a9bda812fd63916eee1435b9c486a

PKG_MAINTAINER:=Paul Wassi <p.wassi@gmx.at>
PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=License

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/kernel.mk

define Package/libcap/Default
  TITLE:=Linux capabilities library
  SECTION:=libs
  CATEGORY:=Libraries
  URL:=https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/
endef

define Package/libcap/description/Default
  Linux capabilities
endef

define Package/libcap
  $(call Package/libcap/Default)
  TITLE += library
endef

define Package/libcap-bin
  $(call Package/libcap/Default)
  TITLE += binaries
  DEPENDS += libcap
endef

define Package/libcap-bin/description
  $(call Package/libcap/description/Default)
  .
  This package contains the libcap utilities.
endef

define Package/libcap-bin/config
  if PACKAGE_libcap-bin
  config PACKAGE_libcap-bin-capsh-shell
    string "capsh shell"
    help
      Set the capsh shell.
    default "/opt/bin/sh"
  endif
endef

MAKE_FLAGS += \
    prefix=/opt \
    BUILD_CC="$(CC)" \
    BUILD_CFLAGS="$(FPIC) -I$(PKG_BUILD_DIR)/libcap/include" \
    CFLAGS="$(TARGET_CFLAGS)" \
    LD="$(TARGET_CC) -Wl,-x -shared" \
    LDFLAGS="$(TARGET_LDFLAGS)" \
    INDENT="| true" \
    PAM_CAP="no" \
    RAISE_SETFCAP="no" \
    DYNAMIC="yes" \
    lib="lib"

ifneq ($(CONFIG_PACKAGE_libcap-bin-capsh-shell),)
TARGET_CFLAGS += -DSHELL='\"$(CONFIG_PACKAGE_libcap-bin-capsh-shell)\"'
endif

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include/sys
	$(CP) $(PKG_INSTALL_DIR)/opt/include/* $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
#	$(CP) $(PKG_INSTALL_DIR)/lib/* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/* $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(SED) 's,exec_prefix=,exec_prefix=/opt,g' $(1)/opt/lib/pkgconfig/libcap.pc
	$(SED) 's,/lib,$$$${exec_prefix}/lib,g' $(1)/opt/lib/pkgconfig/libcap.pc
	$(SED) 's,/opt/include,$$$${prefix}/include,g' $(1)/opt/lib/pkgconfig/libcap.pc
endef

define Package/libcap/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libcap.so* $(1)/opt/lib/
endef

define Package/libcap-bin/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(CP) $(PKG_INSTALL_DIR)/opt/sbin/capsh     $(1)/opt/sbin/
	$(CP) $(PKG_INSTALL_DIR)/opt/sbin/getcap    $(1)/opt/sbin/
	$(CP) $(PKG_INSTALL_DIR)/opt/sbin/getpcaps  $(1)/opt/sbin/
	$(CP) $(PKG_INSTALL_DIR)/opt/sbin/setcap    $(1)/opt/sbin/
endef

$(eval $(call BuildPackage,libcap))
$(eval $(call BuildPackage,libcap-bin))
