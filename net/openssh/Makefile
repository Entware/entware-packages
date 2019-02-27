#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=openssh
PKG_VERSION:=7.9p1
PKG_RELEASE:=4

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/ \
		https://ftp.spline.de/pub/OpenBSD/OpenSSH/portable/ \
		https://anorien.csc.warwick.ac.uk/pub/OpenBSD/OpenSSH/portable/
PKG_HASH:=6b4b3ba2253d84ed3771c8050728d597c91cfce898713beb7b64a305b6f11aad

PKG_LICENSE:=BSD ISC
PKG_LICENSE_FILES:=LICENCE


PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)
PKG_REMOVE_FILES:=

include $(INCLUDE_DIR)/package.mk

define Package/openssh/Default
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+libopenssl +zlib
	TITLE:=OpenSSH
	MAINTAINER:=Peter Wagner <tripolar@gmx.at>
	URL:=http://www.openssh.com/
	SUBMENU:=SSH
	VARIANT:=without-pam
endef

define Package/openssh-moduli
	$(call Package/openssh/Default)
	DEPENDS+= +openssh-keygen
	TITLE+= moduli file
endef

define Package/openssh-moduli/description
OpenSSH server moduli file.
endef

define Package/openssh-client
	$(call Package/openssh/Default)
	TITLE+= client
endef

define Package/openssh-client/description
OpenSSH client.
endef

define Package/openssh-client/conffiles
/opt/etc/ssh/ssh_config
endef

define Package/openssh-client-utils
	$(call Package/openssh/Default)
	DEPENDS+= +openssh-client +openssh-keygen
	TITLE+= client utilities
endef

define Package/openssh-client-utils/description
OpenSSH client utilities.
endef

define Package/openssh-keygen
	$(call Package/openssh/Default)
	TITLE+= keygen
endef

define Package/openssh-keygen/description
OpenSSH keygen.
endef

define Package/openssh-server
	$(call Package/openssh/Default)
	DEPENDS+= +openssh-keygen
	TITLE+= server
	USERID:=sshd=22:sshd=22
endef

define Package/openssh-server/description
OpenSSH server.
endef

define Package/openssh-server/conffiles
/opt/etc/ssh/sshd_config
/opt/etc/ssh/ssh_host_*_key
/opt/etc/ssh/ssh_host_*_key.pub
endef

define Package/openssh-server-pam
	$(call Package/openssh/Default)
	DEPENDS+= +libpthread +openssh-keygen +libpam
	TITLE+= server (with PAM support)
	VARIANT:=with-pam
	USERID:=sshd=22:sshd=22
endef

define Package/openssh-server-pam/description
OpenSSH server (with PAM support).
endef

define Package/openssh-server-pam/conffiles
/opt/etc/pam.d/sshd
/opt/etc/security/access-sshd-local.conf
/opt/etc/ssh/sshd_config
endef

define Package/openssh-sftp-client
	$(call Package/openssh/Default)
	TITLE+= SFTP client
endef

define Package/openssh-sftp-client/description
OpenSSH SFTP client.
endef

define Package/openssh-sftp-server
	$(call Package/openssh/Default)
	TITLE+= SFTP server
	# Strip dependencies to avoid pulling in OpenSSL etc.
	DEPENDS:=
endef

define Package/openssh-sftp-server/description
OpenSSH SFTP server.
endef

define Package/openssh-sftp-avahi-service
	$(call Package/openssh/Default)
	TITLE+= (SFTP Avahi service)
	DEPENDS:=+openssh-sftp-server +avahi-daemon
endef

define Package/openssh-sftp-avahi-service/description
 This package contains the service definition for announcing
 SFTP support via mDNS/DNS-SD.
endef

define Package/openssh-sftp-avahi-service/conffiles
/opt/etc/avahi/services/sftp-ssh.service
endef

CONFIGURE_ARGS+= \
	$(DISABLE_NLS) \
	--sysconfdir=/opt/etc/ssh \
	--with-pid-dir=/opt/var/run \
	--with-privsep-user=sshd \
	--with-privsep-path=/opt/var/empty \
	--enable-shared \
	--disable-static \
	--disable-debug \
	--disable-strip \
	--disable-etc-default-login \
	--disable-lastlog \
	--disable-utmp \
	--disable-utmpx \
	--disable-wtmp \
	--disable-wtmpx \
	--without-bsd-auth \
	--without-kerberos5 \
	--without-x

