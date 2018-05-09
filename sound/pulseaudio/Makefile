#
# Copyright (C) 2011-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pulseaudio
PKG_VERSION:=11.1
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://freedesktop.org/software/pulseaudio/releases/
PKG_HASH:=f2521c525a77166189e3cb9169f75c2ee2b82fa3fcf9476024fbc2c3a6c9cd9e
PKG_LICENSE:=LGPL-2.1+
PKG_LICENSE_FILES:=GPL LICENSE

PKG_BUILD_DEPENDS:=intltool/host

PKG_FIXUP:=autoreconf
PKG_USE_MIPS16:=0

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

PKG_INSTALL = 1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/pulseaudio/Default
  SECTION:=sound
  CATEGORY:=Sound
  DEPENDS:=+libsndfile +libltdl +libpthread +librt +alsa-lib \
	+libopenssl +libwrap +libcap $(ICONV_DEPENDS) $(INTL_DEPENDS)
  TITLE:=Network sound server
  MAINTAINER:=Peter Wagner <tripolar@gmx.at>
  URL:=http://www.pulseaudio.org
  PROVIDES:=pulseaudio
  USERID:=pulse=51:pulse=51
endef

define Package/pulseaudio-daemon
  $(call Package/pulseaudio/Default)
  VARIANT:=noavahi
endef

define Package/pulseaudio-daemon-avahi
  $(call Package/pulseaudio/Default)
  DEPENDS+=+dbus +libavahi-client +sbc
#  DEPENDS+=+avahi-daemon 
  TITLE+= (avahi/bluez)
  VARIANT:=avahi
endef

define Package/pulseaudio/Default/description
  PulseAudio (formerly Polypaudio) is a cross-platform, networked sound server.
endef

define Package/pulseaudio-daemon/description
  $(call Package/pulseaudio/Default/description)
endef

define Package/pulseaudio-daemon-avahi/description
  $(call Package/pulseaudio/Default/description)
  This package enables avahi,bluez and is compiled against dbus, sbc, and avahi.
endef

define Package/pulseaudio-daemon/conffiles
/opt/etc/pulse/client.conf
/opt/etc/pulse/daemon.conf
/opt/etc/pulse/default.pa
/opt/etc/pulse/system.pa
endef

define Package/pulseaudio-daemon-avahi/conffiles
/opt/etc/pulse/client.conf
/opt/etc/pulse/daemon.conf
/opt/etc/pulse/default.pa
/opt/etc/pulse/system.pa
endef

define Package/pulseaudio-tools
  SECTION:=sound
  CATEGORY:=Sound
  DEPENDS:=+libsndfile +pulseaudio
  TITLE:=Tools for Pulseaudio
  URL:=http://www.pulseaudio.org
  VARIANT:=noavahi
endef

define Package/pulseaudio-profiles
  SECTION:=sound
  CATEGORY:=Sound
  DEPENDS:=+pulseaudio
  TITLE:=Profiles for Pulseaudio
  URL:=http://www.pulseaudio.org
endef

CONFIGURE_ARGS += \
	$(if $(findstring neon,$(CONFIG_TARGET_OPTIMIZATION)),--enable-neon-opt,--disable-neon-opt) \
	--with-system-user=pulse \
	--with-system-group=pulse \
	--with-access-group=audio \
	--with-database=simple \
	--enable-alsa \
	--disable-hal \
	--disable-gconf \
	--disable-nls \
	--disable-manpages \
	--enable-oss-output \
	--disable-oss-wrapper \
	--disable-samplerate \
	--disable-per-user-esound-socket \
	--disable-solaris \
	--disable-gtk2 \
	--disable-glib2 \
	--disable-jack \
	--disable-asyncns \
	--disable-lirc \
	--disable-udev \
	--without-fftw \
	--without-soxr \
	--without-speex
# --disable-bluez

ifeq ($(BUILD_VARIANT),avahi)
CONFIGURE_ARGS += \
	--enable-avahi \
	--enable-dbus
endif

ifeq ($(BUILD_VARIANT),noavahi)
CONFIGURE_ARGS += \
	--disable-avahi \
	--disable-dbus
endif

