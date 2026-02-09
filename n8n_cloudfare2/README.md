# n8n với Cloudflare Quick Tunnel

## Tổng quan

Thiết lập này chạy **n8n** (công cụ tự động hóa workflow self-hosted) bằng Docker và public ra Internet thông qua **Cloudflare Quick Tunnel** (`trycloudflare.com`).

Phù hợp để:
- Test webhook
- Truy cập UI n8n từ bên ngoài
- Không cần mở port, không cần domain tĩnh

### Tính năng chính

- Tự động phát hiện URL public của tunnel
- Tự động cập nhật `WEBHOOK_URL` trong file `.env` cho n8n
- Dữ liệu được lưu bền vững bằng Docker volume ngoài (`n8n_data`)
- Khởi động / dừng chỉ với một lệnh
- Tương thích Windows (sử dụng `cloudflared.exe`)

---

## Yêu cầu trước khi chạy

1. **Docker & Docker Compose** đã được cài đặt và đang chạy
2. **Cloudflared** (client của Cloudflare Tunnel)
   - Tải tại:  
     https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/tunnel-guide/local/
   - Cài vào đường dẫn (mặc định script dùng):
     ```
     C:\Program Files (x86)\cloudflared\cloudflared.exe
     ```
3. Tạo Docker volume để lưu dữ liệu n8n:
   ```bash
   docker volume create n8n_data
   ```

**Lưu ý:** Thư mục này đã có sẵn file `.env` để lưu WEBHOOK_URL (script sẽ tự động cập nhật).

---

## Khởi động nhanh

```bash
cd n8n_cloudfare2
./start-tunnel.sh
```

### Script sẽ làm gì?

1. Khởi chạy Cloudflare tunnel → `http://127.0.0.1:5678`
2. Lấy URL public (ví dụ: `https://abc-123.trycloudflare.com`)
3. Cập nhật file `.env` với biến `WEBHOOK_URL`
4. Restart container n8n
5. In ra **Public UI URL** 🎉

### Dừng tunnel

- Nhấn phím `0` trong terminal

### Trên Windows (Git Bash / WSL)

- Không cần `chmod`
- Chạy trực tiếp:
  ```bash
  ./start-tunnel.sh
  ```

---

## Truy cập

- **UI & Webhook public:** URL được in trong terminal (thay đổi mỗi lần restart)
- **UI local:**  
  ```
  http://localhost:5678
  ```

---

## Giải thích các file

| File | Mục đích |
|-----|---------|
| `docker-compose.yml` | Service n8n (port 5678, image legacy `b4ce485c070c`, volume ngoài) |
| `start-tunnel.sh` | Tự động hóa: tunnel → lấy URL → cập nhật env → docker up |
| `.env` | Chứa `WEBHOOK_URL` (tự sinh) |
| `cloudflared.log` | Log của tunnel (tạo khi chạy) |

---

## Tuỳ chỉnh

### Sửa `start-tunnel.sh`

```bash
PORT=5678                      # Đổi port n8n
HOST_HEADER=localhost          # HTTP host header
CF="C:/custom/path/cloudflared.exe"  # Đường dẫn cloudflared
```

### Cấu hình n8n (`docker-compose.yml`)

- Image: `b4ce485c070c`  
  (có thể update lên bản n8n mới hơn nếu cần)
- Volume: `n8n_data`  
  (lưu workflow và user vĩnh viễn)

---

## Xử lý sự cố

| Lỗi | Cách khắc phục |
|----|---------------|
| Không detect được URL public | Kiểm tra `cloudflared.log`, chạy lại script |
| Không tìm thấy `n8n_data` | Chạy `docker volume create n8n_data` |
| Không tìm thấy cloudflared | Sửa biến `CF=` trong script |
| Tunnel hết hạn | Quick Tunnel tồn tại ~24h, restart script |
| Trùng port | Đổi `PORT=` hoặc tắt service khác dùng 5678 |
| Lỗi path trên Windows | Dùng Git Bash, đảm bảo dùng dấu `/` |

### Xem log

```bash
docker logs n8n_docker_legacy
tail -f cloudflared.log
```

---

## Dự án liên quan

- `n8n_cloudfare1/` – Biến thể khác của setup này
- `n8n-ngrok/` – Dùng Ngrok thay cho Cloudflare

---

## License

MIT – Tự do sử dụng và chỉnh sửa.

---

*Xây dựng để test n8n nhanh gọn, không cần cấu hình phức tạp.* 🚀
