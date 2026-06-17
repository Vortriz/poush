#let generic-section(title: none, body: none) = {
    set page(
        margin: (
            top: 4.5cm,
            bottom: 3.5cm,
            inside: 3cm,
            outside: 3cm,
        ),
        footer-descent: 0pt,
    )
    heading(level: 1, numbering: none)[#title]

    // set spacing to be the same as the leading
    set par(spacing: 0.56em)

    body

    // hack to ensure that the page inserted is blank
    set page(numbering: none)
    pagebreak(weak: true, to: "odd")
}
