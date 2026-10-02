#let _outlines-style(figure-kinds, doc) = {
    show outline: it => {
        set heading(outlined: true)

        set outline.entry(
            fill: pad(
                x: 1em,
                repeat(
                    gap: 0.5em,
                    [.],
                ),
            ),
        )

        it
    }

    show selector.or(
        outline.where(target: selector(heading)),
        outline.where(target: figure.where(kind: "part", outlined: true)),
    ): it => {
        show outline.entry.where(level: 1): set text(weight: "bold")
        show outline.entry.where(level: 1): set outline.entry(fill: none)
        show outline.entry.where(level: 1): set block(above: 1.6em)
        show outline.entry: it => {
            link(
                it.element.location(),
                it.indented(
                    it.prefix(),
                    gap: 1em,
                    {
                        if it.body().func() == metadata {
                            v(1em)
                            let val = it.body().value
                            set text(size: 9pt)
                            box(width: 2em, val.num)
                            smallcaps(upper(val.title))
                        } else {
                            it.body()
                        }

                        set text(fill: black)
                        box(width: 1fr, it.fill)
                        it.page()
                    },
                ),
            )
        }
        it
    }

    show selector.or(
        ..figure-kinds.map(
            kind => outline.where(target: figure.where(kind: kind)),
        ),
    ): it => {
        show outline.entry: it => {
            link(
                it.element.location(),
                it.indented(
                    counter(it.element.func()).display(
                        at: it.element.location(),
                    ),
                    gap: 1em,
                    [
                        #it.body()
                        #set text(fill: black)
                        #box(width: 1fr, it.fill)
                        #it.page()
                    ],
                ),
            )
        }
        it
    }

    doc
}
