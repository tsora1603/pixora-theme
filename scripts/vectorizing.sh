#!/usr/bin/env bash
SRC_DIR="$PWD/16x16"
OUT_DIR="$PWD/svg"
TMP_DIR="$PWD/tmp-512"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$OUT_DIR"
mkdir -p "$TMP_DIR"

# Step 1: upscale all PNGs in parallel (recursive search across subdirectories)
# The relative subdir path is encoded into the tmp filename as a prefix (slashes → __SLASH__)
# so we can reconstruct the output path later without losing structure.
upscale() {
    img="$1"
    SRC_DIR="$2"
    TMP_DIR="$3"
    rel="${img#$SRC_DIR/}"           # e.g. "icons/arrow.png"
    name="${rel%.png}"               # e.g. "icons/arrow"
    flat="${name//\//__SLASH__}"     # e.g. "icons__SLASH__arrow"
    magick "$img" -filter point -resize 512x512 "$TMP_DIR/$flat-512.png"
}
export -f upscale
mapfile -t png_files < <(find "$SRC_DIR" -type f -name "*.png")
parallel --eta --bar upscale {} "$SRC_DIR" "$TMP_DIR" ::: "${png_files[@]}"

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
    sed -i 's/<svg /<svg shape-rendering="crispEdges" /' "$TMP_DIR/$name-traced.svg"
}
export -f trace
parallel --eta --bar trace {} "$TMP_DIR" ::: "$TMP_DIR"/*-512.png

# Step 3: fit viewBox to actual visible content in parallel
fit() {
    traced="$1"
    TMP_DIR="$2"
    SCRIPT_DIR="$3"
    name=$(basename "${traced%-traced.svg}")
    python3 "$SCRIPT_DIR/svgfit.py" "$traced" "$TMP_DIR/$name-fit.svg"
}
export -f fit
parallel --eta --bar fit {} "$TMP_DIR" "$SCRIPT_DIR" ::: "$TMP_DIR"/*-traced.svg

# Step 4: clean with scour in parallel, restoring subdirectory structure under svg/
clean() {
    fit="$1"
    OUT_DIR="$2"
    flat=$(basename "${fit%-fit.svg}")              # e.g. "icons__SLASH__arrow"
    rel="${flat//__SLASH__/\/}"                     # e.g. "icons/arrow"
    out_path="$OUT_DIR/$rel.svg"                    # e.g. "svg/icons/arrow.svg"
    mkdir -p "$(dirname "$out_path")"
    scour \
        -i "$fit" \
        -o "$out_path" \
        --enable-id-stripping \
        --enable-comment-stripping \
        --shorten-ids \
        --indent=none \
        >/dev/null
}
export -f clean
parallel --eta --bar clean {} "$OUT_DIR" ::: "$TMP_DIR"/*-fit.svg

# deleting temporary files
rm -rf "$TMP_DIR"
echo "Done. SVGs saved in $OUT_DIR"
