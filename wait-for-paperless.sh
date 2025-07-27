#!/bin/bash

# Configuration
PAPERLESS_URL="http://localhost:7000"
HEALTH_ENDPOINT="/api/"
MAX_ATTEMPTS=30
WAIT_INTERVAL=10

echo "🔄 Waiting for Paperless-NGX to be ready..."
echo "Checking: ${PAPERLESS_URL}${HEALTH_ENDPOINT}"

for i in $(seq 1 $MAX_ATTEMPTS); do
  echo "Attempt $i/$MAX_ATTEMPTS..."
  
  if curl -f -s "${PAPERLESS_URL}${HEALTH_ENDPOINT}" > /dev/null 2>&1; then
    echo "✅ Paperless-NGX is ready!"
    exit 0
  fi
  
  if [ $i -lt $MAX_ATTEMPTS ]; then
    echo "⏳ Not ready yet, waiting ${WAIT_INTERVAL}s..."
    sleep $WAIT_INTERVAL
  fi
done

echo "❌ Paperless-NGX failed to become ready after $((MAX_ATTEMPTS * WAIT_INTERVAL)) seconds"
exit 1
