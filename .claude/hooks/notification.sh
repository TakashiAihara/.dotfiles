#!/bin/bash

# Immediate marker to prove script ran
date > /tmp/claude-notification-hook-marker.txt

# Error log
exec 2>> /tmp/claude-notification-hook-error.log

# Read stdin
INPUT=$(cat)

# Save input
echo "$INPUT" > /tmp/claude-notification-hook-input.json

# Start logging
LOG_FILE="/tmp/claude-notification-hook.log"
echo "=== $(date) ===" >> "$LOG_FILE"
echo "Input: $INPUT" >> "$LOG_FILE"

# Extract fields
MESSAGE=$(echo "$INPUT" | jq -r '.message // "確認待ち"')
TRANSCRIPT_PATH=$(echo "$INPUT" | jq -r '.transcript_path // ""')
PROJECT_DIR=${CLAUDE_PROJECT_DIR:-"unknown"}
PROJECT_NAME=$(basename "$PROJECT_DIR")

echo "Message: $MESSAGE" >> "$LOG_FILE"
echo "Project: $PROJECT_NAME" >> "$LOG_FILE"

# Get recent context
PENDING_TOOL=""
RECENT_USER_MESSAGE=""
if [ -n "$TRANSCRIPT_PATH" ] && [ -f "$TRANSCRIPT_PATH" ]; then
  PENDING_TOOL=$(cat "$TRANSCRIPT_PATH" | jq -r 'select(.message.content != null) | .message.content[] | select(.type == "tool_use") | .name' 2>/dev/null | tail -1)
  RECENT_USER_MESSAGE=$(cat "$TRANSCRIPT_PATH" | jq -r 'select(.type == "user") | .message.content | if type == "array" then .[0].text else . end' 2>/dev/null | tail -1 | head -c 100)
fi

# Build message
NOTIFICATION_MESSAGE="⚠️ 確認待ち

プロジェクト: ${PROJECT_NAME}
メッセージ: ${MESSAGE}"

if [ -n "$PENDING_TOOL" ]; then
  NOTIFICATION_MESSAGE="${NOTIFICATION_MESSAGE}
実行予定: ${PENDING_TOOL}"
fi

if [ -n "$RECENT_USER_MESSAGE" ]; then
  NOTIFICATION_MESSAGE="${NOTIFICATION_MESSAGE}
最近の入力: ${RECENT_USER_MESSAGE}..."
fi

# Send notification
echo "Sending..." >> "$LOG_FILE"
RESULT=$(gotify push "$NOTIFICATION_MESSAGE" --title "Claude Code - 確認待ち" --priority 8 2>&1)
echo "Result: $RESULT" >> "$LOG_FILE"

exit 0
