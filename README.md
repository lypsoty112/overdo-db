# overdo-db

Schema and migrations for **Overdo**, the to-do list that does far too much. The API lives in
`overdo-api`, the UI in `overdo-web`.

## Run it

```bash
bun install
bun run db:up      # Postgres 17 on localhost:5433 (overdo / overdo)
bun run migrate    # applies every new file in migrations/
```

Set `DATABASE_URL` (see `.env.example`) to migrate a database other than the local one.

## Rules

- Migrations are plain SQL, numbered `NNNN_name.sql`, and applied in filename order.
- A migration that has run anywhere is never edited. Fix forward with a new file.
- `schema_migrations` records which files ran.
