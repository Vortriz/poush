#let colophon(body) = {
    set text(10pt)
    show smallcaps: it => text(tracking: 0.05em, it)
    set page(
        margin: (top: 4.5cm, bottom: 3.5cm, inside: 3cm, outside: 3cm),
        numbering: none,
    )
    set par(first-line-indent: 0em)

    v(1fr)
    [
        #smallcaps[Colophon]

        #body
    ]

    // hack to ensure that the page inserted is blank
    set page(numbering: none)
    pagebreak(weak: true, to: "odd")
}
