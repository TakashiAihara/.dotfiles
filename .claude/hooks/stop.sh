#!/bin/bash

# Debug log
LOG_FILE="/tmp/claude-stop-hook.log"
echo "=== Stop Hook Executed at $(date) ===" >> "$LOG_FILE"
echo "PATH: $PATH" >> "$LOG_FILE"
echo "CLAUDE_PROJECT_DIR: $CLAUDE_PROJECT_DIR" >> "$LOG_FILE"
echo "HOME: $HOME" >> "$LOG_FILE"

# Ensure gotify is in PATH
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
echo "Updated PATH: $PATH" >> "$LOG_FILE"
echo "Gotify location: $(which gotify 2>&1)" >> "$LOG_FILE"

# Read JSON input from stdin
INPUT=$(cat)

# Log the full input for debugging
echo "$INPUT" | jq '.' > /tmp/claude-stop-hook-input.json 2>/dev/null || echo "$INPUT" > /tmp/claude-stop-hook-input.json
echo "Input saved to /tmp/claude-stop-hook-input.json" >> "$LOG_FILE"

# Extract basic fields
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"')
TRANSCRIPT_PATH=$(echo "$INPUT" | jq -r '.transcript_path // ""')
PROJECT_DIR=${CLAUDE_PROJECT_DIR:-"unknown"}
PROJECT_NAME=$(basename "$PROJECT_DIR")

# Try to extract recent activity from transcript if available
RECENT_TOOLS=""
if [ -n "$TRANSCRIPT_PATH" ] && [ -f "$TRANSCRIPT_PATH" ]; then
  # Get the last few tool uses from JSONL transcript
  RECENT_TOOLS=$(cat "$TRANSCRIPT_PATH" | jq -r 'select(.message.content != null) | .message.content[] | select(.type == "tool_use") | .name' 2>/dev/null | tail -5 | tr '\n' ',' | sed 's/,$//' | sed 's/,/, /g')
fi

# Build notification message
if [ -n "$RECENT_TOOLS" ]; then
  NOTIFICATION_MESSAGE="🎉 作業完了

プロジェクト: ${PROJECT_NAME}
最近の作業: ${RECENT_TOOLS}
セッションID: ${SESSION_ID:0:8}..."
else
  NOTIFICATION_MESSAGE="🎉 作業完了

プロジェクト: ${PROJECT_NAME}
セッションID: ${SESSION_ID:0:8}..."
fi

# Send gotify notification
echo "Sending notification..." >> "$LOG_FILE"
echo "Title: Claude Code - 作業完了" >> "$LOG_FILE"
echo "Message: $NOTIFICATION_MESSAGE" >> "$LOG_FILE"

GOTIFY_OUTPUT=$(gotify push "$NOTIFICATION_MESSAGE" \
  --title "Claude Code - 作業完了" \
  --priority 5 2>&1)
GOTIFY_EXIT_CODE=$?

echo "Gotify exit code: $GOTIFY_EXIT_CODE" >> "$LOG_FILE"
echo "Gotify output: $GOTIFY_OUTPUT" >> "$LOG_FILE"

exit 0
