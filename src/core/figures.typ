#import "../globals.typ": figure-numbering

#let _figures-style = body => {
    set figure(numbering: figure-numbering)

    // Tables have captions on top
    show figure.where(kind: table): set figure.caption(position: top)

    // Figure supplements are bold
    show figure.caption: it => {
        set text(size: 9pt)
        set par(justify: true)
        set align(left)

        context (
            strong[#it.supplement #it.counter.display(it.numbering)]
                + [: ]
                + it.body
        )
    }

    body
}
