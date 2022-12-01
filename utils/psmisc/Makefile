# XXX Entware specific: added our patches, autoreconf

include $(TOPDIR)/rules.mk

PKG_NAME:=psmisc
PKG_VERSION:=23.4
PKG_RELEASE:=2a

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@SF/psmisc
PKG_HASH:=7f0cceeace2050c525f3ebb35f3ba01d618b8d690620580bdb8cd8269a0c1679

PKG_MAINTAINER:=Josef Schlehofer <pepe.schlehofer@gmail.com>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING

PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/psmisc
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=proc utilities
  URL:=https://gitlab.com/psmisc/psmisc/
  DEPENDS:=+libncurses
  ALTERNATIVES:=300:/opt/bin/killall:/opt/libexec/killall
endef

define Package/psmisc/description
  psmisc is a set of additional small useful utilities that use
  the proc filesystem like fuser, killall, prtstat, pstree.
endef

CONFIGURE_ARGS += \
	--disable-harden-flags \
	--localedir=/opt/share/locale

ifeq ($(ARCH),mips)
CONFIGURE_VARS += \
	ac_cv_member_struct_pt_regs_regs=no
endif

ifneq (,$(filter aarch64 mips,$(ARCH)))
	PEEK:=
else
	PEEK:=peekfd,
endif

MAKE_FLAGS += \
	CFLAGS="$(TARGET_CFLAGS)" \
	CPPFLAGS="$(TARGET_CPPFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)"

define Package/psmisc/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/{fuser,prtstat,pstree,$(PEEK)pslog} $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/libexec
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/killall $(1)/opt/libexec
endef

$(eval $(call BuildPackage,psmisc))
