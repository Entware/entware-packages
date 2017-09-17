#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=icecast
PKG_VERSION:=2.4.3
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://downloads.xiph.org/releases/icecast/
PKG_HASH:=c85ca48c765d61007573ee1406a797ae6cb31fb5961a42e7f1c87adb45ddc592

PKG_MAINTAINER:=André Gaul <andre@gaul.io>, \
		Ted Hess <thess@kitschensync.net>

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING

PKG_FIXUP:=autoreconf
PKG_INSTALL:= 1

include $(INCLUDE_DIR)/package.mk

define Package/icecast
  SECTION:=multimedia
  CATEGORY:=Multimedia
  DEPENDS:=+libcurl +libxml2 +libxslt +libogg +libvorbisidec
  TITLE:=A streaming media server for Ogg/Vorbis and MP3 audio streams
  USERID:=icecast=87:icecast=87
  URL:=http://www.icecast.org/
endef

define Package/icecast/description
	Icecast is a streaming media server which currently supports Ogg
	Vorbis and MP3 audio streams. It can be used to create an Internet
	radio station or a privately running jukebox and many things in
	between. It is very versatile in that new formats can be added
	relatively easily and supports open standards for commuincation and
	interaction.
endef

CONFIGURE_ARGS+= \
	--enable-yp \
	--with-openssl="no" \
	--with-curl="yes" \
	--with-curl-config="$(STAGING_DIR)/opt/bin/curl-config" \
	--with-ogg="$(STAGING_DIR)/opt" \
	--with-speex="no" \
	--with-theora="no" \
	--with-vorbis="$(STAGING_DIR)/opt" \
	--with-xslt-config="$(STAGING_DIR)/opt/bin/xslt-config"


# Manually edit configure in case both vorbis and tremor host packages are installed
define Build/Configure
	$(SED) 's,-lvorbis -lm,-lvorbisidec -logg ,g' $(PKG_BUILD_DIR)/configure
	$(call Build/Configure/Default)
endef

define Package/icecast/install
	$(INSTALL_DIR) $(1)/opt/etc
	$(CP) $(PKG_INSTALL_DIR)/opt/etc/icecast.xml $(1)/opt/etc/
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S78icecast $(1)/opt/etc/init.d/
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/icecast $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/share/icecast
	$(CP) $(PKG_INSTALL_DIR)/opt/share/icecast/admin $(1)/opt/share/icecast/
	$(CP) $(PKG_INSTALL_DIR)/opt/share/icecast/web $(1)/opt/share/icecast/
endef

define Package/icecast/conffiles
/opt/etc/icecast.xml
endef

$(eval $(call BuildPackage,icecast))
