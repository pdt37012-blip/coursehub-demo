-- Chay tung buoc tren cung mot tab Query Tool va cung mot ket noi.
-- Khong chay BEGIN roi bo qua ROLLBACK.

-- Buoc 1: Bat dau giao dich.
BEGIN;

-- Buoc 2: Thu dang ky Hoang Nam vao WEB-01.
INSERT INTO enrollments (student_id, class_section_id)
VALUES ('22000004', 'WEB-01');

-- Buoc 3: Quan sat view trong giao dich.
SELECT class_id, capacity, enrolled, remaining
FROM v_section_summary
WHERE class_id = 'WEB-01';

-- Buoc 4: Hoan tac dang ky thu.
ROLLBACK;

-- Buoc 5: Xac nhan so dang ky tro ve nhu cu.
SELECT class_id, capacity, enrolled, remaining
FROM v_section_summary
WHERE class_id = 'WEB-01';
