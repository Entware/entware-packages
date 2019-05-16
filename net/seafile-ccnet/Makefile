#
# Copyright (C) 2007-2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=seafile-ccnet
PKG_VERSION:=6.3.4
PKG_RELEASE:=2
PKG_LICENSE:=GPL-3.0

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/haiwen/ccnet-server/tar.gz/v$(PKG_VERSION)-server?
PKG_HASH:=ab3d5bda728f87c71929a6247c9f74c5209b9b8e44bafa77db91e8de590ec6ef
PKG_BUILD_DIR:=$(BUILD_DIR)/ccnet-server-$(PKG_VERSION)-server
PKG_MAINTAINER:=Alexandru Ardelean <ardeleanalex@gmail.com>

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk
include ../../lang/python/python-package.mk

define Package/seafile-ccnet
    SECTION:=net
    CATEGORY:=Network
    TITLE:=Seafile server - ccnet component
    URL:=http://seafile.com/
    DEPENDS:=+libsearpc +libevent2 +libopenssl \
		+glib2 +python +libzdb +libuuid \
		+libpthread +libsqlite3 +jansson $(ICONV_DEPENDS)
endef

define Package/seafile-ccnet/description
   Ccnet is a framework for writing networked applications in C.
endef

CONFIGURE_ARGS += --disable-client \
		    --enable-server \
		    --disable-ldap \
		    --disable-cluster \
		    --enable-python \
		    --disable-server-pkg \
		    --disable-static-build \
		    --disable-compile-demo \
		    --disable-console

PKG_BUILD_DEPENDS:=vala/host

TARGET_LDFLAGS += -Wl,-rpath-link=$(STAGING_DIR)/opt/lib -liconv \
		    -L$(STAGING_DIR)/opt/lib/mysql -lmysqlclient -lz

MAKE_VARS += LC_ALL= LANG=en_US.UTF-8


define Package/seafile-ccnet/install
	$(INSTALL_DIR) $(1)/opt/{bin,lib}
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ccnet* $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/ccnet $(1)$(PYTHON_PKG_DIR)
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libccnet.so* $(1)/opt/lib/
	find $(1) -name "*\.pyc" -o -name "*\.pyo" | xargs rm -f
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/include/ccnet* $(1)/opt/include/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libccnet.pc $(1)/opt/lib/pkgconfig/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libccnet.{a,so*} $(1)/opt/lib/
endef

$(eval $(call BuildPackage,seafile-ccnet))
