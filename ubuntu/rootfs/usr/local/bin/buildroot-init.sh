#!/bin/bash
set -e
set -o pipefail

mkdir -p /workspace
cd /workspace

# Checkout out lts branch
git clone https://gitlab.com/buildroot.org/buildroot.git -b 2025.02.x
cd buildroot

# Enable
make beaglebone_defconfig