ifeq ($(BUILD_VARIANT),with-pam)
CONFIGURE_ARGS += \
	--with-pam
else
CONFIGURE_ARGS += \
	--without-pam
endif

ifeq ($(CONFIG_OPENSSL_ENGINE_CRYPTO),y)
CONFIGURE_ARGS+= \
	--with-ssl-engine
endif

ifneq ($(CONFIG_SSP_SUPPORT),y)
CONFIGURE_ARGS += \
	--without-stackprotect
endif

CONFIGURE_VARS += LD="$(TARGET_CC)"

ifeq ($(BUILD_VARIANT),with-pam)
TARGET_LDFLAGS += -lpthread
endif

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		LIBS="" \
		sftp-server
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		STRIP_OPT="" \
		all install
endef

define Package/openssh-moduli/install
	$(INSTALL_DIR) $(1)/opt/etc/ssh
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/etc/ssh/moduli $(1)/opt/etc/ssh/
endef

define Package/openssh-client/install
	$(INSTALL_DIR) $(1)/opt/etc/ssh
	chmod 0700 $(1)/opt/etc/ssh
	$(CP) $(PKG_INSTALL_DIR)/opt/etc/ssh/ssh_config $(1)/opt/etc/ssh/
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/ssh $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/scp $(1)/opt/bin/
endef

define Package/openssh-client-utils/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(foreach bin,add agent keyscan keysign,$(PKG_BUILD_DIR)/ssh-$(bin)) $(1)/opt/bin/
endef

define Package/openssh-keygen/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/ssh-keygen $(1)/opt/bin/
endef

define Package/openssh-server/install
	$(INSTALL_DIR) $(1)/opt/etc/ssh
	chmod 0700 $(1)/opt/etc/ssh
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/etc/ssh/sshd_config $(1)/opt/etc/ssh/
	sed -r -i 's,^#(HostKey /opt/etc/ssh/ssh_host_(rsa|ecdsa|ed25519)_key)$$$$,\1,' $(1)/opt/etc/ssh/sshd_config
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S40sshd $(1)/opt/etc/init.d/
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/sshd $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/var/empty
endef

define Package/openssh-server-pam/install
	$(call Package/openssh-server/install,$(1))
	sed -i 's,#PasswordAuthentication yes,PasswordAuthentication no,g' $(1)/opt/etc/ssh/sshd_config
	sed -i 's,#UsePAM no,UsePAM yes,g' $(1)/opt/etc/ssh/sshd_config
	$(INSTALL_DIR) $(1)/opt/etc/pam.d
	$(INSTALL_DATA) ./files/sshd.pam $(1)/opt/etc/pam.d/sshd
	$(INSTALL_DIR) $(1)/opt/etc/security
	$(INSTALL_DATA) ./files/sshd.pam-access $(1)/opt/etc/security/access-sshd-local.conf
endef

define Package/openssh-sftp-client/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/sftp $(1)/opt/bin/
endef

define Package/openssh-sftp-server/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/sftp-server $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/libexec
	ln -sf ../lib/sftp-server $(1)/opt/libexec/sftp-server
endef

define Package/openssh-sftp-avahi-service/install
	$(INSTALL_DIR) $(1)/opt/etc/avahi/services
	$(INSTALL_DATA) ./files/sftp-ssh.service $(1)/opt/etc/avahi/services/
endef

$(eval $(call BuildPackage,openssh-client))
$(eval $(call BuildPackage,openssh-moduli))
$(eval $(call BuildPackage,openssh-client-utils))
$(eval $(call BuildPackage,openssh-keygen))
$(eval $(call BuildPackage,openssh-server))
$(eval $(call BuildPackage,openssh-server-pam))
$(eval $(call BuildPackage,openssh-sftp-client))
$(eval $(call BuildPackage,openssh-sftp-server))
$(eval $(call BuildPackage,openssh-sftp-avahi-service))
