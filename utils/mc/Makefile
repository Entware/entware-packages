#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Switched from ncurses to slang to support broken terminals

include $(TOPDIR)/rules.mk

PKG_NAME:=mc
PKG_VERSION:=4.8.21
PKG_RELEASE:=4
PKG_MAINTAINER:=Dirk Brenken <dev@brenken.org>
PKG_LICENSE:=GPL-3.0+

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=http://ftp.midnight-commander.org/
PKG_HASH:=8f37e546ac7c31c9c203a03b1c1d6cb2d2f623a300b86badfd367e5559fe148c
PKG_BUILD_PARALLEL:=1
PKG_FIXUP:=autoreconf gettext-version
PKG_BUILD_DEPENDS:=MC_VFS:libtirpc

PKG_INSTALL:=1

PKG_CONFIG_DEPENDS := \
	CONFIG_PACKAGE_MC \
	CONFIG_MC_DIFFVIEWER \
	CONFIG_MC_EDITOR \
	CONFIG_MC_SUBSHELL \
	CONFIG_MC_LARGEFILE \
	CONFIG_MC_BACKGROUND \
	CONFIG_MC_CHARSET \
	CONFIG_MC_VFS

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/mc
	SECTION:=utils
	CATEGORY:=Utilities
	DEPENDS:=+glib2 +libslang2 +libmount +MC_VFS:libssh2 $(ICONV_DEPENDS)
	TITLE:=Midnight Commander - a powerful visual file manager
	URL:=https://www.midnight-commander.org/
	MENU:=1
endef

define Package/mc/config
	source "$(SOURCE)/Config.in"
endef

define Package/mc/description
GNU Midnight Commander is a visual file manager.
It's a feature rich full-screen text mode application that allows you to copy,
move and delete files and whole directory trees, search for files and run commands in the subshell.
Internal viewer and editor are included as well.

endef

CONFIGURE_ARGS += \
	--disable-doxygen-doc \
	--with-homedir=/opt/etc/mc \
	--with-screen=slang \
	--without-x \
	--with-slang-includes="$(STAGING_DIR)/opt/include" \
	--with-slang-libs="$(STAGING_DIR)/opt/lib" \
	--with-search-engine=glib \

CONFIGURE_VARS += \
	ac_cv_search_addwstr=no \
	fu_cv_sys_stat_statfs2_bsize=yes \
	ac_cv_path_GREP=grep \

ifeq ($(CONFIG_MC_DIFFVIEWER),)
CONFIGURE_ARGS += --without-diff-viewer
endif

ifeq ($(CONFIG_MC_EDITOR),)
CONFIGURE_ARGS += --without-internal-edit
endif

ifeq ($(CONFIG_MC_SUBSHELL),)
CONFIGURE_ARGS += --without-subshell
endif

ifeq ($(CONFIG_MC_LARGEFILE),)
CONFIGURE_ARGS += --disable-largefile
endif

ifeq ($(CONFIG_MC_BACKGROUND),)
CONFIGURE_ARGS += --disable-background
endif

ifeq ($(CONFIG_MC_CHARSET),)
CONFIGURE_ARGS += --disable-charset
endif

ifeq ($(CONFIG_MC_VFS),)
CONFIGURE_ARGS += --disable-vfs
else
TARGET_CPPFLAGS += -I$(STAGING_DIR)/opt/include/tirpc
endif

define Package/mc/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/mc $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/mc
ifeq ($(CONFIG_MC_DIFFVIEWER),y)
	ln -sf mc $(1)/opt/bin/mcdiff
endif
ifeq ($(CONFIG_MC_EDITOR),y)
	ln -sf mc $(1)/opt/bin/mcedit
endif
	$(CP) $(PKG_INSTALL_DIR)/opt/etc/mc/* $(1)/opt/etc/mc/
	$(INSTALL_DIR) $(1)/opt/lib $(1)/opt/lib/mc $(1)/opt/lib/mc/extfs.d $(1)/opt/lib/mc/fish
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/mc/* $(1)/opt/lib/mc/
	$(INSTALL_DIR) $(1)/opt/share $(1)/opt/share/mc $(1)/opt/share/mc/help $(1)/opt/share/mc/skins $(1)/opt/share/mc/hints $(1)/opt/share/mc/syntax
	$(CP) $(PKG_INSTALL_DIR)/opt/share/mc/* $(1)/opt/share/mc/
	$(SED) 's,$(STAGING_DIR_HOST)/bin,/opt/bin,g' $(1)/opt/lib/mc/ext.d/*
	$(SED) 's,$(STAGING_DIR_HOSTPKG)/bin,/opt/bin,g' $(1)/opt/lib/mc/ext.d/*
	$(SED) 's,$(STAGING_DIR_HOST)/bin,/opt/bin,g' $(1)/opt/lib/mc/extfs.d/*
	$(SED) 's,$(STAGING_DIR_HOSTPKG)/bin,/opt/bin,g' $(1)/opt/lib/mc/extfs.d/*
	$(SED) 's,$(STAGING_DIR_HOST)/bin,/opt/bin,g' $(1)/opt/share/mc/syntax/Syntax
	$(SED) 's,$(STAGING_DIR_HOSTPKG)/bin,/opt/bin,g' $(1)/opt/share/mc/syntax/Syntax
endef

define Package/mc/conffiles
/opt/etc/mc/mc.keymap
/opt/etc/mc/mc.menu
/opt/etc/mc/skins/default.ini
endef

$(eval $(call BuildPackage,mc))
