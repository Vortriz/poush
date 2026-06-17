#let colophon(body) = {
    set text(size: 10pt)
    set page(
        margin: (
            top: 4.5cm,
            bottom: 3.5cm,
            inside: 3cm,
            outside: 3cm,
        ),
        numbering: none,
    )
    set par(first-line-indent: 0em)

    v(1fr)
    [
        #smallcaps[Colophon]

        #body
    ]
    v(1em)

    // hack to ensure that the page inserted is blank
    set page(numbering: none)
    pagebreak(weak: true, to: "odd")
}
