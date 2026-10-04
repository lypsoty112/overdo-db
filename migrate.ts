// Applies every not-yet-applied file in migrations/ in filename order, each in its own transaction.
// Applied names are recorded in schema_migrations, so re-running is a no-op; files are append-only.
import { readdir } from "node:fs/promises";
import postgres from "postgres";

const sql = postgres(process.env.DATABASE_URL ?? "postgres://overdo:overdo@localhost:5433/overdo", {
  onnotice: () => {},
});

await sql`CREATE TABLE IF NOT EXISTS schema_migrations (
  name text PRIMARY KEY,
  applied_at timestamptz NOT NULL DEFAULT now()
)`;

const applied = new Set(
  (await sql<{ name: string }[]>`SELECT name FROM schema_migrations`).map((r) => r.name),
);
const pending = (await readdir(new URL("./migrations", import.meta.url)))
  .filter((name) => name.endsWith(".sql") && !applied.has(name))
  .sort();

for (const name of pending) {
  await sql.begin(async (tx) => {
    await tx.file(new URL(`./migrations/${name}`, import.meta.url).pathname);
    await tx`INSERT INTO schema_migrations (name) VALUES (${name})`;
  });
  console.log(`applied ${name}`);
}

console.log(pending.length ? `${pending.length} migration(s) applied` : "already up to date");
await sql.end();
