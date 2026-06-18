#import "../utils.typ": centered-geometry

#let centered-section(title: none, body) = {
    set page(
        margin: centered-geometry,
        footer-descent: 0pt,
    )

    if title != none {
        heading(level: 1, numbering: none)[#title]
    }

    // set spacing to be the same as the leading
    set par(spacing: 0.56em)

    body

    // hack to ensure that the page inserted is blank
    set page(numbering: none)
    pagebreak(weak: true, to: "odd")
}
