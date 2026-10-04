-- Focus sessions against a task (ended_at stays null while one runs) and mood check-ins,
-- optionally tied to the task that caused the mood.
CREATE TABLE pomodoro_sessions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id uuid NOT NULL REFERENCES tasks (id) ON DELETE CASCADE,
  planned_minutes smallint NOT NULL DEFAULT 25 CHECK (planned_minutes BETWEEN 1 AND 180),
  started_at timestamptz NOT NULL DEFAULT now(),
  ended_at timestamptz
);

CREATE INDEX pomodoro_sessions_started_idx ON pomodoro_sessions (started_at);

CREATE TABLE mood_logs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id uuid REFERENCES tasks (id) ON DELETE SET NULL,
  mood text NOT NULL CHECK (mood IN ('ecstatic', 'fine', 'meh', 'drained', 'feral')),
  logged_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX mood_logs_logged_idx ON mood_logs (logged_at);
