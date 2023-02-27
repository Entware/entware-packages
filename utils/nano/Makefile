#
# Copyright (C) 2007-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: wrapping and syntax highlight enabled

include $(TOPDIR)/rules.mk

PKG_NAME:=nano
PKG_VERSION:=7.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@GNU/nano
PKG_HASH:=86f3442768bd2873cec693f83cdf80b4b444ad3cc14760b74361474fc87a4526

PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Hannu Nyman <hannu.nyman@iki.fi>
PKG_CPE_ID:=cpe:/a:gnu:nano

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/nano/Default
  SUBMENU:=Editors
  SECTION:=utils
  CATEGORY:=Utilities
  URL:=https://www.nano-editor.org/
  DEPENDS:=+file +libncursesw +zlib
endef

define Package/nano
  $(call Package/nano/Default)
  TITLE:=GNU nano text editor (minimal features)
  VARIANT:=tiny
  DEFAULT_VARIANT:=1
endef

define Package/nano-plus
  $(call Package/nano/Default)
  TITLE:=GNU nano text editor (more features, Unicode)
  VARIANT:=plus
endef

define Package/nano-full
  $(call Package/nano/Default)
  TITLE:=GNU nano text editor (all features, Unicode)
  VARIANT:=full
endef

define Package/nano/description
  Nano is a small and simple text editor for use on the terminal.

  Nano started as an enhanced clone of the Pico text editor.
  Nowadays Nano wants to be a generally useful editor with sensible
  defaults (linewise scrolling, no automatic line breaking).

  Nano is an official GNU package.
endef

define Package/nano-plus/description
  nano-plus - Additional features enabled, larger size than default nano.
  (multibuffer, Unicode/UTF-8, help, justify, nanorc, some key bindings)

  $(call Package/nano/description)
endef

define Package/nano-full/description
  nano-full - all features, including syntax highlighting (also uci),
  multibuffer, Unicode/UTF-8, nanorc, some key bindings.
  (libmagic-based file type detection is disabled)

  Example /etc/nanorc is included. nanorc documentation at
  https://www.nano-editor.org/dist/latest/nanorc.5.html

  $(call Package/nano/description)
endef

ifeq ($(BUILD_VARIANT),full)
# full variant with almost all features included
  CONFIGURE_ARGS += \
	--enable-extra \
	--enable-libmagic \
	--enable-utf8 \
	--enable-wrapping \
	--enable-wrapping-as-root \
	--without-slang
else ifeq ($(BUILD_VARIANT),plus)
# plus variant with some features included
  CONFIGURE_ARGS += \
	--enable-help \
	--enable-linenumbers \
	--enable-multibuffer \
	--enable-nanorc \
	--enable-utf8 \
	--disable-browser \
	--disable-color \
	--disable-comment \
	--disable-extra \
	--disable-histories \
	--disable-justify \
	--disable-libmagic \
	--disable-mouse \
	--disable-operatingdir \
	--disable-speller \
	--disable-tabcomp \
	--disable-wordcomp
else
# default tiny variant
  CONFIGURE_ARGS += \
	--enable-tiny \
	--enable-linenumbers \
	--disable-color \
	--disable-utf8
endif

#CONFIGURE_VARS += \
#	ac_cv_header_regex_h=no \

define Package/nano-plus/conffiles
/opt/etc/nanorc
endef

define Package/nano-full/conffiles
/opt/etc/nanorc
endef

define Package/nano/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/$(PKG_NAME) $(1)/opt/bin/
endef

define Package/nano-plus/install
	$(call Package/nano/install,$1)
endef

define Package/nano-full/install
	$(call Package/nano/install,$1)
	$(INSTALL_DIR) $(1)/opt/etc $(1)/opt/share/nano
	$(CP) $(PKG_BUILD_DIR)/doc/sample.nanorc $(1)/opt/etc/nanorc
	$(SED) 's,# include "/opt,include "/opt,g' $(1)/opt/etc/nanorc
	$(CP) $(PKG_INSTALL_DIR)/opt/share/nano/* $(1)/opt/share/nano
	for f in $(1)/opt/share/nano/*.nanorc; do \
		$(SED) 's/\\</\\b/g' $$$$f; \
		$(SED) 's/\\>/\\b/g' $$$$f; \
	done;
endef

$(eval $(call BuildPackage,nano))
$(eval $(call BuildPackage,nano-plus))
$(eval $(call BuildPackage,nano-full))

