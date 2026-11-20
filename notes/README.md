# notes – demo application for *Docker Compose hands-on* (German: *Docker Compose zum Anfassen*)

| Service | Language | Port | Purpose |
|---|---|---|---|
| notes-api | Go 1.27 | 8080 | stores notes (in memory or Postgres); POST requires `X-API-Key` |
| notes-worker | Python 3.15 + uv | – | periodically summarizes the notes |
| notes-web | Node 26 | 3000 | web UI plus proxy to notes-api |
| db (from Day 3) | Postgres 18 | 5432 | image `postgres:18.6-alpine`, no Dockerfile of its own |

The Dockerfiles are the final state from *Dockerfiles hands-on* (multi-stage,
non-root, healthcheck in notes-api). There is no `compose.yaml` yet – it is
created on Day 1.

notes-api:

- API key from `NOTES_API_KEY_FILE` (preferred) or `NOTES_API_KEY`.
- Database URL from `NOTES_DB_URL_FILE` (preferred) or `NOTES_DB_URL`, e.g.
  `postgres://notes:lab-db-pw-123@db:5432/notes`. Without a URL: in-memory mode.
- `notes-api migrate` creates the `notes` table (idempotent) and exits with 0.
- `notes-api healthcheck` checks `/healthz`; with a database, `/healthz` only returns
  200 when the database is reachable.
- `GET /metrics` returns metrics in the Prometheus text format.

`.env` contains only lab values (`lab-…`), `.env.example` the template without values.
