#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=apinger
PKG_SOURCE_DATE:=2015-04-09
PKG_SOURCE_VERSION:=78eb328721ba1a10571c19df95acddcb5f0c17c8
PKG_RELEASE:=8

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/Jajcus/apinger
PKG_MIRROR_HASH:=00d93d46b072cd231773a542b0e7ea6f01b2f8b73f162dec0adeb4a777d1d48c

PKG_MAINTAINER:=Alex Samorukov <samm@os2.kiev.ua>
PKG_LICENSE:=GPL-2.0-only

PKG_REMOVE_FILES:=autogen.sh
PKG_FIXUP:=autoreconf

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=0

include $(INCLUDE_DIR)/package.mk

define Package/apinger
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Tool which monitors various IP devices by simple ICMP echo requests
  URL:=https://github.com/Jajcus/apinger
endef

define Package/apinger/description
	Alarm Pinger (apinger) is a little tool which monitors various IP devices by
	simple ICMP echo requests. There are various other tools, that can do this,
	but most of them are shell or perl scripts, spawning many processes, thus much
	CPU-expensive, especially when one wants continuous monitoring and fast
	response on target failure.  Alarm Pinger is a single program written in C, so
	it doesn't need much CPU power even when monitoring many targets with frequent
	probes.  Alarm Pinger supports both IPv4 and IPv6. The code have been tested
	on Linux and FreeBSD.
endef

define Package/apinger/conffiles
/opt/etc/apinger.conf
endef

CONFIGURE_ARGS += \
	--with-rrdtool=/opt/bin/rrdtool \
	--with-rrdcgi=/opt/bin/rrdcgi

define Package/apinger/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/apinger $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/apinger.conf $(1)/opt/etc/apinger.conf
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S80apinger $(1)/opt/etc/init.d/
endef

define Package/apinger-rrd
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+apinger +rrdtool1 +rrdcgi1
  TITLE:=Apinger RRD Graphs
  URL:=https://github.com/Jajcus/apinger
endef

define Package/apinger-rrd/description
	Generate RRD Graphs from Apinger Data
endef

define Package/apinger-rrd/install
	$(INSTALL_DIR) $(1)/usr/libexec/apinger/rpc
	$(INSTALL_DATA) ./files/graphs.sh $(1)/usr/libexec/apinger/rpc
endef

$(eval $(call BuildPackage,apinger))
#$(eval $(call BuildPackage,apinger-rrd))

