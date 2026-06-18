#import "centered.typ": centered-section

#let colophon(body) = centered-section({
    set text(size: 10pt)
    set par(first-line-indent: 0em)

    v(1fr)

    smallcaps[Colophon]
    parbreak()
    body

    v(1em)
})
