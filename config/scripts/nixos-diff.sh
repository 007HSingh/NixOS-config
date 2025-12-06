#!/usr/bin/env bash

# Get the last two system generations
OLD=$(ls -d /nix/var/nix/profiles/system-*-link | tail -n 2 | head -n 1)
NEW=$(ls -d /nix/var/nix/profiles/system-*-link | tail -n 1)

echo "Comparing generations:"
echo "Old: $OLD"
echo "New: $NEW"
echo ""

nvd diff "$OLD" "$NEW"
