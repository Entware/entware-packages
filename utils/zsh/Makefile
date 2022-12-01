#
# Copyright (C) 2013-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=zsh
PKG_VERSION:=5.9
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@SF/zsh
PKG_HASH:=9b8d1ecedd5b5e81fbf1918e876752a7dd948e05c1a0dba10ab863842d45acd5

PKG_MAINTAINER:=Vadim A. Misbakh-Soloviov <openwrt-zsh@mva.name>
PKG_LICENSE:=ZSH
PKG_LICENSE_FILES:=LICENCE
PKG_CPE_ID:=cpe:/a:zsh_project:zsh

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/zsh
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Shells
  TITLE:=The Z shell
  DEPENDS:=+libcap +libncurses +libncursesw +libpcre +librt
  URL:=https://www.zsh.org/
endef

define Package/zsh/description
        Zsh is a UNIX command interpreter (shell) usable as an interactive
        login  shell  and  as a shell script command processor. Of the standard
        shells, zsh most closely resembles ksh but includes many enhancements.
        Zsh has command line editing, builtin spelling correction, programmable
        command completion, shell functions (with autoloading), a history
        mechanism, and a host of other features.
endef

define Build/Configure
	$(call Build/Configure/Default, \
		--bindir=/opt/bin \
		--enable-etcdir=/opt/etc \
		--disable-gdbm \
		--enable-dynamic \
		--enable-pcre \
		--enable-cap \
		--enable-multibyte \
		--enable-unicode9 \
		--enable-runhelpdir=/opt/share/zsh/$(PKG_VERSION)/help \
		--enable-fndir=/opt/share/zsh/$(PKG_VERSION)/functions \
		--enable-site-fndir=/opt/share/zsh/site-functions \
		--enable-function-subdirs \
		--with-tcsetpgrp \
		--with-term-lib="ncursesw", \
		zsh_cv_shared_environ=yes \
		zsh_cv_sys_dynamic_clash_ok=yes\
		zsh_cv_sys_dynamic_execsyms=yes \
		zsh_cv_sys_dynamic_rtld_global=yes \
		zsh_cv_sys_dynamic_strip_exe=yes \
		zsh_cv_sys_dynamic_strip_lib=yes \
		zsh_cv_sys_nis=no \
		zsh_cv_sys_nis_plus=no \
	)
	# Do not install these functions:
	$(SED) 's, Completion/AIX/\*/\*,,g' $(PKG_BUILD_DIR)/config.modules
	$(SED) 's, Completion/BSD/\*/\*,,g' $(PKG_BUILD_DIR)/config.modules
	$(SED) 's, Completion/Cygwin/\*/\*,,g' $(PKG_BUILD_DIR)/config.modules
	$(SED) 's, Completion/Darwin/\*/\*,,g' $(PKG_BUILD_DIR)/config.modules
	$(SED) 's, Completion/Debian/\*/\*,,g' $(PKG_BUILD_DIR)/config.modules
	$(SED) 's, Completion/Mandriva/\*/\*,,g' $(PKG_BUILD_DIR)/config.modules
	$(SED) 's, Completion/Redhat/\*/\*,,g' $(PKG_BUILD_DIR)/config.modules
	$(SED) 's, Completion/Solaris/\*/\*,,g' $(PKG_BUILD_DIR)/config.modules
	$(SED) 's, Completion/X/\*/\*,,g' $(PKG_BUILD_DIR)/config.modules
	$(SED) 's, Completion/openSUSE/\*/\*,,g' $(PKG_BUILD_DIR)/config.modules
	# After mucking with 'config.modules', one must call
	$(MAKE) -C $(PKG_BUILD_DIR) DESTDIR="$(PKG_INSTALL_DIR)" prep
endef

TARGET_CFLAGS += $(FPIC) -ffunction-sections -fdata-sections -flto
TARGET_LDFLAGS += $(FPIC) -Wl,--gc-sections -flto

define Package/zsh/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/share/zsh/$(PKG_VERSION)
	$(INSTALL_DIR) $(1)/opt/lib/zsh/$(PKG_VERSION)/zsh
	$(INSTALL_DIR) $(1)/opt/lib/zsh/$(PKG_VERSION)/zsh/net
	$(INSTALL_DIR) $(1)/opt/lib/zsh/$(PKG_VERSION)/zsh/param

	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/zsh $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/share/zsh/$(PKG_VERSION)/* $(1)/opt/share/zsh/$(PKG_VERSION)/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/zsh/$(PKG_VERSION)/zsh/* $(1)/opt/lib/zsh/$(PKG_VERSION)/zsh/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/zsh/$(PKG_VERSION)/zsh/net/* $(1)/opt/lib/zsh/$(PKG_VERSION)/zsh/net/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/zsh/$(PKG_VERSION)/zsh/param/* $(1)/opt/lib/zsh/$(PKG_VERSION)/zsh/param/
	# XXX Entware specific: fix exec path in scripts
	$(FIND) $(1)/opt/share/zsh/$(PKG_VERSION)/functions -type f | \
		$(XARGS) $(SED) 's,^#!.*zsh,#!/opt/bin/zsh,'
endef

$(eval $(call BuildPackage,zsh))
