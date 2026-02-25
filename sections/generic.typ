#let generic-section(title: none, body: none) = {
    set page(margin: (top: 4.5cm, rest: 3cm))

    heading(level: 1, numbering: none)[#title]

    set par(justify: true, leading: 6pt, spacing: 6pt, first-line-indent: 2em)

    body
}
