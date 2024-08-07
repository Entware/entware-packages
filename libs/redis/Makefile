include $(TOPDIR)/rules.mk

PKG_NAME:=redis
PKG_VERSION:=6.2.14
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://download.redis.io/releases/
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_HASH:=34e74856cbd66fdb3a684fb349d93961d8c7aa668b06f81fd93ff267d09bc277

PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec1@gmail.com>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:redis:redis

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

MAKE_FLAGS+= \
	MALLOC="libc" \
	USE_JEMALLOC="no" \
	PREFIX="$(PKG_INSTALL_DIR)/opt" \
	ARCH=""

TARGET_LDFLAGS += -latomic

define Package/redis/Default
  SUBMENU:=Database
  SECTION:=libs
  CATEGORY:=Libraries
  URL:=https://redis.io
endef

define Package/redis-server
$(call  Package/redis/Default)
  TITLE:=Redis server
  DEPENDS:=+libpthread +libatomic
endef

define Package/redis-cli
$(call  Package/redis/Default)
  TITLE:=Redis cli
  DEPENDS+=+libatomic
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
  BUILDONLY:=1
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
	$(SED) "s|^dir .*|dir /opt/var/lib/redis|" $(1)/opt/etc/redis.conf
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
