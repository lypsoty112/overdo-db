-- The task itself: a title and where it is on the todo -> doing -> done track.
-- Soft-deleted via deleted_at so a deleted task can still explain old XP events.
CREATE TABLE tasks (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL CHECK (length(title) > 0),
  status text NOT NULL DEFAULT 'todo' CHECK (status IN ('todo', 'doing', 'done')),
  created_at timestamptz NOT NULL DEFAULT now(),
  completed_at timestamptz,
  deleted_at timestamptz
);

CREATE INDEX tasks_live_created_idx ON tasks (created_at) WHERE deleted_at IS NULL;
