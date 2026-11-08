-- Run against the generated 100000-row performance dataset.
-- Equality filters lead the index; occurred_at follows for the time range.
BEGIN;

DROP INDEX IF EXISTS idx_enrollment_events_section_type_time;

EXPLAIN (ANALYZE, BUFFERS)
SELECT class_section_id, event_type, COUNT(*) AS event_count
FROM enrollment_events
WHERE class_section_id = 'WEB-01'
  AND event_type = 'CREATED'
  AND occurred_at >= TIMESTAMP '2025-12-30 00:00:00'
GROUP BY class_section_id, event_type;

CREATE INDEX IF NOT EXISTS idx_enrollment_events_section_type_time
ON enrollment_events (class_section_id, event_type, occurred_at DESC);

ANALYZE enrollment_events;

EXPLAIN (ANALYZE, BUFFERS)
SELECT class_section_id, event_type, COUNT(*) AS event_count
FROM enrollment_events
WHERE class_section_id = 'WEB-01'
  AND event_type = 'CREATED'
  AND occurred_at >= TIMESTAMP '2025-12-30 00:00:00'
GROUP BY class_section_id, event_type;

COMMIT;