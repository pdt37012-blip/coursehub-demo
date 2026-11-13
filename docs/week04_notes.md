# CourseHub - Buoi 4
- Migration 001: enrollment_events.
- Demo class: RACE-01, capacity = 1.
- POST /enrollments: lock class_sections bang FOR UPDATE.
- Concurrency test: 1 request 201, 1 request 409.
- Performance data: 100000 rows, dataset=performance.
- Index: idx_enrollment_events_dataset_student_time.

## Bai 2 - Rollback nhieu bang
- Chay `database/13_transaction_rollback_test.sql`.
- Script chon mot cap sinh vien/lop chua dang ky, INSERT enrollments, sau do co y INSERT event_type sai de kich hoat CHECK constraint.
- Exception duoc bat o PL/pgSQL subtransaction; ca INSERT enrollment trong subtransaction bi rollback. Script bao loi neu so dong cap do thay doi.
- Da chay thanh cong; bang enrollments van co 5 dong. Khong tao endpoint demo trong main.py.

## Bai 3 - Chi muc theo lop, loai su kien va thoi gian

| Do luong | Truoc | Sau |
| --- | ---: | ---: |
| Scan | Index Scan tren index student/time, loc bo 409 dong | Index Only Scan tren index section/type/time |
| Buffer access | 569 hit | 1 hit + 4 read |
| Heap fetches | khong ap dung | 0 |
| Execution time | 0.855 ms | 0.415 ms |

 So lieu la mot lan do local trong cung transaction; thoi gian va hit/read co the thay doi theo cache va tai he thong. Script drop/recreate chi muc muc tieu trong mot transaction de co the do lai baseline; index van ton tai sau COMMIT.

## Bai 4 - Migration 002
- Da ap dung `database/migrations/002_add_enrollment_event_note.sql`: them `note VARCHAR(200) NULL`.
- Truoc/sau migration, enrollment_events van co 100000 dong, id min/max 1/100000 va SUM(id) = 5000050000; 100000 note dang NULL.
- Rollback: `database/migrations/002_add_enrollment_event_note_rollback.sql` xoa cot note va dong migration 002. Rollback se mat moi gia tri note da ghi; luc ap dung chua co note nao nen khong mat du lieu hien huu.

Khong commit backend/.env.