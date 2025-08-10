#!/system/bin/sh
# Read fake Android ID from config
FAKE_ID=$(cat /data/adb/ksu/modules/spoof_android_id/config 2>/dev/null)
if [ -z "$FAKE_ID" ]; then
    # Generate random 16-character hex ID if config is empty
    FAKE_ID=$(cat /dev/urandom | tr -dc 'a-f0-9' | head -c 16)
    echo "$FAKE_ID" > /data/adb/ksu/modules/spoof_android_id/config
fi
# Update settings database
settings put secure android_id "$FAKE_ID"
# Check alternative path if needed
if [ -f /data/system_ce/0/settings_secure.xml ]; then
    settings put secure android_id "$FAKE_ID"
fi
# Optional: Set SELinux to permissive (uncomment only if policy fails)
# setenforce 0