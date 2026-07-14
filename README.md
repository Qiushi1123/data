# SHARP Stage 2 Transfer Package

This repository stores a self-contained transfer package for the SHARP Stage 2 100-step smoke run.

## Contents

- `3dgsdata_stage2_ready.tar.gz.part-aa`
- `3dgsdata_stage2_ready.tar.gz.part-ab`
- `3dgsdata_stage2_ready.tar.gz.part-ac`
- `SHA256SUMS`
- `unpack.sh`
- `ml-sharp-main.tar.gz`
- `stage2_100steps_config.json`
- `run_stage2_100steps.sh`

The reconstructed archive expands to `3dgsdata_stage2_ready/`, containing 282 RGB JPEG images and `conversion_manifest.csv`.

## Unpack Data Only

```bash
bash unpack.sh
```

Equivalent manual commands:

```bash
cat 3dgsdata_stage2_ready.tar.gz.part-* > 3dgsdata_stage2_ready.tar.gz
sha256sum -c SHA256SUMS
tar -xzf 3dgsdata_stage2_ready.tar.gz
```

## Run 100-Step Stage 2 Smoke Training

On the CloudML machine/job with `/mnt/sharp` mounted and CUDA available:

```bash
git clone --depth 1 https://github.com/Qiushi1123/data.git /mnt/sharp/sharp_stage2_transfer
cd /mnt/sharp/sharp_stage2_transfer
WORKDIR=/mnt/sharp/sharp_stage2_smoke bash run_stage2_100steps.sh
```
