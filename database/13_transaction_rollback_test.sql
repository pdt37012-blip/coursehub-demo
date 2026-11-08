DO $$
DECLARE
    test_student_id students.id%TYPE;
    test_class_section_id class_sections.id%TYPE;
    rows_before BIGINT;
    rows_after BIGINT;
BEGIN
    SELECT s.id, cs.id
    INTO test_student_id, test_class_section_id
    FROM students AS s
    CROSS JOIN class_sections AS cs
    WHERE NOT EXISTS (
        SELECT 1
        FROM enrollments AS e
        WHERE e.student_id = s.id
          AND e.class_section_id = cs.id
    )
    ORDER BY s.id, cs.id
    LIMIT 1
    FOR UPDATE OF s, cs;

    IF test_student_id IS NULL THEN
        RAISE EXCEPTION 'No unused student/class-section pair available';
    END IF;

    SELECT COUNT(*)
    INTO rows_before
    FROM enrollments
    WHERE student_id = test_student_id
      AND class_section_id = test_class_section_id;

    BEGIN
        INSERT INTO enrollments (student_id, class_section_id)
        VALUES (test_student_id, test_class_section_id);

        INSERT INTO enrollment_events
            (student_id, class_section_id, event_type, source, dataset)
        VALUES
            (test_student_id, test_class_section_id, 'INVALID_TEST_EVENT', 'rollback-test', 'demo');

        RAISE EXCEPTION 'Expected event_type constraint violation did not occur';
    EXCEPTION
        WHEN check_violation THEN
            RAISE NOTICE 'Expected event insert failed; rolling back the subtransaction';
    END;

    SELECT COUNT(*)
    INTO rows_after
    FROM enrollments
    WHERE student_id = test_student_id
      AND class_section_id = test_class_section_id;

    IF rows_after <> rows_before THEN
        RAISE EXCEPTION 'Rollback failed: enrollment count changed from % to %', rows_before, rows_after;
    END IF;

    RAISE NOTICE 'PASS: enrollment count stayed at % for student %, section %',
        rows_after, test_student_id, test_class_section_id;
END;
$$;