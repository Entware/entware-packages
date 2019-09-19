#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=keyutils
PKG_VERSION:=1.6
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://people.redhat.com/dhowells/keyutils/
PKG_HASH:=d3aef20cec0005c0fa6b4be40079885567473185b1a57b629b030e67942c7115

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libkeyutils
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Key utilities library
  URL:=https://people.redhat.com/dhowells/keyutils/
  LICENSE:=LGPL-2.1-or-later
  LICENSE_FILES:=LICENSE.LGPL
  ABI_VERSION:=1
endef

define Package/keyctl
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Encryption
  TITLE:=keyctl
  DEPENDS:=+libkeyutils
  LICENSE:=GPL-2.0-or-later
  LICENSE_FILES:=LICENSE.GPL
endef

define Package/keyutils/description
  Key utilities
endef

MAKE_FLAGS += \
	BINDIR=/opt/bin \
	LIBDIR=/opt/lib \
	SBINDIR=opt/sbin \
	CFLAGS="$(TARGET_CFLAGS) $(FPIC)"

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/* $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libkeyutils.a $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libkeyutils.so.$(ABI_VERSION)* $(1)/opt/lib/
endef

define Package/libkeyutils/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libkeyutils.so.$(ABI_VERSION)* $(1)/opt/lib/
endef

define Package/keyctl/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/keyctl $(1)/opt/bin
endef

$(eval $(call BuildPackage,libkeyutils))
$(eval $(call BuildPackage,keyctl))
