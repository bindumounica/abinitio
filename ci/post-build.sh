#!/usr/bin/env bash
set -euo pipefail

echo "▶ Running post-build validation"

ARTIFACT_PATH=${ARTIFACT_PATH:-build/abinitio-etl-poc.tar.gz}
COMPONENT_NAME=${COMPONENT_NAME:-abinitio-etl-poc}
VERSION=${VERSION:-0.1.0}

# 1. Validate artifact exists
if [ ! -f "$ARTIFACT_PATH" ]; then
  echo "❌ Artifact not found: $ARTIFACT_PATH"
  exit 1
fi

# 2. Validate artifact is not empty
if [ ! -s "$ARTIFACT_PATH" ]; then
  echo "❌ Artifact is empty"
  exit 1
fi

# 3. Validate TAR format
if ! tar -tf "$ARTIFACT_PATH" >/dev/null 2>&1; then
  echo "❌ Invalid TAR archive"
  exit 1
fi

echo "✔ Artifact validation passed"

# 4. Generate checksum
echo "▶ Generating SHA256 checksum"
sha256sum "$ARTIFACT_PATH" > "${ARTIFACT_PATH}.sha256"

# 5. Generate metadata
echo "▶ Generating build metadata"

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

echo "✔ Post-build steps completed successfully"
