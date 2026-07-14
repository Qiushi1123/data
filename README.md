# SHARP Stage 2 Data Package

This repository stores the SHARP Stage 2 smoke-training image set as split archive parts so it can be pulled quickly on a training machine without checking out hundreds of JPEG blobs individually.

## Contents

- `3dgsdata_stage2_ready.tar.gz.part-aa`
- `3dgsdata_stage2_ready.tar.gz.part-ab`
- `3dgsdata_stage2_ready.tar.gz.part-ac`
- `SHA256SUMS`
- `unpack.sh`

The reconstructed archive expands to `3dgsdata_stage2_ready/`, containing 282 RGB JPEG images and `conversion_manifest.csv`.

## Unpack

```bash
bash unpack.sh
```

Equivalent manual commands:

```bash
cat 3dgsdata_stage2_ready.tar.gz.part-* > 3dgsdata_stage2_ready.tar.gz
sha256sum -c SHA256SUMS
tar -xzf 3dgsdata_stage2_ready.tar.gz
```
