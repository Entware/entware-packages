#
# Copyright (C) 2014-2021 CZ.NIC, z.s.p.o. <knot-dns@labs.nic.cz>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=knot
PKG_VERSION:=3.2.5
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://secure.nic.cz/files/knot-dns/
PKG_HASH:=c6b122e92baa179d09ba4c8ce5b0d42fb7475805f4ff9c81d5036acfaa161820

PKG_MAINTAINER:=Daniel Salzman <daniel.salzman@nic.cz>
PKG_LICENSE:=GPL-3.0 LGPL-2.0 0BSD BSD-3-Clause OLDAP-2.8
PKG_CPE_ID:=cpe:/a:knot-dns:knot_dns

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/knot-lib/Default
	SECTION:=libs
	CATEGORY:=Libraries
	TITLE:=Knot DNS
	DEPENDS=+libpthread
	URL:=https://www.knot-dns.cz
endef

define Package/knot/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=IP Addresses and Names
	TITLE:=Knot DNS
	DEPENDS=+libatomic
	URL:=https://www.knot-dns.cz
endef

define Package/knot-libs
	$(call Package/knot-lib/Default)
	TITLE+= common DNS and DNSSEC libraries
	DEPENDS+=+libgnutls +lmdb @!arc
endef

define Package/knot-libzscanner
	$(call Package/knot-lib/Default)
	TITLE+= zone parser library
	DEPENDS+=@!arc
endef

define Package/knot
	$(call Package/knot/Default)
	TITLE+= server with control utility
	DEPENDS+=+libedit +liburcu +knot-libs +knot-libzscanner
	EXTRA_DEPENDS:=knot-libs (=$(PKG_VERSION)-$(PKG_RELEASE)), \
	               knot-libzscanner (=$(PKG_VERSION)-$(PKG_RELEASE))
	USERID:=knot=5353:knot=5353
endef

define Package/knot-dig
	$(call Package/knot/Default)
	TITLE+= advanced DNS lookup utility
	DEPENDS+=+libedit +knot-libs
	EXTRA_DEPENDS:=knot-libs (=$(PKG_VERSION)-$(PKG_RELEASE))
endef

define Package/knot-host
	$(call Package/knot/Default)
	TITLE+= simple DNS lookup utility
	DEPENDS+=+libedit +knot-libs
	EXTRA_DEPENDS:=knot-libs (=$(PKG_VERSION)-$(PKG_RELEASE))
endef

define Package/knot-nsupdate
	$(call Package/knot/Default)
	TITLE+= dynamic DNS update utility
	DEPENDS+=+libedit +knot-libs +knot-libzscanner
	EXTRA_DEPENDS:=knot-libs (=$(PKG_VERSION)-$(PKG_RELEASE)), \
	               knot-libzscanner (=$(PKG_VERSION)-$(PKG_RELEASE))
endef

define Package/knot-zonecheck
	$(call Package/knot/Default)
	TITLE+= zonefile check utility
	DEPENDS+=+libedit +liburcu +knot-libs +knot-libzscanner
	EXTRA_DEPENDS:=knot-libs (=$(PKG_VERSION)-$(PKG_RELEASE)), \
	               knot-libzscanner (=$(PKG_VERSION)-$(PKG_RELEASE))
endef

define Package/knot-keymgr
	$(call Package/knot/Default)
	TITLE+= DNSSEC key management utility
	DEPENDS+=+libedit +liburcu +knot-libs +knot-libzscanner
	EXTRA_DEPENDS:=knot-libs (=$(PKG_VERSION)-$(PKG_RELEASE)), \
	               knot-libzscanner (=$(PKG_VERSION)-$(PKG_RELEASE))
endef

define Package/knot-tests
	$(call Package/knot/Default)
	TITLE+= tests
	DEPENDS+=+libedit +liburcu +knot-libs +knot-libzscanner
	EXTRA_DEPENDS:=knot-libs (=$(PKG_VERSION)-$(PKG_RELEASE)), \
	               knot-libzscanner (=$(PKG_VERSION)-$(PKG_RELEASE))
endef

define Package/knot-libs/description
	Knot DNS common DNS and DNSSEC libraries.
endef

define Package/knot-libzscanner/description
	Knot DNS zone parser library.
endef

define Package/knot/description
	High-performance authoritative-only DNS server.
endef

define Package/knot-dig/description
	Knot DNS advanced DNS lookup utility.
endef

define Package/knot-host/description
	Knot DNS simple DNS lookup utility.
endef

define Package/knot-nsupdate/description
	Knot DNS dynamic DNS update utility.
endef

define Package/knot-zonecheck/description
	Knot DNS zonefile check utility.
endef

define Package/knot-keymgr/description
	Knot DNS DNSSEC key management utility.
endef

define Package/knot-tests/description
	Unit tests for the Knot DNS server and libraries.
	Usage: /opt/share/knot/runtests.sh
endef

export KNOT_VERSION_FORMAT=release

