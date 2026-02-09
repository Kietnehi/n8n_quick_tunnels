# n8n Docker với Cloudflare Tunnel (Windows)

[![Docker](https://img.shields.io/badge/Docker-Enabled-brightgreen.svg)]() [![n8n](https://img.shields.io/badge/n8n-Automation-blue.svg)]() [![Cloudflare](https://img.shields.io/badge/Cloudflare-Tunnel-orange.svg)]()

## 🎯 Giới thiệu

Thư mục này chứa cấu hình **Docker Compose** để chạy **n8n** (công cụ tự động hóa workflow mã nguồn mở) kết hợp với **Cloudflare Tunnel** (trycloudflare.com). 

**Tính năng chính:**
- Khởi động n8n nhanh chóng chỉ với **1 lệnh**
- Tự động tạo tunnel công khai (HTTPS) qua Cloudflare Zero Trust
- Tự động sao chép URL vào clipboard và mở trình duyệt
- Dọn dẹp tự động container/tunnel cũ
- Hỗ trợ Windows (Git Bash) với giao diện màu sắc thân thiện
- Volume dữ liệu persistent (`n8n_data` external)

**n8n chạy trên port 5678 local**, tunnel expose public URL tạm thời.

## 📋 Yêu cầu hệ thống

### 1. **Docker Desktop**
   - Cài đặt [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/)
   - Đảm bảo Docker Compose đã sẵn sàng: `docker-compose --version`

### 2. **Cloudflared (Cloudflare Tunnel)**
   - Tải từ: https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/tunnel-guide/local/
   - **Quan trọng:** Đặt file `cloudflared.exe` vào đường dẫn **CHÍNH XÁC**:
     ```
     C:\Program Files (x86)\cloudflared\cloudflared.exe
     ```
   - Nếu đặt khác vị trí, chỉnh sửa biến `CF_BIN` trong `run-n8n.sh`

### 3. **Git Bash (hoặc WSL)**
   - Cài Git for Windows: https://git-scm.com/download/win
   - Mở **Git Bash** tại thư mục này

### 4. **Volume dữ liệu (tùy chọn)**
   ```
   docker volume create n8n_data
   ```

## 🚀 Hướng dẫn nhanh (Quick Start)

1. **Mở Git Bash** tại thư mục `n8n_cloudfare1/`
2. **Phân quyền script** (chỉ lần đầu):
   ```bash
   chmod +x run-n8n.sh
   ```
3. **Chạy n8n**:
   ```bash
   ./run-n8n.sh
   ```

   **Quá trình tự động:**
   - ✅ Kiểm tra Cloudflared
   - ✅ Dọn dẹp cũ
   - ✅ Tạo tunnel → Lấy URL public (e.g. `https://abc.trycloudflare.com`)
   - ✅ Khởi động n8n Docker
   - ✅ Chờ ready → **Mở tự động trình duyệt**
   - ✅ **URL đã copy vào clipboard!**

4. **Sử dụng n8n** tại URL hiển thị (tồn tại đến khi dừng script)

## 🛑 Dừng hệ thống

- Trong terminal script đang chạy, nhấn phím **`0`** (zero)
- Tự động: Kill tunnel + Down Docker → Clean hoàn toàn

## ⚙️ Cấu hình tùy chỉnh

### docker-compose.yml
```
- Image: b4ce485c070c (n8n custom/legacy)
- Port: 5678 (local)
- Env: WEBHOOK_URL (tự động từ tunnel)
- Volume: n8n_data:/home/node/.n8n (persistent workflows)
- Network: bridge
```

**Chỉnh sửa:**
- Thay image n8n: `image: n8nio/n8n:latest`
- Port khác: Chỉnh `ports` và script
- Env vars thêm: `N8N_BASIC_AUTH_ACTIVE=true` etc.

### run-n8n.sh
- `CF_BIN`: Đường dẫn cloudflared.exe
- Timeout tunnel: `for i in {1..15}`
- Wait n8n: `for i in {1..20}`

## 📁 Cấu trúc thư mục
```
n8n_cloudfare1/
├── docker-compose.yml     # Docker config
├── run-n8n.sh            # Script khởi động chính
├── README.md             # Tài liệu này
├── tunnel.log            # Log tunnel (tạo khi chạy)
└── n8n_data/             # Data volume (tùy chọn, external)
```

## 🔧 Khắc phục sự cố (Troubleshooting)

| Lỗi | Giải pháp |
|-----|-----------|
| `Không tìm thấy cloudflared.exe` | Kiểm tra đường dẫn `C:\Program Files (x86)\cloudflared\` |
| `Không lấy được URL tunnel` | Kiểm tra kết nối Internet, thử lại |
| `n8n không phản hồi (502)` | Tăng wait time trong script, kiểm tra Docker logs: `docker logs n8n_docker_legacy` |
| `Volume n8n_data không tồn tại` | `docker volume create n8n_data` |
| **Windows Firewall** | Cho phép Docker/Cloudflared qua firewall |

**Xem logs:**
```bash
docker logs n8n_docker_legacy
cat tunnel.log
```

## 📈 Nâng cao

- **Permanent tunnel:** Sử dụng Cloudflare Zero Trust dashboard thay trycloudflare
- **Multi-instance:** Copy folder, đổi port/container_name
- **HTTPS cert:** n8n tự handle webhook HTTPS via WEBHOOK_URL
- **Backup:** `docker volume ls` → Backup `n8n_data`

## ⭐️ Đóng góp / License
- Dựa trên n8n official + Cloudflare Tunnel
- MIT License

**Enjoy automating! 🎉**


    