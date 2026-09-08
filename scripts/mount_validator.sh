#!/usr/bin/env bash
# ==============================================================================
# Script Name : mount_validator.sh
# Description : Validates storage directory state and R/W mechanics
# ==============================================================================

set -euo pipefail

MOUNT_POINT="/mnt/media"
EXPECTED_FS="ext4"
TEST_FILE="${MOUNT_POINT}/.mount_test_tmp"

echo "[+] Starting storage validation for: ${MOUNT_POINT}"

# Check 1: Verify path resolution via kernel VFS table
if findmnt -T "${MOUNT_POINT}" > /dev/null 2>&1; then
    echo "[OK] Target ${MOUNT_POINT} is accessible on active filesystem."
else
    echo "[FAIL] Target ${MOUNT_POINT} is NOT accessible!"
    exit 1
fi

# Check 2: Verify Filesystem Type
ACTUAL_FS=$(findmnt -n -o FSTYPE -T "${MOUNT_POINT}")
if [ "${ACTUAL_FS}" = "${EXPECTED_FS}" ]; then
    echo "[OK] Filesystem type verified: ${ACTUAL_FS}"
else
    echo "[FAIL] Expected filesystem ${EXPECTED_FS}, but found ${ACTUAL_FS}"
    exit 2
fi

# Check 3: Read/Write I/O Test
echo "[+] Performing Read/Write verification..."
if touch "${TEST_FILE}" > /dev/null 2>&1; then
    echo "storage_test_ok" > "${TEST_FILE}"
    rm -f "${TEST_FILE}"
    echo "[OK] Read/Write permissions verified on ${MOUNT_POINT}"
else
    echo "[FAIL] Unable to write to ${MOUNT_POINT}. Check path permissions."
    exit 3
fi

echo "[SUCCESS] All storage validation checks passed successfully."
exit 0