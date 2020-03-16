include $(TOPDIR)/rules.mk

PKG_NAME:=tunsafe
PKG_VERSION:=1.5rc2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/TunSafe/TunSafe.git
PKG_SOURCE_DATE:=2018-12-17
PKG_SOURCE_VERSION:=85a871c1d226956df7c1308a1e5527556fe35fe1
PKG_MIRROR_HASH:=7db72774b760f9ab30bb5e8aee20973c638b4e4ee495d578e0cac26e90c15ffe

PKG_MAINTAINER:=Raif Atef <beliskner.github.3psil0N@neverbox.com>
PKG_LICENSE:=AGPL-1.0-only
PKG_LICENSE_FILES:=LICENSE.AGPL.TXT

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/tunsafe
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=VPN
  TITLE:=TunSafe
  URL:=https://www.tunsafe.com/
  DEPENDS:=@(x86_64||(arm&&!TARGET_armv5_3_2)) +librt +libstdcpp
endef

define Package/tunsafe/description
A high performance and secure VPN client that uses the WireGuard protocol. TunSafe makes 
it extremely simple to setup blazingly fast and secure VPN tunnels between Windows and Linux.
This is a user-mode implementation that also supports non-standard obfuscation and TCP mode.
endef

define Build/Compile
	if [ "$(ARCH)" == "arm" ]; then \
		cd $(PKG_BUILD_DIR) && $(TARGET_CXX) -I. -DNDEBUG -DWITH_NETWORK_BSD=1 \
			-fno-omit-frame-pointer -pthread -lrt -std=c++11 \
			$(TARGET_LDFLAGS) \
			tunsafe_amalgam.cpp \
			crypto/chacha20/chacha20-arm-linux.S \
			crypto/poly1305/poly1305-arm-linux.S \
			-o tunsafe; \
	elif [ "$(ARCH)" == "x86_64" ]; then \
		cd $(PKG_BUILD_DIR) && $(TARGET_CXX) -I. -DNDEBUG -DWITH_NETWORK_BSD=1 \
			-pthread -lrt -std=c++11 \
			$(TARGET_LDFLAGS) \
			tunsafe_amalgam.cpp \
			crypto/aesgcm/aesni_gcm-x64-linux.s \
			crypto/aesgcm/aesni-x64-linux.s \
			crypto/aesgcm/ghash-x64-linux.s \
			crypto/poly1305/poly1305-x64-linux.s \
			crypto/chacha20/chacha20-x64-linux.s \
			-o tunsafe; \
	else \
		echo "unsupported compile target: $(ARCH)"; \
		exit 1; \
	fi;
	
	cd $(PKG_BUILD_DIR) && $(STRIP) tunsafe
endef

define Build/Install
endef

define Package/tunsafe/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tunsafe $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/etc/tunsafe
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/installer/TunSafe.conf $(1)/opt/etc/tunsafe/main.conf
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S30tunsafe $(1)/opt/etc/init.d
endef

define Package/tunsafe/conffiles
/opt/etc/tunsafe/main.conf
endef

$(eval $(call BuildPackage,tunsafe))
