include $(TOPDIR)/rules.mk

PKG_NAME:=https_dns_proxy
PKG_VERSION:=2017-01-07
PKG_RELEASE=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_MIRROR_HASH:=befd075fd8175bb5322de8eeb8c7be218fd4ec255814cbf07051216f613fe2e6
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/aarond10/https_dns_proxy/
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=c62ce3f6807a4067230a8bc5ea5a829f532de785
PKG_MAINTAINER:=Aaron Drew <aarond10@gmail.com>
PKG_LICENSE:=MIT

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/https_dns_proxy
  SECTION:=net
  CATEGORY:=Network
  TITLE:=DNS over HTTPS proxy server
  DEPENDS:=+libcares +libcurl +libev +ca-certificates
endef

define Package/https_dns_proxy/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/https_dns_proxy $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S09https_dns_proxy $(1)/opt/etc/init.d/
endef

$(eval $(call BuildPackage,https_dns_proxy))
