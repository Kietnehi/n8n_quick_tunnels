#!/bin/bash

# --- Cấu hình màu sắc ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' 
BOLD='\033[1m'

# --- Đường dẫn ---
CF_BIN="/c/Program Files (x86)/cloudflared/cloudflared.exe"
LOG_FILE="tunnel.log"

clear
echo -e "${BLUE}${BOLD}==================================================${NC}"
echo -e "${BLUE}${BOLD}        TRÌNH KHỞI CHẠY n8n DOCKER + CLOUDFLARE   ${NC}"
echo -e "${BLUE}${BOLD}==================================================${NC}"

# 1. Kiểm tra Cloudflared
echo -e "\n${YELLOW}[1/5] Đang kiểm tra hệ thống...${NC}"
if [ ! -f "$CF_BIN" ]; then
    echo -e "${RED}❌ LỖI: Không tìm thấy file cloudflared.exe tại:${NC}"
    echo -e "   $CF_BIN"
    exit 1
fi
echo -e "${GREEN}✅ Cloudflared đã sẵn sàng!${NC}"

# 2. Dọn dẹp phiên cũ
echo -e "${YELLOW}[2/5] Đang dọn dẹp Container và Tunnel cũ...${NC}"
taskkill //F //IM cloudflared.exe //T > /dev/null 2>&1
docker-compose down > /dev/null 2>&1
rm -f $LOG_FILE
echo -e "${GREEN}✅ Hệ thống đã sạch sẽ.${NC}"

# 3. Khởi động Tunnel trước để lấy URL
echo -e "${YELLOW}[3/5] Đang kết nối Cloudflare Tunnel...${NC}"
"$CF_BIN" tunnel --url http://localhost:5678 --logfile $LOG_FILE > /dev/null 2>&1 &

WEB_URL=""
for i in {1..15}; do
    echo -n "."
    sleep 1
    WEB_URL=$(grep -o 'https://[-a-zA-Z0-9.]*\.trycloudflare.com' $LOG_FILE | head -n 1)
    if [ ! -z "$WEB_URL" ]; then break; fi
done

if [ -z "$WEB_URL" ]; then
    echo -e "${RED}\n❌ LỖI: Không lấy được link từ Cloudflare.${NC}"
    exit 1
fi
echo -e "${GREEN}\n✅ Đã lấy được URL mới: ${BOLD}$WEB_URL${NC}"

# 4. Khởi động Docker n8n
echo -e "${YELLOW}[4/5] Đang kích hoạt n8n Docker...${NC}"
export WEBHOOK_URL=$WEB_URL
docker-compose up -d > /dev/null 2>&1

# 5. Đợi n8n thực sự sống
echo -e "${YELLOW}[5/5] Đang chờ n8n khởi động xong (tránh lỗi 502)...${NC}"
for i in {1..20}; do
    echo -n "⏳"
    if curl -s http://localhost:5678 > /dev/null; then
        echo -e "${GREEN}\n✅ n8n đã phản hồi!${NC}"
        break
    fi
    sleep 2
done

# --- Hiển thị kết quả ---
echo -e "\n${BLUE}${BOLD}==================================================${NC}"
echo -e "${GREEN}${BOLD}🚀 n8n ĐÃ SẴN SÀNG HOẠT ĐỘNG!${NC}"
echo -e "${BOLD}🔗 Đường dẫn:${NC} ${BLUE}${BOLD}$WEB_URL${NC}"
echo -e "${BLUE}${BOLD}==================================================${NC}"

echo -n "$WEB_URL" | clip
echo -e "${YELLOW}👉 Đã sao chép link vào Bộ nhớ tạm!${NC}"
start "" "$WEB_URL"

# --- TÍNH NĂNG DỪNG HỆ THỐNG ---
echo -e "\n${BOLD}Nhấn phím ${RED}[0]${NC}${BOLD} để DỪNG và THOÁT hệ thống hoàn toàn.${NC}"

while true; do
    read -n 1 -s input
    if [ "$input" = "0" ]; then
        echo -e "\n\n${RED}🛑 Đang dừng hệ thống...${NC}"
        taskkill //F //IM cloudflared.exe //T > /dev/null 2>&1
        docker-compose down > /dev/null 2>&1
        echo -e "${GREEN}✅ Đã dọn dẹp xong. Tạm biệt!${NC}"
        sleep 2
        exit 0
    fi
done