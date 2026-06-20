#!/bin/bash
# user-setup.sh – Create a shared group and sticky-bit directory
# Run with: sudo ./user-setup.sh
# This script is for learning; do not run on production without review.

set -euo pipefail

GROUP_NAME="devops-test"
SHARED_DIR="/tmp/devops-shared"

echo "=== Setting up shared workspace ==="

# 1. Create the group if it doesn't already exist
if ! dscl . -read "/Groups/$GROUP_NAME" &>/dev/null; then
    echo "Creating group $GROUP_NAME..."
    dscl . -create "/Groups/$GROUP_NAME"
    dscl . -create "/Groups/$GROUP_NAME" gid 5050
    dscl . -create "/Groups/$GROUP_NAME" passwd '*'
    echo "Group created."
else
    echo "Group $GROUP_NAME already exists."
fi

# 2. Add current user to the group (using $SUDO_USER so we add the real user who ran sudo)
CURRENT_USER="${SUDO_USER:-$USER}"
echo "Adding $CURRENT_USER to $GROUP_NAME..."
dscl . -append "/Groups/$GROUP_NAME" GroupMembership "$CURRENT_USER"

# 3. Create shared directory if needed
if [ ! -d "$SHARED_DIR" ]; then
    mkdir -p "$SHARED_DIR"
fi

# 4. Set group ownership
chown :$GROUP_NAME "$SHARED_DIR"

# 5. Set permissions: owner rwx, group rwx, others none
chmod 770 "$SHARED_DIR"

# 6. Apply sticky bit
chmod +t "$SHARED_DIR"

echo "Shared directory ready:"
ls -ld "$SHARED_DIR"

echo "=== Setup complete ==="
