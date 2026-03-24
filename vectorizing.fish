#!/usr/bin/env fish

set SRC_DIR "$PWD/16x16"
set OUT_DIR "$PWD/svg"
set TMP_DIR "$PWD/tmp-512"

mkdir -p "$OUT_DIR"
mkdir -p "$TMP_DIR"

for img in $SRC_DIR/*.png
    set name (path change-extension "" (basename $img))

    set upscaled "$TMP_DIR/$name-512.png"
    set traced "$TMP_DIR/$name-traced.svg"
    set normalized "$TMP_DIR/$name-inkscape.svg"
    set cleaned "$OUT_DIR/$name.svg"

    echo "Processing $name..."

    # upscaling to 512x512
    magick "$img" -filter point -resize 512x512 "$upscaled"

    # tracing
    vtracer \
        --input "$upscaled" \
        --output "$traced" \
        --colormode color \
        --hierarchical cutout \
        --mode pixel

    # normalizing
    inkscape "$traced" \
        --batch-process \
        --actions="select-all;object-stroke-to-path;object-to-path;object-unlink-clones;fit-canvas-to-selection;export-plain-svg;export-filename:$normalized;export-do"

    # cleaning
    scour \
        -i "$normalized" \
        -o "$cleaned" \
        --enable-id-stripping \
        --enable-comment-stripping \
        --shorten-ids \
        --indent=none \
        >/dev/null
end

# deleting temporary files
rm -rf "$TMP_DIR"

echo "Done. SVGs saved in $OUT_DIR"
