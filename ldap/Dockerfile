# syntax=docker/dockerfile:1
# ldap/Dockerfile – OpenLDAP (slapd) aus Debian 13 für das Labor (Tag 6)
FROM debian:13.7-slim
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      slapd ldap-utils \
 && rm -rf /var/lib/apt/lists/* /etc/ldap/slapd.d/* /var/lib/ldap/*
COPY config.ldif.tmpl base.ldif.tmpl /opt/ldap/
COPY --chmod=755 entrypoint.sh /entrypoint.sh
EXPOSE 389
ENTRYPOINT ["/entrypoint.sh"]
