-- Cac lenh duoi day co y gay loi. Chay tung lenh rieng, khong chay ca tep.
-- Neu giao dich bi loi, chay ROLLBACK rieng truoc khi thu lenh tiep theo.

-- 1. Vi pham khoa chinh do dang ky trung.
INSERT INTO enrollments (student_id, class_section_id)
VALUES ('22000001', 'WEB-01');

-- 2. Vi pham khoa ngoai do sinh vien khong ton tai.
INSERT INTO enrollments (student_id, class_section_id)
VALUES ('22999999', 'WEB-01');

-- 3. Vi pham CHECK capacity > 0.
UPDATE class_sections
SET capacity = 0
WHERE id = 'WEB-01';

-- 4. Vi pham NOT NULL.
UPDATE courses
SET credits = NULL
WHERE code = 'INT2204';

-- 5. Vi pham UNIQUE email.
UPDATE students
SET email = 'anh@example.com'
WHERE id = '22000002';

-- 6. Vi pham CHECK ten khong duoc rong hoac toan dau cach.
UPDATE students
SET name = '   '
WHERE id = '22000004';

-- Chay rieng sau cac vi du loi de xac nhan du lieu khong thay doi.
SELECT COUNT(*) AS total_enrollments
FROM enrollments;
