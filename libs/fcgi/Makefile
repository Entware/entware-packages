#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=fcgi
PKG_VERSION:=2.4.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)2-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/FastCGI-Archives/fcgi2/tar.gz/$(PKG_VERSION)?
PKG_HASH:=53cc36624bb92a88e3d5a3d696282e1af24b280c3f275604123d9c6d407173e2
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)2-$(PKG_VERSION)

PKG_MAINTAINER:=Jacob Siverskog <jacob@teenageengineering.com>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE.TERMS

PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/fcgi/Default
  SECTION:=libs
  CATEGORY:=Libraries
  URL:=https://fastcgi-archives.github.io/
endef

define Package/fcgi
  $(call Package/fcgi/Default)
  MENU:=1
  DEPENDS:=+libpthread
  TITLE:=Shared library of FastCGI
endef

define Package/fcgixx
  $(call Package/fcgi/Default)
  DEPENDS:=fcgi +libstdcpp
  TITLE:=Shared library of FastCGI++
endef

define Package/fcgi/description
 FastCGI is a language independent, scalable, open extension to
 CGI that provides high performance without the limitations of
 server specific APIs.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/fastcgi.h $(1)/opt/include/
	$(CP) $(PKG_INSTALL_DIR)/opt/include/fcgi{app,_config,misc,o,os,_stdio}.h $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libfcgi{,++}.{a,so*} $(1)/opt/lib/
endef

define Package/fcgi/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/cgi-fcgi $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libfcgi.so.* $(1)/opt/lib/
endef

define Package/fcgixx/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libfcgi++.so.* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,fcgi))
$(eval $(call BuildPackage,fcgixx))
