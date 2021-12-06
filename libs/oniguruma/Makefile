# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=oniguruma
PKG_VERSION:=6.9.7.1
PKG_RELEASE:=1

PKG_SOURCE:=onig-v$(subst _,-,$(PKG_VERSION)).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/kkos/oniguruma/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=8f9a75b7d90dde0942c30a8b3c17889b2fecf190690988cc381c4e525cbbd22b

PKG_MAINTAINER:=Eneas U de Queiroz <cotequeiroz@gmail.com>
PKG_LICENSE:=BSD-2-Clause
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:oniguruma_project:oniguruma

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/oniguruma
    SECTION:=libs
    CATEGORY:=Libraries
    TITLE:=Regular expression library for different character encodings
    URL:=https://github.com/kkos/oniguruma
    ABI_VERSION:=5
endef

define Package/oniguruma/description
   Oniguruma is a modern and flexible regular expressions library.
   It encompasses features from different regular expression implementations that
   traditionally exist in different languages.

   Character encoding can be specified per regular expression object.
endef

CONFIGURE_ARGS += --enable-posix-api

define Package/oniguruma/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/lib/libonig.so.$(ABI_VERSION) $(1)/opt/lib/
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/{include,lib}
	$(CP) $(PKG_INSTALL_DIR)/opt/include/* $(1)/opt/include/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/* $(1)/opt/lib/
	$(SED) 's,/opt,$(STAGING_DIR)/opt,g' $(1)/opt/lib/pkgconfig/oniguruma.pc
endef

$(eval $(call BuildPackage,oniguruma))
