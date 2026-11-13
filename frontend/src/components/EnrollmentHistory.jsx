import { useEffect, useState } from "react";
import { api } from "../api.js";
import Notice from "./Notice.jsx";

const PAGE_SIZE = 10;

export default function EnrollmentHistory({ studentId, refresh }) {
  const [page, setPage] = useState(0);
  const [rows, setRows] = useState([]);
  const [hasNext, setHasNext] = useState(false);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    const controller = new AbortController();

    async function loadHistory() {
      setLoading(true);
      setError("");
      setRows([]);
      try {
        const query = new URLSearchParams({
          student_id: studentId,
          dataset: "demo",
          skip: String(page * PAGE_SIZE),
          limit: String(PAGE_SIZE + 1),
        });
        const data = await api(`/enrollment-events?${query}`, {
          signal: controller.signal,
        });
        if (controller.signal.aborted) return;
        setRows(data.slice(0, PAGE_SIZE));
        setHasNext(data.length > PAGE_SIZE);
      } catch (requestError) {
        if (controller.signal.aborted) return;
        setError(requestError.message);
        setHasNext(false);
      } finally {
        if (!controller.signal.aborted) setLoading(false);
      }
    }

    loadHistory();
    return () => controller.abort();
  }, [studentId, page, refresh]);

  return (
    <section className="panel">
      <h2>4. Lịch sử đăng ký</h2>
      <p className="muted">
        Nhật ký demo của sinh viên {studentId} · Trang {page + 1}
      </p>
      {loading && <Notice>Đang tải lịch sử...</Notice>}
      <Notice kind="error">{error}</Notice>
      {!loading && !error && rows.length === 0 && (
        <p>Chưa có sự kiện đăng ký demo.</p>
      )}
      {!loading && !error && rows.length > 0 && (
        <div className="table-scroll">
          <table aria-label="Lịch sử đăng ký của sinh viên">
            <thead>
              <tr>
                <th>Thời gian</th>
                <th>Sự kiện</th>
                <th>Lớp học phần</th>
              </tr>
            </thead>
            <tbody>
              {rows.map((row) => (
                <tr key={row.id}>
                  <td>{new Date(row.occurred_at).toLocaleString()}</td>
                  <td>{row.event_type === "CREATED" ? "Đăng ký" : "Hủy đăng ký"}</td>
                  <td>{row.class_section_id}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
      <div className="pagination">
        <button
          type="button"
          className="secondary"
          disabled={loading || page === 0}
          onClick={() => setPage((current) => current - 1)}
        >
          Trang trước
        </button>
        <button
          type="button"
          disabled={loading || !hasNext}
          onClick={() => setPage((current) => current + 1)}
        >
          Trang sau
        </button>
      </div>
    </section>
  );
}
