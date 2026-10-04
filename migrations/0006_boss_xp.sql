-- Boss battles pay a bonus when a P1 task falls, so the XP ledger needs a reason for it. The check is
-- dropped and re-added under its original name, because Postgres cannot widen a CHECK in place.
ALTER TABLE xp_events
  DROP CONSTRAINT xp_events_reason_check,
  ADD CONSTRAINT xp_events_reason_check
    CHECK (reason IN ('completed', 'uncompleted', 'focus', 'boss_defeated'));
