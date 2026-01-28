function split_cards_pdf

    if test (count $argv) -lt 1
        echo "Usage: split_cards_pdf <input.pdf> [output_dir]"
        return 1
    end

    set input $argv[1]
    set base (string replace -r '\.pdf$' '' $input)

    # Optional output directory
    if test (count $argv) -ge 2
        set root_outdir $argv[2]
    else
        set root_outdir "."
    end

    if not test -d $root_outdir
        mkdir -p $root_outdir
    end

    set num_pages (mdls -name kMDItemNumberOfPages -raw $input)

    set trims \
        "0.25in 4.25in 8.125in 0.625in" \
        "2.875in 4.25in 5.5in 0.625in" \
        "5.5in 4.25in 2.875in 0.625in" \
        "8.125in 4.25in 0.25in 0.625in" \
        "0.25in 0.625in 8.125in 4.25in" \
        "2.875in 0.625in 5.5in 4.25in" \
        "5.5in 0.625in 2.875in 4.25in" \
        "8.125in 0.625in 0.25in 4.25in"

    for i in (seq 1 8)
        set trim $trims[$i]
        set outfile "$root_outdir/$base$i.pdf"

        pdfjam $input \
            --quiet \
            --papersize "{2.625in,3.625in}" \
            --trim "$trim" \
            --clip true \
            --outfile $outfile

        # Optional: extract text from page $pg of this card
        for pg in (seq 4 $num_pages)
            set pgindex (math $pg - 1)

            set cardtext (pdftotext -f $pg -l $pg $outfile -)
            set cardtitle (
                printf "%s\n" $cardtext |
                head -n 6 |
                pcregrep '(?m)^(([A-Z])([A-Z’ -])+$)+' |
                string join ' ' |
                string lower
            )

            for prefix in "kindled " "relic " "artifact " "the "
                if string match -q "$prefix*" $cardtitle
                    set cardtitle (string replace -r "^$prefix" "" $cardtitle)
                end
            end
            set cardlevel (
                printf "%s\n" $cardtext |
                head -n 6 |
                pcregrep -o1 '(?m)^Level:\s*(\d+)'
            )
            set input_pdf (printf "%s[%d]" $outfile $pgindex)
            set output_img (printf "%s/card_%03d_%d.jpg" $root_outdir $pg $i)
            magick -density 1200 $input_pdf $output_img

            if test -n "$cardtitle"
                set dst (printf "%s.jpg" "$cardtitle")
                if test -n "$cardlevel"
                    set level_dir "level$cardlevel"
                    if not test -d "$root_outdir/$level_dir"
                        mkdir "$root_outdir/$level_dir"
                    end
                    set dst "$level_dir/$dst"
                end
                mv "$output_img" "$root_outdir/$dst"
            end

            if test -f $output_img
                rm $output_img
            end
        end
        rm $outfile
    end
end
