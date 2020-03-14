include $(TOPDIR)/rules.mk

PKG_NAME:=expect
PKG_VERSION:=5.45.4
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/expect
PKG_HASH:=49a7da83b0bdd9f46d04a04deec19c7767bb9a323e40c4781f89caf760b92c34
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)$(PKG_VERSION)

PKG_MAINTAINER:=Raif Atef <beliskner.github.3psil0N@neverbox.com>
PKG_LICENSE:=Unlicense
PKG_LICENSE_FILES:=README

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/expect
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Expect
  DEPENDS:=+tcl
  URL:=https://www.nist.gov/services-resources/software/expect
endef

define Package/expect/description
Expect is a tool for automating interactive applications such as telnet, ftp, passwd,
fsck, rlogin, tip, etc. Expect really makes this stuff trivial. Expect is also useful
for testing these same applications. And by adding Tk, you can wrap interactive applications
in X11 GUIs.

Expect can make easy all sorts of tasks that are prohibitively difficult with anything else.
You will find that Expect is an absolutely invaluable tool - using it, you will be able to
automate tasks that you've never even thought of before - and you'll be able to do this
automation quickly and easily.
endef

define Build/Configure
	(cd ${PKG_BUILD_DIR} && autoconf)
	$(call Build/Configure/Default)
endef

define Package/expect/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/bin

	$(INSTALL_DIR) $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/* $(1)/opt/lib
endef

CONFIGURE_ARGS+=--with-tcl=$(STAGING_DIR)/opt/lib/
MAKE_FLAGS=RANLIB=":"

$(eval $(call BuildPackage,expect))
