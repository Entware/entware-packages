#
# Copyright (C) 2016 OpenWrt.org
# Copyright (C) 2012-2016 Black Roland and contributors (https://github.com/black-roland/exOpenWrt/graphs/contributors)
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dnscrypt-proxy
PKG_VERSION:=1.7.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://download.dnscrypt.org/dnscrypt-proxy
PKG_MD5SUM:=95df7262964dc22da62f7f6f0466c50e

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

PKG_MAINTAINER:=Damiano Renfer <damiano.renfer@gmail.com>
PKG_LICENSE:=ISC

include $(INCLUDE_DIR)/package.mk

define Package/dnscrypt-proxy/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  URL:=http://dnscrypt.org/
  MAINTAINER:=Damiano Renfer <damiano.renfer@gmail.com>
endef

define Package/dnscrypt-proxy
  $(call Package/dnscrypt-proxy/Default)
  DEPENDS:=+libsodium +dnscrypt-proxy-resolvers
  TITLE:=A tool for securing communications between a client and a DNS resolver
endef

define Package/dnscrypt-proxy/description
  dnscrypt-proxy provides local service which can be used directly as your
  local resolver or as a DNS forwarder, encrypting and authenticating requests
  using the DNSCrypt protocol and passing them to an upstream server.
  The DNSCrypt protocol uses high-speed high-security elliptic-curve cryptography
  and is very similar to DNSCurve, but focuses on securing communications between
  a client and its first-level resolver.
endef

define Package/dnscrypt-proxy-resolvers
  $(call Package/dnscrypt-proxy/Default)
  TITLE:=Package with current list of dnscrypt-proxy resolvers
  VERSION:=$(PKG_VERSION)+git-20160829-65a9553-$(PKG_RELEASE)
endef

define Package/dnscrypt-proxy-resolvers/description
  Package with current list of dnscrypt-proxy resolvers.
endef

define Package/hostip
  $(call Package/dnscrypt-proxy/Default)
  DEPENDS:=+libsodium
  TITLE:=Resolver to IPv4 or IPv6 addresses
endef

define Package/hostip/description
  The DNSCrypt proxy ships with a simple tool named hostip that resolves a name
  to IPv4 or IPv6 addresses.
endef

define Build/Configure
	$(call Build/Configure/Default, \
	--prefix=/opt \
	--disable-ssp \
	--disable-plugins \
	)
endef

TARGET_CFLAGS += \
	-fomit-frame-pointer \
	-fdata-sections \
	-ffunction-sections

TARGET_LDFLAGS += \
	-Wl,-gc-sections

MAKE_FLAGS += \
	CFLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)"

define Package/dnscrypt-proxy/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(CP) $(PKG_INSTALL_DIR)/opt/sbin/dnscrypt-proxy $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S09dnscrypt-proxy $(1)/opt/etc/init.d/
endef

define Package/dnscrypt-proxy-resolvers/install
	$(INSTALL_DIR) $(1)/opt/share/dnscrypt-proxy
	$(CP) ./files/dnscrypt-resolvers.csv $(1)/opt/share/dnscrypt-proxy/
endef

define Package/dnscrypt-proxy/postinst
#!/bin/sh

[ -z "$$(which grep)" ] && exit 0
[ -z "$$(which awk)" ] && exit 0

echo "By default, dnscrypt-proxy will use the OpenDNS dnscrypt server."
echo "You may choose another one if you wish:"

SRVLIST=/opt/share/dnscrypt-proxy/dnscrypt-resolvers.csv
i=0
for serv in $$(cat $$SRVLIST | awk -F "," "{print \$$1}")
do
    fullname=$$(grep "^$$serv," $$SRVLIST | awk -F "," "{print \$$2}" )
    if [ ! $$i -eq 0 ]
    then
        echo "$$i) $$serv ($$fullname)"
    fi
    i=`expr $$i + 1`
done
read -p "Choose server from list or hit Enter to continue [1-`expr $$i - 1`]: " OPTION
[ -z "$$OPTION" ] && exit 0
srv=none
i=0
for serv in $$(cat $$SRVLIST | awk -F "," "{print \$$1}")
do
    if [ ! $$i -eq 0 ] && [ $$i -eq $$OPTION ]
    then
        srv=$$serv
        break
    fi
    i=`expr $$i + 1`
done
[ "$$srv" == "none" ] && exit 0
SCRIPT=/opt/etc/init.d/S09dnscrypt-proxy
cat > $$SCRIPT << EOF
#!/bin/sh

ENABLED=yes
PROCS=dnscrypt-proxy
ARGS="--local-address=127.0.0.1:65053 --daemonize -R $$srv"
PREARGS=""
DESC=$$PROCS
PATH=/opt/sbin:/opt/bin:/opt/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

. /opt/etc/init.d/rc.func

EOF
chmod +x $$SCRIPT
endef

define Package/hostip/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/hostip $(1)/opt/bin/
endef

$(eval $(call BuildPackage,dnscrypt-proxy))
$(eval $(call BuildPackage,dnscrypt-proxy-resolvers))
$(eval $(call BuildPackage,hostip))
