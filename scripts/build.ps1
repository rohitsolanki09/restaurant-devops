# ==============================
# Restaurant App Build Script
# ==============================

$ErrorActionPreference = "Stop"

# Paths
$ROOT = Resolve-Path ".."
$BUILD_DIR = Join-Path $ROOT "build"
$APP_DIR = Join-Path $ROOT "exe"
$ICONS_DIR = Join-Path $ROOT "icons"

# Clean old build
if (Test-Path $BUILD_DIR) {
    Remove-Item -Recurse -Force $BUILD_DIR
}

# Create build structure
New-Item -ItemType Directory -Path $BUILD_DIR | Out-Null
New-Item -ItemType Directory -Path "$BUILD_DIR\exe" | Out-Null
New-Item -ItemType Directory -Path "$BUILD_DIR\icons" | Out-Null

# Copy application files
Copy-Item "$APP_DIR\*" "$BUILD_DIR\exe\" -Recurse -Force
Copy-Item "$ICONS_DIR\*" "$BUILD_DIR\icons\" -Recurse -Force

Write-Host "Build directory prepared successfully."

# Create versioned ZIP
$VERSION = Get-Date -Format "yyyyMMdd-HHmmss"
$ZIP_NAME = "restaurant-build-$VERSION.zip"
$ZIP_PATH = Join-Path $ROOT $ZIP_NAME

Compress-Archive -Path "$BUILD_DIR\*" -DestinationPath $ZIP_PATH

Write-Host "Build artifact created: $ZIP_NAME"

