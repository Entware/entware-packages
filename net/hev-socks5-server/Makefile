include $(TOPDIR)/rules.mk

PKG_NAME:=hev-socks5-server
PKG_VERSION:=2.11.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/heiher/hev-socks5-server/releases/download/$(PKG_VERSION)
PKG_HASH:=fc340c50b93eed52c1985c6d78add4e5b697a020684b03aa32dcd7d38a40dfa7

PKG_MAINTAINER:=Ray Wang <git@hev.cc>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=License

PKG_BUILD_FLAGS:=no-mips16
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/hev-socks5-server
  SECTION:=net
  CATEGORY:=Network
  TITLE:=A high-performance socks5 server for Unix
  URL:=https://github.com/heiher/hev-socks5-server
endef

define Package/hev-socks5-server/conffiles
/opt/etc/hev-socks5-server/
endef

define Package/hev-socks5-server/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/hev-socks5-server $(1)/opt/bin/

	$(INSTALL_DIR) $(1)/opt/etc/hev-socks5-server/
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/conf/main.yml $(1)/opt/etc/hev-socks5-server/main.yml
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/conf/auth.txt $(1)/opt/etc/hev-socks5-server/auth.txt

#	$(INSTALL_DIR) $(1)/etc/config/
#	$(INSTALL_CONF) ./files/hev-socks5-server.config $(1)/etc/config/hev-socks5-server

	$(INSTALL_DIR) $(1)/opt/etc/init.d/
	$(INSTALL_BIN) ./files/S99hev-socks5-server $(1)/opt/etc/init.d/
endef

$(eval $(call BuildPackage,hev-socks5-server))
