#!/usr/bin/env bash
set -e

# Zed passes the current file path via $ZED_FILE
FILE="$ZED_FILE"

if [ -z "$FILE" ]; then
  echo "Error: ZED_FILE not set. Open a file and run again."
  exit 1
fi

EXT="${FILE##*.}"
BASENAME="$(basename "$FILE")"
NAME="${BASENAME%.*}"
WORKDIR="$(dirname "$FILE")"
BUILDDIR="$WORKDIR/build_out"

# Create build output directory if it doesn't exist
mkdir -p "$BUILDDIR"

echo "Running $FILE ..."
echo "--------------------------"

case "$EXT" in
  c)
    gcc "$FILE" -o "$BUILDDIR/$NAME" && "$BUILDDIR/$NAME"
    ;;
  cpp|cc|cxx)
    g++ "$FILE" -o "$BUILDDIR/$NAME" && "$BUILDDIR/$NAME"
    ;;
  py)
    python "$FILE"
    ;;
  js)
    node "$FILE"
    ;;
  ts)
    deno run "$FILE"
    ;;
  java)
    javac "$FILE" -d "$BUILDDIR" && java -cp "$BUILDDIR" "$NAME"
    ;;
  go)
    go run "$FILE"
    ;;
  rs)
    rustc "$FILE" -o "$BUILDDIR/$NAME" && "$BUILDDIR/$NAME"
    ;;
  sh)
    bash "$FILE"
    ;;
  php)
    php "$FILE"
    ;;
  *)
    echo "Unsupported file type: .$EXT"
    exit 1
    ;;
esac
