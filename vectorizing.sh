#!/usr/bin/env bash
SRC_DIR="$PWD/16x16"
OUT_DIR="$PWD/svg"
TMP_DIR="$PWD/tmp-512"

mkdir -p "$OUT_DIR"
mkdir -p "$TMP_DIR"

# Step 1: upscale all PNGs in parallel
upscale() {
    img="$1"
    TMP_DIR="$2"
    name=$(basename "${img%.png}")
    magick "$img" -filter point -resize 512x512 "$TMP_DIR/$name-512.png"
}
export -f upscale
parallel --eta --bar upscale {} "$TMP_DIR" ::: "$SRC_DIR"/*.png

# Step 2: trace all upscaled PNGs in parallel
trace() {
    upscaled="$1"
    TMP_DIR="$2"
    name=$(basename "${upscaled%-512.png}")
    vtracer \
        --input "$upscaled" \
        --output "$TMP_DIR/$name-traced.svg" \
        --colormode color \
        --hierarchical cutout \
        --mode pixel
}
export -f trace
parallel --eta --bar trace {} "$TMP_DIR" ::: "$TMP_DIR"/*-512.png

# Step 3: clean with scour in parallel
clean() {
    traced="$1"
    OUT_DIR="$2"
    name=$(basename "${traced%-traced.svg}")
    scour \
        -i "$traced" \
        -o "$OUT_DIR/$name.svg" \
        --enable-id-stripping \
        --enable-comment-stripping \
        --shorten-ids \
        --indent=none \
        >/dev/null
}
export -f clean
parallel --eta --bar clean {} "$OUT_DIR" ::: "$TMP_DIR"/*-traced.svg

# deleting temporary files
rm -rf "$TMP_DIR"
echo "Done. SVGs saved in $OUT_DIR"