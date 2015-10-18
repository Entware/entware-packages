#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=alsa-utils
PKG_VERSION:=1.0.29
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=ftp://ftp.alsa-project.org/pub/utils/ \
		http://alsa.cybermirror.org/utils/
PKG_MD5SUM:=6b289bf874c4c9a63f4b3973093dd404
PKG_INSTALL:=1
PKG_MAINTAINER:=Ted Hess <thess@kitschensync.net>

include $(INCLUDE_DIR)/package.mk

define Package/alsa-utils
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+alsa-lib +libncurses +libpthread
  TITLE:=ALSA (Advanced Linux Sound Architecture) utilities
  URL:=http://www.alsa-project.org/
endef

define Package/alsa-utils-seq
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+alsa-lib +libpthread
  TITLE:=ALSA sequencer utilities
  URL:=http://www.alsa-project.org/
endef

define Package/alsa-utils-tests
  $(call Package/alsa-utils/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=ALSA utilities test data (adds ~1.3M to image)
  DEPENDS:=+alsa-lib +libpthread
endef

define Build/Configure
	$(call Build/Configure/Default, \
		--disable-rpath \
		--disable-alsatest \
		--disable-xmlto \
		, \
		ac_cv_prog_ncurses5_config=no \
		ac_cv_prog_ncursesw5_config=no \
	)
endef

define Package/alsa-utils/install
	$(INSTALL_DIR) $(1)/opt/{s,}bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/amixer $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/alsamixer $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/aplay $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/arecord $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/alsactl $(1)/opt/sbin/

	$(INSTALL_DIR) $(1)/opt/share/alsa/init
	$(INSTALL_DATA) \
	    $(PKG_INSTALL_DIR)/opt/share/alsa/init/* \
	    $(1)/opt/share/alsa/init/
endef

define Package/alsa-utils-seq/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/aconnect $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/amidi $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/aplaymidi $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/arecordmidi $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/aseqdump $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/aseqnet $(1)/opt/bin/
endef

define Package/alsa-utils-tests/install
	$(INSTALL_DIR) $(1)/opt/{s,}bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/speaker-test $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/share/sounds/alsa
	$(INSTALL_DATA) \
	    $(PKG_INSTALL_DIR)/opt/share/sounds/alsa/* \
	    $(1)/opt/share/sounds/alsa/
endef

$(eval $(call BuildPackage,alsa-utils))
$(eval $(call BuildPackage,alsa-utils-seq))
$(eval $(call BuildPackage,alsa-utils-tests))
