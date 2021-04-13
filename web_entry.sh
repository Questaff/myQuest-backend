#!/bin/sh

if [ -f /app/tmp/pids/server.pid ]; then
  rm /app/tmp/pids/server.pid
fi

rails server -b 0.0.0.0 -p 3000