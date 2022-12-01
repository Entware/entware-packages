include $(TOPDIR)/rules.mk

PKG_NAME:=gpgme
PKG_VERSION:=1.18.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://gnupg.org/ftp/gcrypt/$(PKG_NAME)
PKG_HASH:=361d4eae47ce925dba0ea569af40e7b52c645c4ae2e65e5621bf1b6cdd8b0e9e

PKG_MAINTAINER:=Daniel Golle <daniel@makrotopia.org>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=COPYING

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libgpgme
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=GnuPG Made Easy (GPGME) library
  URL:=https://gnupg.org/software/gpgme/index.html
  DEPENDS:=+libassuan +libgpg-error
endef

define Package/libgpgmepp
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=GnuPG Made Easy (GPGME) library (C++)
  URL:=https://gnupg.org/software/gpgme/index.html
  DEPENDS:=+libgpgme +libstdcpp
endef

define Package/libgpgme/description
GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG
easier for applications. It provides a High-Level Crypto API for
encryption, decryption, signing, signature verification and key
management. Currently it uses GnuPG's OpenPGP backend as the default,
but the API isn't restricted to this engine. We have, in fact, already
developed a backend for CMS (S/MIME).
endef

CONFIGURE_ARGS += \
	--with-libassuan-prefix="$(STAGING_DIR)/opt/" \
	--with-gpg-error-prefix="$(STAGING_DIR)/opt/" \
	--disable-gpgconf-test \
	--disable-gpg-test \
	--disable-gpgsm-test \
	--disable-g13-test \
	--enable-languages="cpp"

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include/gpgme++
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/include/gpgme.h \
		$(1)/opt/include/
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/include/gpgme++/*.h \
		$(1)/opt/include/gpgme++/

	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/libgpgme.{la,so*} \
		$(1)/opt/lib/

	$(INSTALL_DIR) $(1)/opt/share/aclocal
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/share/aclocal/gpgme.m4 \
		$(1)/opt/share/aclocal/

	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/lib/pkgconfig/gpgme.pc \
		$(1)/opt/lib/pkgconfig
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/lib/pkgconfig/gpgme-glib.pc \
		$(1)/opt/lib/pkgconfig

	$(INSTALL_DIR) $(1)/opt/lib/cmake/Gpgmepp
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/lib/cmake/Gpgmepp/*.cmake \
		$(1)/opt/lib/cmake/Gpgmepp

	$(INSTALL_DIR) $(2)/bin $(1)/opt/bin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/opt/bin/gpgme-config \
		$(2)/bin/
	$(SED) \
		's,^\(prefix\|exec_prefix\)=.*,\1=$(STAGING_DIR)/opt,g' \
		$(2)/bin/gpgme-config
	$(LN) -sf $(STAGING_DIR)/host/bin/gpgme-config $(1)/opt/bin/gpgme-config
endef

define Package/libgpgme/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libgpgme.so.* $(1)/opt/lib/
endef

define Package/libgpgmepp/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libgpgmepp.so.* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,libgpgme))
$(eval $(call BuildPackage,libgpgmepp))
