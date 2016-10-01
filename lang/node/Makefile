#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=node
PKG_VERSION:=v6.7.0
PKG_RELEASE:=1

PKG_SOURCE:=node-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://nodejs.org/dist/$(PKG_VERSION)

HOST_BUILD_DEPENDS:=python/host
PKG_BUILD_DEPENDS:=python/host
PKG_INSTALL:=1
PKG_USE_MIPS16:=0

HOST_BUILD_PARALLEL:=1
PKG_BUILD_PARALLEL:=1

PKG_MAINTAINER:=John Crispin <blogic@openwrt.org>
PKG_LICENSE:=

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk

define Package/node
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Node.js
  TITLE:=Node.js is a platform built on Chrome's JavaScript runtime
  URL:=http://nodejs.org/
  DEPENDS:=+libstdcpp +libopenssl +libuv +icu @!TARGET_armv5_3x
endef

define Package/node/description
  Node.js is a JavaScript runtime built on Chrome's V8 JavaScript engine. Node.js uses
  an event-driven, non-blocking I/O model that makes it lightweight and efficient. Node.js'
   package ecosystem, npm, is the largest ecosystem of open source libraries in the world.
endef

CPU:=$(subst x86_64,x64,$(subst i386,ia32,$(ARCH)))

MAKE_VARS += \
	DESTCPU=$(CPU)

CONFIGURE_ARGS= \
	--dest-cpu=$(CPU) \
	--dest-os=linux \
	--without-snapshot \
	--shared-zlib \
	--shared-openssl \
	--prefix=/opt \
	--with-arm-float-abi=softfp \
	--with-mips-float-abi=soft \
	--with-intl=system-icu

HOST_CONFIGURE_VARS:=
HOST_CONFIGURE_ARGS:= \
	--dest-os=linux \
	--without-snapshot \
	--prefix=$(STAGING_DIR)/host

HOST_CONFIGURE_CMD:=python ./configure

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/* $(1)/opt/include/
endef

define Package/node/install
	mkdir -p $(1)/opt/bin $(1)/opt/lib/node_modules/npm/{bin,lib,node_modules}
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/{node,npm} $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/node_modules/npm/{package.json,LICENSE,cli.js} $(1)/opt/lib/node_modules/npm
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/node_modules/npm/bin/npm-cli.js $(1)/opt/lib/node_modules/npm/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/node_modules/npm/lib/* $(1)/opt/lib/node_modules/npm/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/node_modules/npm/node_modules/* $(1)/opt/lib/node_modules/npm/node_modules/
	$(SED) 's,/usr/bin/env node,/opt/bin/node,g' $(1)/opt/lib/node_modules/npm/cli.js
	$(SED) 's,/usr/bin/env node,/opt/bin/node,g' $(1)/opt/lib/node_modules/npm/bin/npm-cli.js
endef

$(eval $(call HostBuild))
$(eval $(call BuildPackage,node))
