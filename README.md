# Keycloak zum Anfassen – Begleitcode

Begleitcode zum Buch **Keycloak zum Anfassen** – Identität und Login vom ersten Realm bis LDAP. Teil der Reihe IT-Trainingslager von Thomas Zachmann.

Buchseite: https://it-trainingslager.de/buecher/keycloak

Der Code begleitet das Buch; Erklärungen und Übungen stehen im Buch. Alle Passwörter und Secrets sind Laborwerte – nie in Produktion verwenden.

## Inhalt

- `setup/` – `env.sh` mit `kcadm`, `kclogin`, `token` und `jwt` für jeden Trainingstag
- `keycloak/` – Keycloak 26.8 mit Postgres (Tag 1), Ordner für Truststores (Tag 9) und Themes (Tag 11)
- `notes/` – Quellcode von notes-api (prüft Tokens per JWKS) und notes-web
- `notes-stack/` – notes mit oauth2-proxy (Tag 4), Override für TLS (Tag 12)
- `ldap/` – eigenes OpenLDAP-Image aus Debian 13 mit Beispieldaten (Tag 6)
- `samba/` – Active Directory mit Samba (Tag 9)
- `keycloak-ha/` – zwei Instanzen hinter Caddy mit TLS (Tag 12)
- `kc-probe/` – Probe-Instanz für Upgrade-Tests (Tag 12)
- `terraform/` – Rollen, Gruppen, Clients und Benutzer als Code (Tag 13)
- `k8s/` – Postgres, Keycloak und Realm-Import für den Operator auf k3s (Tag 14)

## Schnellstart

```bash
git clone https://github.com/thomaszachmann/keycloak-zum-anfassen.git ~/kc-lab/code
```

Details stehen im Kapitel „Tag 0“ des Buchs.

## Lizenz

Code: MIT (siehe LICENSE). Buchtexte, Abbildungen und Cover sind nicht Teil dieses Repos und nicht lizenziert.
