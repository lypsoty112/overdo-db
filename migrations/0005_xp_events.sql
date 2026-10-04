-- An append-only ledger of XP: completing, un-completing and focusing all add a row, and the
-- total, level and streak are derived from it rather than stored.
CREATE TABLE xp_events (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id uuid REFERENCES tasks (id) ON DELETE SET NULL,
  reason text NOT NULL CHECK (reason IN ('completed', 'uncompleted', 'focus')),
  points integer NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX xp_events_created_idx ON xp_events (created_at);