CONFIGURE_VARS += \
	PKG_CONFIG_LIBDIR="$(STAGING_DIR)/opt/lib/pkgconfig"

#SUPP_LIBS:=-L$(INTL_PREFIX)/lib -L$(ICONV_PREFIX)/lib
TARGET_CFLAGS += -std=gnu99

define Build/InstallDev
	$(INSTALL_DIR) \
		$(1)/opt/lib/pkgconfig \
		$(1)/opt/include/pulse \
		$(1)/opt/lib \
		$(1)/opt/lib/pulseaudio
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/include/pulse/* \
		$(1)/opt/include/pulse
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/pkgconfig/*.pc \
		$(1)/opt/lib/pkgconfig
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/*.so* \
		$(1)/opt/lib/
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/pulseaudio/* \
		$(1)/opt/lib/pulseaudio/
endef

define Package/pulseaudio-daemon/install
	$(INSTALL_DIR) \
		$(1)/opt/etc/pulse \
		$(1)/opt/etc/init.d \
		$(1)/opt/bin \
		$(1)/opt/lib \
		$(1)/opt/lib/pulseaudio \
		$(1)/opt/lib/pulse-$(PKG_VERSION)/modules

	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/opt/bin/pulseaudio \
		$(1)/opt/bin/pulseaudio

#	$(INSTALL_BIN) \
#		./files/pulseaudio.init \
#		$(1)/etc/init.d/pulseaudio

	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/etc/pulse/* \
		$(1)/opt/etc/pulse

	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/*.so* \
		$(1)/opt/lib/

	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/pulseaudio/* \
		$(1)/opt/lib/pulseaudio/

	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/pulse-$(PKG_VERSION)/modules/lib*.so \
		$(1)/opt/lib/

	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/pulse-$(PKG_VERSION)/modules/module*.so \
		$(1)/opt/lib/pulse-$(PKG_VERSION)/modules/

endef

define Package/pulseaudio-daemon-avahi/install
	$(INSTALL_DIR) \
		$(1)/opt/etc/pulse \
		$(1)/opt/etc/init.d \
		$(1)/opt/bin \
		$(1)/opt/lib \
		$(1)/opt/lib/pulseaudio \
		$(1)/opt/lib/pulse-$(PKG_VERSION)/modules \
		$(1)/opt/etc/dbus-1/system.d

	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/opt/bin/pulseaudio \
		$(1)/opt/bin/pulseaudio

#	$(INSTALL_BIN) \
#		./files/pulseaudio.init \
#		$(1)/etc/init.d/pulseaudio

	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/etc/pulse/* \
		$(1)/opt/etc/pulse

	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/*.so* \
		$(1)/opt/lib/

	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/pulseaudio/* \
		$(1)/opt/lib/pulseaudio/

	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/pulse-$(PKG_VERSION)/modules/lib*.so \
		$(1)/opt/lib/

	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/pulse-$(PKG_VERSION)/modules/module*.so \
		$(1)/opt/lib/pulse-$(PKG_VERSION)/modules/

	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/etc/dbus-1/system.d/pulseaudio-system.conf \
		$(1)/opt/etc/dbus-1/system.d/pulseaudio-system.conf
endef

define Package/pulseaudio-tools/install
	$(INSTALL_DIR) \
		$(1)/opt/bin

	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/opt/bin/pa* \
		$(1)/opt/bin/
endef

define Package/pulseaudio-profiles/install
	$(INSTALL_DIR) \
		$(1)/opt/share/pulseaudio/alsa-mixer/paths \
		$(1)/opt/share/pulseaudio/alsa-mixer/profile-sets

	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/share/pulseaudio/alsa-mixer/paths/* \
		$(1)/opt/share/pulseaudio/alsa-mixer/paths

	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/share/pulseaudio/alsa-mixer/profile-sets/* \
		$(1)/opt/share/pulseaudio/alsa-mixer/profile-sets
endef

$(eval $(call BuildPackage,pulseaudio-daemon))
$(eval $(call BuildPackage,pulseaudio-daemon-avahi))
$(eval $(call BuildPackage,pulseaudio-tools))
$(eval $(call BuildPackage,pulseaudio-profiles))
