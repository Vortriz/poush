#import "../utils.typ": centered-geometry

#let colophon(body) = {
    set text(size: 10pt)
    set page(
        margin: centered-geometry,
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
