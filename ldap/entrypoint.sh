#!/bin/sh
# entrypoint.sh – beim ersten Start Konfiguration und Grundgerüst anlegen, dann slapd
set -eu
: "${LDAP_SUFFIX:=dc=notes,dc=lab}"
: "${LDAP_ADMIN_PASSWORD:?LDAP_ADMIN_PASSWORD fehlt}"
: "${LDAP_BIND_PASSWORD:?LDAP_BIND_PASSWORD fehlt}"
export LDAP_SUFFIX
mkdir -p /var/run/slapd && chown openldap:openldap /var/run/slapd   # für ldapi:///
if [ -z "$(ls -A /etc/ldap/slapd.d 2>/dev/null)" ]; then
  echo "Erster Start: lege ${LDAP_SUFFIX} an"
  ADMIN_HASH=$(slappasswd -s "$LDAP_ADMIN_PASSWORD")
  BIND_HASH=$(slappasswd -s "$LDAP_BIND_PASSWORD")
  sed -e "s|@SUFFIX@|$LDAP_SUFFIX|g" -e "s|@ADMIN_HASH@|$ADMIN_HASH|" \
    /opt/ldap/config.ldif.tmpl > /tmp/config.ldif
  sed -e "s|@SUFFIX@|$LDAP_SUFFIX|g" -e "s|@BIND_HASH@|$BIND_HASH|" \
    /opt/ldap/base.ldif.tmpl > /tmp/base.ldif
  slapadd -n 0 -F /etc/ldap/slapd.d -l /tmp/config.ldif
  slapadd -n 1 -F /etc/ldap/slapd.d -l /tmp/base.ldif
  chown -R openldap:openldap /etc/ldap/slapd.d /var/lib/ldap
  rm /tmp/config.ldif /tmp/base.ldif
fi
exec slapd -d "${LDAP_LOG_LEVEL:-256}" -h "ldap:/// ldapi:///" \
  -u openldap -g openldap -F /etc/ldap/slapd.d
