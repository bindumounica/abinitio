#!/usr/bin/env bash
set -euo pipefail

echo "▶ POST-BUILD VALIDATION STARTED"

ARTIFACT_PATH="${ARTIFACT_PATH:-$(ls build/dist/*.tar | head -n 1)}"
COMPONENT_NAME="${COMPONENT_NAME:-abinitio-etl-poc}"
VERSION="${VERSION:-1.0.0}"

# 1️⃣ Artifact exists
if [ ! -f "$ARTIFACT_PATH" ]; then
  echo "❌ Artifact not found: $ARTIFACT_PATH"
  exit 1
fi

# 2️⃣ Artifact not empty
if [ ! -s "$ARTIFACT_PATH" ]; then
  echo "❌ Artifact is empty"
  exit 1
fi

# 3️⃣ Valid TAR archive
if ! tar -tf "$ARTIFACT_PATH" >/dev/null 2>&1; then
  echo "❌ Invalid TAR archive"
  exit 1
fi

echo "✔ Artifact validated"

# 4️⃣ Generate checksum
sha256sum "$ARTIFACT_PATH" > "${ARTIFACT_PATH}.sha256"
echo "✔ Checksum generated"

# 5️⃣ Generate metadata
GIT_COMMIT=$(git rev-parse HEAD)
BUILD_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

cat <<EOF > build/build-metadata.json
{
  "component": "$COMPONENT_NAME",
  "version": "$VERSION",
  "artifact": "$(basename "$ARTIFACT_PATH")",
  "git_commit": "$GIT_COMMIT",
  "build_time_utc": "$BUILD_TIME",
  "checksum_file": "$(basename "$ARTIFACT_PATH").sha256"
}
EOF

echo "✔ Metadata generated"
echo "✔ POST-BUILD VALIDATION COMPLETED"
