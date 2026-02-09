# n8n + ngrok (Docker)

## ▶️ Chạy hệ thống
```bash
chmod +x start.sh
./start.sh
```

- Start n8n + ngrok  
- Terminal sẽ **in ra link public ngrok**  
- Bấm link đó để truy cập n8n từ internet  

Ví dụ:
```
🚀 n8n public URL:
https://xxxx.ngrok-free.dev
```

---

## 🛑 Dừng hệ thống
```bash
chmod +x stop.sh
./stop.sh
```

- Stop n8n + ngrok  
- **Data (workflow, credentials) không bị mất**

---

## 🖥️ Truy cập n8n
- Local: http://localhost:5678  
- Public: link ngrok in ra khi chạy `start.sh`

---

## ⚠️ Lưu ý
- Dùng ngrok FREE → link sẽ đổi mỗi lần restart
