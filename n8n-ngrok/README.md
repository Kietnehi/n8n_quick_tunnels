# n8n with Ngrok Tunnel

[![Docker](https://img.shields.io/badge/Docker-Enabled-brightgreen.svg)]() [![n8n](https://img.shields.io/badge/n8n-Automation-blue.svg)]() [![Ngrok](https://img.shields.io/badge/Ngrok-Tunnel-blue.svg)]()

## 🎯 Giới thiệu

Thiết lập này chạy **n8n** (công cụ tự động hóa workflow self-hosted) với **Ngrok** để tạo tunnel public HTTPS.

**Tính năng:**
- ✅ URL tunnel public qua Ngrok (có thể dùng domain cố định với Ngrok paid)
- ✅ HTTPS tự động
- ✅ Lưu trữ dữ liệu persistent với Docker volume
- ✅ Dễ dàng start/stop với script
- ✅ Phù hợp cho webhook testing và remote access

---

## 📋 Yêu cầu hệ thống

### 1. **Docker & Docker Compose**
- Cài đặt từ: [Docker Desktop](https://docs.docker.com/get-docker/)
- Kiểm tra: `docker --version` và `docker-compose --version`

### 2. **Tài khoản Ngrok**
- Đăng ký miễn phí tại: [ngrok.com](https://ngrok.com/)
- Lấy **Auth Token** từ [Ngrok Dashboard](https://dashboard.ngrok.com/get-started/your-authtoken)

### 3. **Tạo Docker Volume** (bắt buộc)
```bash
docker volume create n8n_data
```

---

## 🚀 Hướng dẫn cài đặt (Setup)

### Bước 1: Clone repository
```bash
git clone https://github.com/Kietnehi/n8n_ngrok_tunnel.git
cd n8n_ngrok_tunnel/n8n-ngrok
```

### Bước 2: Cấu hình Ngrok Auth Token

Mở file `.env` và thay thế token của bạn:

```dotenv
TIMEZONE=Asia/Ho_Chi_Minh
NGROK_TOKEN="YOUR_ACTUAL_NGROK_TOKEN_HERE"
```

**Lưu ý:** File `.env` đã có sẵn trong thư mục này.

### Bước 3: Cấu hình Ngrok Domain (Tùy chọn - Ngrok Paid)

Nếu bạn có **Ngrok Paid account** và muốn dùng domain cố định:

1. Vào [Ngrok Dashboard > Cloud Edge > Domains](https://dashboard.ngrok.com/cloud-edge/domains)
2. Reserve một domain (ví dụ: `my-n8n.ngrok-free.app`)
3. Mở file `ngrok.yml` và cấu hình:

```yaml
version: "2"

log: stdout
log_level: info

tunnels:
  n8n:
    proto: http
    addr: n8n:5678
    domain: my-n8n.ngrok-free.app  # Thay bằng domain của bạn
```

**Nếu dùng Ngrok Free:** Bỏ qua dòng `domain`, ngrok sẽ tạo URL ngẫu nhiên mỗi lần chạy.

---

## ▶️ Chạy hệ thống

### Cách 1: Dùng script (khuyến nghị)

```bash
chmod +x start.sh
./start.sh
```

**Script sẽ:**
- Khởi động n8n + ngrok containers
- Đợi 5 giây để services sẵn sàng
- Hiển thị **Public URL** để truy cập

### Cách 2: Docker Compose trực tiếp

```bash
docker-compose up -d
```

Sau đó xem logs của ngrok để lấy URL:
```bash
docker logs ngrok
```

Tìm dòng có `url=https://xxxxx.ngrok-free.app`

---

## 🖥️ Truy cập n8n

- **Local:** http://localhost:5678
- **Public:** URL được hiển thị từ script hoặc logs ngrok

**Ví dụ:**
```
🚀 n8n public URL:
https://12ab-34-56-78-90.ngrok-free.app
```

---

## 🛑 Dừng hệ thống

### Cách 1: Dùng script
```bash
chmod +x stop.sh
./stop.sh
```

### Cách 2: Docker Compose
```bash
docker-compose down
```

**Lưu ý:** Dữ liệu (workflows, credentials) được lưu trong volume `n8n_data` và **không bị mất** khi dừng.

---

## 📁 Cấu trúc thư mục

```
n8n-ngrok/
├── .env                   # Chứa NGROK_TOKEN và timezone
├── docker-compose.yaml    # Cấu hình Docker services
├── ngrok.yml             # Cấu hình ngrok tunnel
├── start.sh              # Script khởi động
├── stop.sh               # Script dừng
├── README.md             # Tài liệu này
└── Run.md                # Hướng dẫn nhanh
```

---

## 🔧 Khắc phục sự cố (Troubleshooting)

| Vấn đề | Giải pháp |
|--------|----------|
| `Error: invalid authtoken` | Kiểm tra lại NGROK_TOKEN trong file `.env` |
| `Volume n8n_data not found` | Chạy: `docker volume create n8n_data` |
| Không thấy URL ngrok | Xem logs: `docker logs ngrok` |
| Port 5678 đã được sử dụng | Tắt service khác hoặc đổi port trong `docker-compose.yaml` |
| Ngrok URL đổi mỗi lần chạy | Nâng cấp Ngrok Paid để dùng domain cố định |
| Container không start | Kiểm tra Docker đang chạy: `docker ps` |

### Xem logs chi tiết

```bash
# Logs n8n
docker logs n8n

# Logs ngrok
docker logs ngrok

# Logs realtime
docker-compose logs -f
```

---

## ⚙️ Tùy chỉnh nâng cao

### Thay đổi timezone

Sửa trong file `.env`:
```dotenv
TIMEZONE=America/New_York
```

### Thêm environment variables cho n8n

Sửa `docker-compose.yaml`, thêm vào phần `n8n` service:
```yaml
environment:
  - TZ=${TIMEZONE}
  - GENERIC_TIMEZONE=${TIMEZONE}
  - N8N_BASIC_AUTH_ACTIVE=true
  - N8N_BASIC_AUTH_USER=admin
  - N8N_BASIC_AUTH_PASSWORD=password123
```

### Backup dữ liệu

```bash
# Backup volume
docker run --rm -v n8n_data:/data -v $(pwd):/backup ubuntu tar czf /backup/n8n_backup.tar.gz /data

# Restore volume
docker run --rm -v n8n_data:/data -v $(pwd):/backup ubuntu tar xzf /backup/n8n_backup.tar.gz -C /
```

---

## 📚 Resources

- [n8n Documentation](https://docs.n8n.io/)
- [Ngrok Documentation](https://ngrok.com/docs)
- [Docker Documentation](https://docs.docker.com/)

---

## ⭐️ License

MIT License - Tự do sử dụng và chỉnh sửa

**Happy Automating! 🎉**
