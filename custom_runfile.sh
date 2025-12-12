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

echo "Running $FILE ..."
echo "--------------------------"

case "$EXT" in
  c)
    gcc "$FILE" -o "$WORKDIR/$NAME" && "$WORKDIR/$NAME"
    ;;
  cpp|cc|cxx)
    g++ "$FILE" -o "$WORKDIR/$NAME" && "$WORKDIR/$NAME"
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
    javac "$FILE" -d "$WORKDIR" && java -cp "$WORKDIR" "$NAME"
    ;;
  go)
    go run "$FILE"
    ;;
  rs)
    rustc "$FILE" -o "$WORKDIR/$NAME" && "$WORKDIR/$NAME"
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
