#let colophon(body) = [
    #set text(10pt)
    #show smallcaps: it => text(tracking: 0.05em, it)
    #set page(numbering: none)

    #v(1fr)
    #smallcaps[Colophon]

    #body
    #v(4em)
]
