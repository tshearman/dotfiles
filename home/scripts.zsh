split_cards_pdf() {
    if [[ $# -lt 1 ]]; then
        echo "Usage: split_cards_pdf <input.pdf> [output_dir]"
        return 1
    fi

    local input="$1"
    local base="${input%.pdf}"

    # Optional output directory
    local root_outdir
    if [[ $# -ge 2 ]]; then
        root_outdir="$2"
    else
        root_outdir="."
    fi

    if [[ ! -d "$root_outdir" ]]; then
        mkdir -p "$root_outdir"
    fi

    local num_pages=$(mdls -name kMDItemNumberOfPages -raw "$input")

    local trims=(
        "0.25in 4.25in 8.125in 0.625in"
        "2.875in 4.25in 5.5in 0.625in"
        "5.5in 4.25in 2.875in 0.625in"
        "8.125in 4.25in 0.25in 0.625in"
        "0.25in 0.625in 8.125in 4.25in"
        "2.875in 0.625in 5.5in 4.25in"
        "5.5in 0.625in 2.875in 4.25in"
        "8.125in 0.625in 0.25in 4.25in"
    )

    for i in {1..8}; do
        local trim="${trims[$i]}"
        local outfile="$root_outdir/${base}${i}.pdf"

        pdfjam "$input" \
            --quiet \
            --papersize "{2.625in,3.625in}" \
            --trim "$trim" \
            --clip true \
            --outfile "$outfile"

        # Optional: extract text from page $pg of this card
        for pg in $(seq 4 $num_pages); do
            local pgindex=$((pg - 1))

            local cardtext=$(pdftotext -f $pg -l $pg "$outfile" -)
            local cardtitle=$(
                printf "%s\n" "$cardtext" |
                head -n 6 |
                pcregrep '(?m)^(([A-Z])([A-Z' -])+$)+' |
                tr '\n' ' ' |
                tr '[:upper:]' '[:lower:]'
            )

            for prefix in "kindled " "relic " "artifact " "the "; do
                if [[ "$cardtitle" == ${prefix}* ]]; then
                    cardtitle="${cardtitle#$prefix}"
                fi
            done

            local cardlevel=$(
                printf "%s\n" "$cardtext" |
                head -n 6 |
                pcregrep -o1 '(?m)^Level:\s*(\d+)'
            )

            local input_pdf=$(printf "%s[%d]" "$outfile" $pgindex)
            local output_img=$(printf "%s/card_%03d_%d.jpg" "$root_outdir" $pg $i)
            magick -density 1200 "$input_pdf" "$output_img"

            if [[ -n "$cardtitle" ]]; then
                local dst=$(printf "%s.jpg" "$cardtitle")
                if [[ -n "$cardlevel" ]]; then
                    local level_dir="level${cardlevel}"
                    if [[ ! -d "$root_outdir/$level_dir" ]]; then
                        mkdir "$root_outdir/$level_dir"
                    fi
                    dst="$level_dir/$dst"
                fi
                mv "$output_img" "$root_outdir/$dst"
            fi

            if [[ -f "$output_img" ]]; then
                rm "$output_img"
            fi
        done
        rm "$outfile"
    done
}
