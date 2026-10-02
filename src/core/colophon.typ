#let colophon = body => {
    set text(size: 10pt)
    set par(first-line-indent: 0em)

    v(1fr)

    smallcaps[Colophon]
    parbreak()
    body

    v(1em)

    pagebreak(weak: true, to: "odd")
}
