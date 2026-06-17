#let epigraph(quote, author, source) = {
    set text(size: 9pt)
    set par(justify: false)
    show line: it => block(below: 0.5em, it)

    align(right)[
        #block(
            width: 47%,
            above: 2em,
            below: 2em,
            [
                #align(left, quote)

                #line(length: 100%, stroke: 0.5pt)

                #author \
                #emph(source)
            ],
        )
    ]
}
