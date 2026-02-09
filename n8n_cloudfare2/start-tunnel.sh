#!/usr/bin/env bash
set -e

PORT=5678
HOST_HEADER=localhost
CF="/c/Program Files (x86)/cloudflared/cloudflared.exe"

cleanup() {
  echo
  echo "🛑 Stopping n8n docker..."
  docker compose down

  echo "🛑 Stopping cloudflared..."
  pkill -f cloudflared || true

  echo "👋 Bye!"
  exit 0
}

trap cleanup INT TERM

echo "🚀 Starting Cloudflare quick tunnel..."

"$CF" tunnel \
  --url http://127.0.0.1:$PORT \
  --http-host-header "$HOST_HEADER" \
  > cloudflared.log 2>&1 &

echo "⏳ Waiting for tunnel URL..."

for i in {1..30}; do
  URL=$(grep -o "https://[-a-zA-Z0-9]*\.trycloudflare.com" cloudflared.log | head -n 1)
  if [ -n "$URL" ]; then
    break
  fi
  sleep 1
done

if [ -z "$URL" ]; then
  echo "❌ Cannot detect public URL"
  cat cloudflared.log
  exit 1
fi

echo "🌍 Public URL: $URL"

cat > .env <<EOF
WEBHOOK_URL=$URL
EOF

echo "🐳 Restarting n8n with docker-compose..."
docker compose down
docker compose up -d

echo
echo "🎉 n8n is running!"
echo "👉 UI: $URL"
echo "----------------------------------"
echo "👉 Press [0] to stop"
echo "----------------------------------"

while true; do
  read -rsn1 key
  if [[ "$key" == "0" ]]; then
    cleanup
  fi
done
