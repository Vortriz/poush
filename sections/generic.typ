#let generic-section(title: none, body: none) = {
    set page(
        margin: (top: 4.5cm, bottom: 3.5cm, inside: 3cm, outside: 3cm),
        footer-descent: 0pt,
    )
    heading(level: 1, numbering: none)[#title]

    set par(
        justify: true,
        leading: 6.2pt,
        spacing: 6pt,
        first-line-indent: 2em,
    )

    body

    // hack to ensure that the page inserted is blank
    set page(numbering: none)
    pagebreak(weak: true, to: "odd")
}
