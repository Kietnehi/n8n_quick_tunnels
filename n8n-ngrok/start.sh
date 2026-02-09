#!/bin/bash

docker compose up -d

echo "⏳ Đang đợi ngrok khởi động..."
sleep 3

NGROK_URL=$(docker logs ngrok | grep -o "https://[^ ]*" | head -n 1)

echo ""
echo "=============================="
echo "🚀 n8n public URL:"
echo "$NGROK_URL"
echo "=============================="
