#import "../utils.typ": footer, header

#let centered-section(title: none, body) = {
    set page(
        margin: (
            top: 4.5cm,
            bottom: 4cm,
            inside: 3cm,
            outside: 3cm,
        ),
        header: header,
        footer: footer,
        footer-descent: 1em,
    )

    if title != none {
        heading(level: 1, numbering: none, title)
    }

    body

    // hack to ensure that the page inserted is blank
    set page(numbering: none, header: none)
    pagebreak(weak: true, to: "odd")
}
