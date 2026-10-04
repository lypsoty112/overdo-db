-- Everything a task grew beyond its title: free-form notes, a 1 (urgent) to 4 (someday) priority,
-- how much energy it will take, and an optional due date.
ALTER TABLE tasks
  ADD COLUMN notes text NOT NULL DEFAULT '',
  ADD COLUMN priority smallint NOT NULL DEFAULT 3 CHECK (priority BETWEEN 1 AND 4),
  ADD COLUMN energy text NOT NULL DEFAULT 'medium' CHECK (energy IN ('low', 'medium', 'high', 'chaotic')),
  ADD COLUMN due_on date;
