# Keycloak hands-on – Companion Code

Companion code for the book **Keycloak hands-on** (German edition: *Keycloak zum Anfassen*) – identity and login from your first realm to LDAP. Part of Thomas Zachmann's IT Drills series.

Book page: https://itdrills.com/books/keycloak · German edition: https://it-trainingslager.de/buecher/keycloak

The code accompanies the book; explanations and exercises are in the book. All passwords and secrets are lab values – never use them in production.

## Contents

- `setup/` – `env.sh` with `kcadm`, `kclogin`, `token` and `jwt` for every training day
- `keycloak/` – Keycloak 26.8 with Postgres (Day 1), folders for truststores (Day 9) and themes (Day 11)
- `notes/` – source code of notes-api (validates tokens via JWKS) and notes-web
- `notes-stack/` – notes with oauth2-proxy (Day 4), override for TLS (Day 12)
- `ldap/` – custom OpenLDAP image based on Debian 13 with sample data (Day 6)
- `samba/` – Active Directory with Samba (Day 9)
- `keycloak-ha/` – two instances behind Caddy with TLS (Day 12)
- `kc-probe/` – test instance for upgrade tests (Day 12)
- `terraform/` – roles, groups, clients and users as code (Day 13)
- `k8s/` – Postgres, Keycloak and realm import for the operator on k3s (Day 14)

## Quick start

```bash
git clone https://github.com/thomaszachmann/keycloak-zum-anfassen.git ~/kc-lab/code
```

Details are in the book's "Day 0" chapter.

## License

Code: MIT (see LICENSE). Book text, figures and cover are not part of this repo and are not licensed.
