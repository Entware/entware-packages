#
# Copyright (C) 2022 Julien Malik <julien.malik@paraiso.me>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

# initial implementation kindly stolen from (and then updated) :
# https://forum.openwrt.org/t/xxhash-makefile/118426

# XXX Entware specific: fixed it after the fucking maintainer

include $(TOPDIR)/rules.mk

PKG_NAME:=xxhash
PKG_VERSION:=0.8.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)_$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/Cyan4973/xxHash/archive/v$(PKG_VERSION)
PKG_HASH:=3bb6b7d6f30c591dd65aaaff1c8b7a5b94d81687998ca9400082c739a690436c

# The source for the library (xxhash.c and xxhash.h) is BSD
# The source for the command line tool (xxhsum.c) is GPLv2+
PKG_LICENSE:=BSD-2-Clause,GPL-2.0-or-later
PKG_LICENSE_FILES:=LICENSE,cli/COPYING
PKG_MAINTAINER:=Julien Malik <julien.malik@paraiso.me>

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

PKG_UNPACK:=$(TAR) -C $(PKG_BUILD_DIR) --strip-components 1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/xxhash/Default
  TITLE:=Extremely fast hash algorithm
  URL:=https://cyan4973.github.io/xxHash/
endef

define Package/xxhash/Default/description
  xxHash is an Extremely fast Hash algorithm, running at RAM speed
  limits. It successfully completes the SMHasher test suite which
  evaluates collision, dispersion and randomness qualities of hash
  functions. Code is highly portable, and hashes are identical on all
  platforms (little / big endian).
endef

define Package/libxxhash
  $(call Package/xxhash/Default)
  SECTION:=libs
  CATEGORY:=Libraries
endef

define Package/libxxhash/description
  $(call Package/xxhash/Default/description)

  This package contains the shared library.
endef

define Package/xxhash
  $(call Package/xxhash/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:= +libxxhash
endef

define Package/xxhash/description
  $(call Package/xxhash/Default/description)

  This package contains the executables.
endef

MAKE_FLAGS += PREFIX=/opt

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/*.h $(1)/opt/include
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libxxhash.so* $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libxxhash.pc $(1)/opt/lib/pkgconfig
endef

define Package/libxxhash/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libxxhash.so.* $(1)/opt/lib
endef

define Package/xxhash/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/xxhsum $(1)/opt/bin/
	$(LN) xxhsum $(1)/opt/bin/xxh32sum
	$(LN) xxhsum $(1)/opt/bin/xxh64sumn
	$(LN) xxhsum $(1)/opt/bin/xxh128sum
endef

$(eval $(call BuildPackage,libxxhash))
$(eval $(call BuildPackage,xxhash))
