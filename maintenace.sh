#!/usr/bin/env bash
set -euo pipefail

KEEP=10
PROFILE="/nix/var/nix/profiles/system"

echo "=== NixOS Maintenance ==="

echo "Finding generations..."
mapfile -t generations < <(
    nix-env --profile "$PROFILE" --list-generations | awk '{print $1}'
)

count=${#generations[@]}

echo "Found $count generations."

if (( count > KEEP )); then
    echo "Deleting oldest $((count - KEEP)) generations..."

    nix-env \
        --profile "$PROFILE" \
        --delete-generations \
        "${generations[@]:0:count-KEEP}"
else
    echo "Nothing to delete."
fi

before=$(df --output=avail /nix | tail -1)

echo "Running garbage collection..."
nix store gc

echo "Optimising store..."
nix store optimise

after=$(df --output=avail /nix | tail -1)
echo "Freed $(((after-before)/1024)) MiB"

echo "Done."