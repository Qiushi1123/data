#!/usr/bin/env bash
set -euo pipefail

WORKDIR="${WORKDIR:-/mnt/sharp/sharp_stage2_smoke_$(date +%Y%m%d_%H%M%S)}"
CHECKPOINT_URL="${CHECKPOINT_URL:-https://ml-site.cdn-apple.com/models/sharp/sharp_2572gikvuh.pt}"
mkdir -p "$WORKDIR"
cd "$WORKDIR"

TRANSFER_DIR="${TRANSFER_DIR:-$(pwd)/transfer}"
if [[ ! -d "$TRANSFER_DIR" ]]; then
  git clone --depth 1 https://github.com/Qiushi1123/data.git "$TRANSFER_DIR"
fi
cd "$TRANSFER_DIR"

bash unpack.sh
cp stage2_100steps_config.json "$WORKDIR/stage2_100steps_config.json"
tar -xzf ml-sharp-main.tar.gz -C "$WORKDIR"

mkdir -p "$WORKDIR/checkpoints"
if [[ ! -f "$WORKDIR/checkpoints/sharp_2572gikvuh.pt" ]]; then
  curl -L "$CHECKPOINT_URL" -o "$WORKDIR/checkpoints/sharp_2572gikvuh.pt"
fi

cd "$WORKDIR/ml-sharp-main"
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python -m pip install -e .

sharp train \
  --config "$WORKDIR/stage2_100steps_config.json" \
  --output-dir "$WORKDIR/sharp_stage2_100step_run" \
  --stage stage2 \
  --device cuda \
  --data-root "$TRANSFER_DIR/3dgsdata_stage2_ready" \
  --init-weights "$WORKDIR/checkpoints/sharp_2572gikvuh.pt" \
  --teacher-weights "$WORKDIR/checkpoints/sharp_2572gikvuh.pt" \
  --max-steps 100 \
  --log-every 1
