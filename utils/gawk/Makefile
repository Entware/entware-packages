# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gawk
PKG_VERSION:=5.2.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@GNU/gawk
PKG_HASH:=e4ddbad1c2ef10e8e815ca80208d0162d4c983e6cca16f925e8418632d639018

PKG_MAINTAINER:=Daniel Golle <daniel@makrotopia.org>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=COPYING

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/gawk
  SECTION:=utils
  CATEGORY:=Utilities
  URL:=https://www.gnu.org/software/gawk/
  TITLE:=GNU awk
  DEPENDS:=+libncursesw +libreadline
  ALTERNATIVES:=300:/opt/bin/awk:/opt/bin/gawk
endef

define Package/gawk/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/gawk $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/lib/gawk
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/gawk/* $(1)/opt/lib/gawk/
	$(INSTALL_DIR) $(1)/opt/lib/awk
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/awk/* $(1)/opt/lib/awk/
	$(INSTALL_DIR) $(1)/opt/share/awk
	$(CP) $(PKG_INSTALL_DIR)/opt/share/awk/* $(1)/opt/share/awk/
endef

$(eval $(call BuildPackage,gawk))

