include $(TOPDIR)/rules.mk

PKG_NAME:=redis
PKG_VERSION:=5.0.5
PKG_RELEASE:=2

PKG_SOURCE_URL:=http://download.redis.io/releases/
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_HASH:=2139009799d21d8ff94fc40b7f36ac46699b9e1254086299f8d3b223ca54a375

PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec@nic.cz>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=COPYING
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

MAKE_FLAGS+= \
	MALLOC="libc" \
	USE_JEMALLOC="no" \
	PREFIX="$(PKG_INSTALL_DIR)/opt" \
	ARCH=""

define Package/redis/Default
  SUBMENU:=Database
  SECTION:=libs
  CATEGORY:=Libraries
  URL:=https://redis.io
endef

define Package/redis-server
$(call  Package/redis/Default)
  TITLE:=Redis server
  DEPENDS:=+libpthread
endef

define Package/redis-cli
$(call  Package/redis/Default)
  TITLE:=Redis cli
endef

define Package/redis-utils
$(call  Package/redis/Default)
  TITLE:=Redis utilities
  DEPENDS:=+redis-server
endef

define Package/redis-full
$(call  Package/redis/Default)
  TITLE:=All Redis binaries (server,cli and utils)
  DEPENDS:=+redis-utils +redis-cli
endef

define Package/redis-full/description
  Redis is an open source, BSD licensed, advanced key-value cache and store.
  It is often referred to as a data structure server since keys can contain
  strings, hashes, lists, sets, sorted sets, bitmaps and hyperloglogs.
endef

define Package/redis-server/conffiles
/opt/etc/redis.conf
endef

define Build/Compile
	$(MAKE) -C "$(PKG_BUILD_DIR)/deps/hiredis" static $(MAKE_FLAGS)  $(MAKE_VARS)
	$(MAKE) -C "$(PKG_BUILD_DIR)/deps/linenoise" $(MAKE_FLAGS)  $(MAKE_VARS)
	$(MAKE) -C "$(PKG_BUILD_DIR)/deps/lua" posix $(MAKE_FLAGS)  $(MAKE_VARS) AR="${AR} ru"
	$(call Build/Compile/Default)
endef

define Package/redis-server/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/redis-server $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S70redis $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/redis.conf $(1)/opt/etc/
#	$(SED) "s|^dir .*|dir /var/lib/redis|" $(1)/etc/redis.conf
endef

define Package/redis-cli/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/redis-cli $(1)/opt/bin/
endef

define Package/redis-utils/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/redis-{check-aof,benchmark} $(1)/opt/bin/
endef

$(eval $(call BuildPackage,redis-full))
$(eval $(call BuildPackage,redis-server))
$(eval $(call BuildPackage,redis-cli))
$(eval $(call BuildPackage,redis-utils))
