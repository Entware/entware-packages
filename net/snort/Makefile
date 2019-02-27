#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=snort
PKG_VERSION:=2.9.11.1
PKG_RELEASE:=7

PKG_LICENSE:=GPL-2.0
PKG_MAINTAINER:=W. Michael Petullo <mike@flyn.org>

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://www.snort.org/downloads/snort/ \
	@SF/$(PKG_NAME)
PKG_HASH:=9f6b3aeac5a109f55504bd370564ac431cb1773507929dc461626898f33f46cd

PKG_BUILD_DEPENDS:=libtirpc
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_NAME)-$(PKG_VERSION)
PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/snort
  SUBMENU:=Firewall
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libdaq +libdnet +libnghttp2 +libopenssl +libpcap +libpcre +libpthread +libuuid +zlib +SNORT_LZMA:liblzma
  TITLE:=Lightweight Network Intrusion Detection System
  URL:=http://www.snort.org/
  MENU:=1
endef

define Package/snort/description
  Snort is an open source network intrusion detection and prevention system.
  It is capable of performing real-time traffic analysis, alerting, blocking
  and packet logging on IP networks.  It utilizes a combination of protocol
  analysis and pattern matching in order to detect anomalies, misuse and
  attacks.
endef

define Package/snort/config
	source "$(SOURCE)/Config.in"
endef

CONFIGURE_ARGS += \
	--prefix="/opt" \
	--enable-flexresp \
	--with-dnet-includes="$(STAGING_DIR)/opt/include" \
	--with-dnet-libraries="$(STAGING_DIR)/opt/lib" \
	--with-libpcap-includes="$(STAGING_DIR)/opt/include" \
	--with-libpcap-libraries="$(STAGING_DIR)/opt/lib" \
	--with-libpcre-includes="$(STAGING_DIR)/opt/include" \
	--with-libpcre-libraries="$(STAGING_DIR)/opt/lib" \
	--with-daq-includes="$(STAGING_DIR)/opt/include" \
	--with-daq-libraries="$(STAGING_DIR)/opt/lib" \
	--disable-static-daq

ifeq ($(CONFIG_SNORT_LZMA),)
CONFIGURE_ARGS += \
	--disable-lzma
endif

CONFIGURE_VARS += \
	PATH="$(STAGING_DIR)/opt/lib/libnet-1.0.x/bin:$$$$PATH"

MAKE_FLAGS += \
	extra_incl=""
	
TARGET_CFLAGS += -I$(STAGING_DIR)/opt/include/tirpc

define Build/InstallDev
	$(INSTALL_DIR) $(STAGING_DIR)/opt/include/snort/dynamic_preproc
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/include/snort/dynamic_preproc/* \
		$(STAGING_DIR)/opt/include/snort/dynamic_preproc/
	$(INSTALL_DIR) $(STAGING_DIR)/opt/lib/snort/dynamic_preproc
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/snort/dynamic_preproc/* \
		$(STAGING_DIR)/opt/lib/snort/dynamic_preproc/
	$(INSTALL_DIR) $(STAGING_DIR)/opt/lib/snort_dynamicengine
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/snort_dynamicengine/* \
		$(STAGING_DIR)/opt/lib/snort_dynamicengine/
	$(INSTALL_DIR) $(STAGING_DIR)/opt/lib/snort_dynamicpreprocessor
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/snort_dynamicpreprocessor/* \
		$(STAGING_DIR)/opt/lib/snort_dynamicpreprocessor/
endef

define Package/snort/conffiles
/opt/etc/config/snort
/opt/etc/snort/snort.conf
endef

define Package/snort/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/opt/bin/snort  \
		$(1)/opt/bin/snort

	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/opt/bin/u2{boat,spewfoo} \
		$(1)/opt/bin

	$(INSTALL_DIR) $(1)/opt/lib/snort_dynamicengine
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/snort_dynamicengine/libsf_engine.so* \
		$(1)/opt/lib/snort_dynamicengine/

	$(INSTALL_DIR) $(1)/opt/lib/snort_dynamicpreprocessor
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/snort_dynamicpreprocessor/libsf*.so* \
		$(1)/opt/lib/snort_dynamicpreprocessor/

	$(INSTALL_DIR) $(1)/opt/etc/snort
	$(INSTALL_CONF) \
		$(PKG_BUILD_DIR)/etc/snort.conf \
		$(1)/opt/etc/snort/
	$(SED) 's,/usr/local/lib/,/opt/lib/,g' \
		$(1)/opt/etc/snort/snort.conf
	$(INSTALL_CONF) \
		$(PKG_BUILD_DIR)/etc/attribute_table.dtd \
		$(1)/opt/etc/snort/
	$(INSTALL_CONF) \
		$(PKG_BUILD_DIR)/etc/classification.config \
		$(1)/opt/etc/snort/
	$(INSTALL_CONF) \
		$(PKG_BUILD_DIR)/etc/gen-msg.map \
		$(1)/opt/etc/snort/
	$(INSTALL_CONF) \
			$(PKG_BUILD_DIR)/etc/reference.config \
			$(1)/opt/etc/snort/
	$(INSTALL_CONF) \
		$(PKG_BUILD_DIR)/etc/unicode.map \
		$(1)/opt/etc/snort/

	$(INSTALL_DIR) $(1)/opt/etc/snort/preproc_rules
	$(INSTALL_CONF) \
		$(PKG_BUILD_DIR)/preproc_rules/*.rules \
		$(1)/opt/etc/snort/preproc_rules/
endef

$(eval $(call BuildPackage,snort))

