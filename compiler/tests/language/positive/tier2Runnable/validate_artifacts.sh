#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 4 ]; then
  printf 'usage: %s <wasm> <elf32> <firmware-v7m> <firmware-v8m>\n' "$0" >&2
  exit 64
fi

wasm="$1"
elf="$2"
firmware="$3"
firmware_v8="$4"

for artifact in "$wasm" "$elf" "$firmware" "$firmware_v8"; do
  if [ ! -s "$artifact" ]; then
    printf 'missing or empty Tier 2 artifact: %s\n' "$artifact" >&2
    exit 65
  fi
done

readelf --wide --file-header "$elf" | grep -q 'ELF32'
readelf --wide --file-header "$elf" | grep -q 'ELF 32-bit'

node - "$wasm" <<'NODE'
const fs = require("fs");
const path = process.argv[2];
const bytes = fs.readFileSync(path);
if (bytes.length < 8 || bytes.subarray(0, 4).toString("hex") !== "0061736d") {
  throw new Error("invalid WASM magic");
}
WebAssembly.instantiate(bytes, {}).then(({ instance }) => {
  const entry = instance.exports.tier2_entry;
  if (typeof entry !== "function" || entry() !== 42) {
    throw new Error("tier2_entry did not return 42");
  }
}).catch((error) => {
  console.error(error.message);
  process.exit(66);
});
NODE

python3 - "$firmware" <<'PY'
import pathlib
import struct
import sys

payload = pathlib.Path(sys.argv[1]).read_bytes()
if len(payload) < 8:
    raise SystemExit("firmware is shorter than the initial vector table")
stack_top, reset = struct.unpack_from("<II", payload, 0)
if stack_top == 0 or (reset & 1) == 0:
    raise SystemExit("invalid Cortex-M vector table")
PY

python3 - "$firmware_v8" <<'PY'
import pathlib
import struct
import sys

payload = pathlib.Path(sys.argv[1]).read_bytes()
if len(payload) < 8:
    raise SystemExit("ARMv8-M firmware is shorter than the initial vector table")
stack_top, reset = struct.unpack_from("<II", payload, 0)
if stack_top == 0 or (reset & 1) == 0:
    raise SystemExit("invalid ARMv8-M vector table")
PY

printf 'Tier 2 artifacts valid: wasm-runnable elf32-valid armv7m-vector-valid armv8m-vector-valid\n'