CONFIGURE_ARGS += 			\
	--enable-recvmmsg=no		\
	--enable-cap-ng=no            	\
	--enable-xdp=no                 \
	--enable-maxminddb=no		\
	--disable-fastparser		\
	--without-libidn		\
	--with-libnghttp2=no		\
	--with-rundir=/opt/var/run/knot	\
	--with-storage=/opt/var/lib/knot	\
	--with-configdir=/opt/etc/knot	\
	--with-conf-mapsize=20

TARGET_CFLAGS += -DNDEBUG

define Package/knot/conffiles
/opt/etc/knot/knot.conf
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)
	$(MAKE) -C $(PKG_BUILD_DIR)/tests check-compile
endef

ifneq ($(CONFIG_arc),y)
define Build/InstallDev
	$(INSTALL_DIR)					$(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.{a,so*}	$(1)/opt/lib/

	$(INSTALL_DIR)						$(1)/opt/include/libknot
	$(CP) $(PKG_INSTALL_DIR)/opt/include/libknot/*		$(1)/opt/include/libknot/

	$(INSTALL_DIR)						$(1)/opt/include/libdnssec
	$(CP) $(PKG_INSTALL_DIR)/opt/include/libdnssec/*	$(1)/opt/include/libdnssec/

	$(INSTALL_DIR)						$(1)/opt/include/libzscanner
	$(CP) $(PKG_INSTALL_DIR)/opt/include/libzscanner/*	$(1)/opt/include/libzscanner/

	$(INSTALL_DIR)							$(1)/opt/lib/pkgconfig
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/*.pc	$(1)/opt/lib/pkgconfig/
endef
endif

define Package/knot-libs/install
	$(INSTALL_DIR) 						$(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libdnssec.so.*		$(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libknot.so.*		$(1)/opt/lib/
endef

define Package/knot-libzscanner/install
	$(INSTALL_DIR) 						$(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libzscanner.so.*	$(1)/opt/lib/
endef

define Package/knot/install
	$(INSTALL_DIR) 						$(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/knotc	$(1)/opt/bin/
	$(INSTALL_DIR) 						$(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/knotd	$(1)/opt/sbin/

	$(INSTALL_DIR) 							$(1)/opt/etc/knot
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/knot/knot.sample.conf	$(1)/opt/etc/knot/knot.conf

#	$(INSTALL_DIR)				$(1)/etc/init.d
#	$(INSTALL_BIN) ./files/knotd.init	$(1)/etc/init.d/knotd
endef

define Package/knot-dig/install
	$(INSTALL_DIR)						$(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/kdig		$(1)/opt/bin/
endef

define Package/knot-host/install
	$(INSTALL_DIR)						$(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/khost		$(1)/opt/bin/
endef

define Package/knot-nsupdate/install
	$(INSTALL_DIR)						$(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/knsupdate	$(1)/opt/bin/
endef

define Package/knot-zonecheck/install
	$(INSTALL_DIR)						$(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/kzonecheck	$(1)/opt/bin/
endef

define Package/knot-keymgr/install
	$(INSTALL_DIR)						$(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/keymgr	$(1)/opt/bin/
endef

define Package/knot-tests/install
	$(INSTALL_DIR) 						$(1)/opt/share/knot
	$(INSTALL_BIN) ./files/runtests.sh			$(1)/opt/share/knot/

	$(INSTALL_DIR) 							$(1)/opt/share/knot/tap
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tests/tap/.libs/runtests	$(1)/opt/share/knot/tap/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tests/tap/libtap.sh		$(1)/opt/share/knot/tap/

	$(INSTALL_DIR)								$(1)/opt/share/knot/tests

	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tests/libzscanner/.libs/zscanner-tool	$(1)/opt/share/knot/tests/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tests/libzscanner/test_zscanner		$(1)/opt/share/knot/tests/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/tests/libzscanner/TESTS		$(1)/opt/share/knot/tests/
	cp -a $(PKG_BUILD_DIR)/tests/libzscanner/data				$(1)/opt/share/knot/tests/

	for module in contrib knot libdnssec libknot modules utils; do \
		find $(PKG_BUILD_DIR)/tests/$$$${module}/.libs -maxdepth 1 -executable -type f | \
			xargs -I{} basename {} | \
			xargs -I{} $(INSTALL_BIN) -T $(PKG_BUILD_DIR)/tests/$$$${module}/.libs/{} \
										$(1)/opt/share/knot/tests/$$$${module}_{}; \
	done
endef

$(eval $(call BuildPackage,knot-libs))
$(eval $(call BuildPackage,knot-libzscanner))
$(eval $(call BuildPackage,knot))
$(eval $(call BuildPackage,knot-dig))
$(eval $(call BuildPackage,knot-host))
$(eval $(call BuildPackage,knot-nsupdate))
$(eval $(call BuildPackage,knot-zonecheck))
$(eval $(call BuildPackage,knot-keymgr))
$(eval $(call BuildPackage,knot-tests))
