-- Subtasks belong to exactly one task and vanish with it; tags are shared across tasks by name.
CREATE TABLE subtasks (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id uuid NOT NULL REFERENCES tasks (id) ON DELETE CASCADE,
  title text NOT NULL CHECK (length(title) > 0),
  done boolean NOT NULL DEFAULT false,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX subtasks_task_idx ON subtasks (task_id, created_at);

CREATE TABLE tags (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL UNIQUE CHECK (length(name) > 0),
  color text NOT NULL
);

CREATE TABLE task_tags (
  task_id uuid NOT NULL REFERENCES tasks (id) ON DELETE CASCADE,
  tag_id uuid NOT NULL REFERENCES tags (id) ON DELETE CASCADE,
  PRIMARY KEY (task_id, tag_id)
);
