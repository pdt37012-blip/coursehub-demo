# CourseHub - Buoi 5

- CORS: preflight tu `http://127.0.0.1:5173` thanh cong; origin khong duoc phep bi tu choi.
- Frontend React/Vite: trang doc duoc danh sach hoc phan, lop hoc phan va dang ky cua sinh vien tu API.
- `npm run build`: thanh cong.
- `npm test`: chua chay duoc vi khong co `frontend/tests/api.test.mjs` trong workspace.
- Figma/wireframe: chua thuc hien.
- POST/DELETE da duoc goi khi kiem tra giao dien. Cac cap enrollment seed da duoc khoi phuc ve 5 dong; audit log hien co 14 event `demo` (7 `CREATED`, 7 `CANCELLED`). Du lieu `performance` van con 100000 event.
- `frontend/.env.local`, `node_modules/` va `dist/` duoc Git bo qua.

## Bai tu luyen CourseHub
- Da tach form chon sinh vien thanh `StudentForm.jsx`, dung state va handler do `App` truyen qua props.
- Da them bo loc hoc phan INT2204/INT2205/INT2206 tu du lieu `GET /courses`; bang hien trang thai rong khi khong co lop phu hop.
- Da them lich su dang ky phan trang, loc theo sinh vien va `dataset=demo`; moi lan chi lay toi da 11 su kien de hien 10 dong.
- Khong thuc hien muc ap dung vao Project nhom.
