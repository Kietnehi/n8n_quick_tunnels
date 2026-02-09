# n8n + ngrok (Docker) - Quick Guide

## ⚙️ Chuẩn bị trước khi chạy

### 1. Tạo Docker volume (chỉ cần 1 lần)
```bash
docker volume create n8n_data
```

### 2. Cấu hình Ngrok Token
Mở file `.env` và điền token của bạn:
```dotenv
TIMEZONE=Asia/Ho_Chi_Minh
NGROK_TOKEN="YOUR_ACTUAL_NGROK_TOKEN_HERE"
```

**Lấy token tại:** https://dashboard.ngrok.com/get-started/your-authtoken

### 3. (Tùy chọn) Cấu hình domain cố định
Nếu có Ngrok Paid, sửa file `ngrok.yml`:
```yaml
tunnels:
  n8n:
    proto: http
    addr: n8n:5678
    domain: your-domain.ngrok-free.app  # Thêm dòng này
```

---

## ▶️ Chạy hệ thống
```bash
chmod +x start.sh
./start.sh
```

**Kết quả:**
- Start n8n + ngrok  
- Terminal sẽ **in ra link public ngrok**  
- Bấm link đó để truy cập n8n từ internet  

Ví dụ:
```
🚀 n8n public URL:
https://12ab-34-56-78-90.ngrok-free.app
```

---

## 🛑 Dừng hệ thống
```bash
chmod +x stop.sh
./stop.sh
```

- Stop n8n + ngrok  
- **Data (workflow, credentials) không bị mất** (lưu trong volume `n8n_data`)

---

## 🖥️ Truy cập n8n
- **Local:** http://localhost:5678  
- **Public:** Link ngrok in ra khi chạy `start.sh`

---

## ⚠️ Lưu ý quan trọng

- ✅ **Ngrok FREE:** Link sẽ đổi mỗi lần restart
- ✅ **Ngrok PAID:** Có thể dùng domain cố định (cấu hình trong `ngrok.yml`)
- ✅ **Dữ liệu persistent:** Volume `n8n_data` lưu workflows và credentials vĩnh viễn
- ✅ **Logs:** Xem bằng `docker logs n8n` hoặc `docker logs ngrok`

---

## 🔧 Khắc phục lỗi nhanh

```bash
# Kiểm tra containers đang chạy
docker ps

# Xem logs nếu có lỗi
docker logs ngrok
docker logs n8n

# Restart lại hệ thống
./stop.sh
./start.sh
```

**Đọc thêm:** Xem file [README.md](README.md) để biết chi tiết đầy đủ.
