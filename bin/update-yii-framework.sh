#!/usr/bin/env bash
set -euo pipefail

# Update bundled Yii 1.1 framework in-place.
#
# Yiimp uses Yii 1.1 (maintenance mode). Newer Yii 1.1 releases include
# important compatibility & security fixes for modern PHP (8.2/8.3+).
#
# This script downloads the latest known Yii 1.1 release and replaces
# ./web/framework.

YII_VERSION="1.1.31"
ASSET="yii-1.1.31.34bac5.zip"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_DIR="$ROOT_DIR/web/framework"
TMP_DIR="$(mktemp -d)"

cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT

echo "[yii] Updating Yii framework to v$YII_VERSION ..."

download() {
  local url="$1" out="$2"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$out"
  else
    wget -qO "$out" "$url"
  fi
}

ZIP_PATH="$TMP_DIR/$ASSET"

MIRRORS=(
  "https://github.com/yiisoft/yii/releases/download/$YII_VERSION/$ASSET"
  "https://www.yiiframework.com/files/$ASSET"
  "https://sourceforge.net/projects/yii-web-programming.mirror/files/$YII_VERSION/$ASSET/download"
)

for url in "${MIRRORS[@]}"; do
  echo "[yii] Trying: $url"
  if download "$url" "$ZIP_PATH"; then
    break
  fi
done

if [[ ! -s "$ZIP_PATH" ]]; then
  echo "[yii] ERROR: Failed to download Yii $YII_VERSION from all mirrors." >&2
  exit 1
fi

unzip -q "$ZIP_PATH" -d "$TMP_DIR/unpacked"

if [[ ! -d "$TMP_DIR/unpacked/framework" ]]; then
  echo "[yii] ERROR: framework folder not found in archive." >&2
  exit 1
fi

echo "[yii] Replacing: $TARGET_DIR"
rm -rf "$TARGET_DIR"
mkdir -p "$(dirname "$TARGET_DIR")"
mv "$TMP_DIR/unpacked/framework" "$TARGET_DIR"

echo "[yii] Done. Current version should now be: $YII_VERSION"
