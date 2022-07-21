#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libmpdclient
PKG_VERSION:=2.20
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://www.musicpd.org/download/libmpdclient/2
PKG_HASH:=18793f68e939c3301e34d8fcadea1f7daa24143941263cecadb80126194e277d

PKG_MAINTAINER:=Ted Hess <thess@kitschensync.net>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/meson.mk

define Package/libmpdclient
    TITLE:=libmpdclient
    SECTION:=libs
    CATEGORY:=Libraries
    URL:=https://musicpd.org/libs/libmpdclient/
endef

define Package/libmpdclient/description
    A stable, documented, asynchronous API library for interfacing MPD in the C, C++ & Objective C languages.
endef

MESON_ARGS+=-Ddocumentation=false

define Build/InstallDev
	$(INSTALL_DIR) \
		$(1)/opt/include \
		$(1)/opt/lib \
		$(1)/opt/lib/pkgconfig
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/* \
		$(1)/opt/lib/
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/include/* \
		$(1)/opt/include/
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/pkgconfig \
		$(1)/opt/lib/
endef

define Package/libmpdclient/install
	$(INSTALL_DIR) \
		$(1)/opt/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/libmpdclient.so* \
		$(1)/opt/lib/
endef

$(eval $(call BuildPackage,libmpdclient))
