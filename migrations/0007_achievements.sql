-- Achievements unlocked so far, one row each, keyed by the code overdo-api's rule list uses. The rules
-- themselves live in the API, so adding an achievement needs no migration; an unlock is never removed.
CREATE TABLE achievements (
  code text PRIMARY KEY CHECK (length(code) > 0),
  unlocked_at timestamptz NOT NULL DEFAULT now()
);
