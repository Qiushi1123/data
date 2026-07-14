#!/usr/bin/env bash
set -euo pipefail
cat 3dgsdata_stage2_ready.tar.gz.part-* > 3dgsdata_stage2_ready.tar.gz
sha256sum -c SHA256SUMS
tar -xzf 3dgsdata_stage2_ready.tar.gz
find 3dgsdata_stage2_ready -maxdepth 1 -type f -name 'img_*.jpg' | wc -l
