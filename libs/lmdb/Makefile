include $(TOPDIR)/rules.mk

PKG_NAME:=lmdb
PKG_VERSION:=0.9.32
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://git.openldap.org/openldap/openldap.git
PKG_SOURCE_DATE:=2024-01-29
PKG_SOURCE_VERSION:=LMDB_$(PKG_VERSION)
PKG_MIRROR_HASH:=2fe139bf74e186c937eae2b1dea9094d902c16a4852378135441f4c5d837fec5

PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec1@gmail.com>
PKG_LICENSE:=OLDAP-2.8
PKG_LICENSE_FILES:=LICENSE

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
MAKE_PATH:=libraries/liblmdb

define Package/lmdb/Default
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Lightning Memory-Mapped Database
  URL:=https://symas.com/lmdb/
endef

define Package/lmdb
	$(call Package/lmdb/Default)
  TITLE+= shared library
endef

define Package/lmdb/description
  LMDB is an ultra-fast, ultra-compact key-value
  embedded data store developed for the OpenLDAP Project.
endef

define Package/lmdb-utils
	$(call Package/lmdb/Default)
  TITLE+= utils
  MDEPENDS+= lmdb
endef

define Package/lmdb-utils/description
  LMDB environment status and copy tool
endef

define Package/lmdb-test
	$(call Package/lmdb/Default)
  TITLE+= test
  MDEPENDS+= lmdb
endef

define Package/lmdb-test/description
  LMDB test application
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	$(SED) 's,%%PKG_VERSION%%,$(PKG_VERSION),g' $(PKG_BUILD_DIR)/liblmdb.pc
endef

define Build/Compile
	$(MAKE) -C "$(PKG_BUILD_DIR)/$(MAKE_PATH)/" \
		CC="$(TARGET_CC)" \
		CFLAGS+="$(TARGET_CFLAGS)" \
		LDFLAGS+="$(TARGET_LDFLAGS) $(if $(CONFIG_USE_GLIBC),-lpthread)" \
		FPIC="$(FPIC)" \
		AR="$(TARGET_AR)"
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_BUILD_DIR)/$(MAKE_PATH)/lmdb.h $(1)/opt/include
	$(CP) $(PKG_BUILD_DIR)/$(MAKE_PATH)/liblmdb.{a,so} $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig/
	$(CP) $(PKG_BUILD_DIR)/liblmdb.pc $(1)/opt/lib/pkgconfig/lmdb.pc
endef

define Package/lmdb/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.so $(1)/opt/lib
endef

define Package/lmdb-utils/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/mdb_{stat,copy,dump,load} $(1)/opt/bin
endef

define Package/lmdb-test/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/$(MAKE_PATH)/mtest $(1)/opt/bin
endef

$(eval $(call BuildPackage,lmdb))
$(eval $(call BuildPackage,lmdb-utils))
$(eval $(call BuildPackage,lmdb-test))
