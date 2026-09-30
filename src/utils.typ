#import "deps.typ": hydra

// unlike `smallcaps`, `upper` is not a element function, so it can't be targeted with show rule. This is a workaround to apply the same tracking to uppercased text.
#let spaced-upper = body => text(
    tracking: 0.05em,
    spacing: 0.2em,
    upper(body),
)

#let header = context {
    if calc.odd(here().page()) {
        hydra(
            2,
            display: (_, it) => {
                smallcaps(lower(it.body))
                h(1fr)
                counter(page).display()
            },
            skip-starting: false,
        )
    } else {
        hydra(
            1,
            display: (_, it) => {
                counter(page).display()
                h(1fr)
                smallcaps(lower(it.body))
            },
        )
    }
}

#let footer = context {
    let current-page = here().page()
    let has-heading = query(heading.where(level: 1)).any(it => (
        it.location().page() == current-page
    ))
    if has-heading {
        align(center, counter(page).display())
    }
}

#let centered-page = body => {
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

    body
}

#let centered-section(title: none, body) = centered-page({
    if title != none {
        heading(level: 1, numbering: none, title)
    }

    body

    // hack to ensure that the page inserted is blank
    set page(numbering: none, header: none)
    pagebreak(weak: true, to: "odd")
})
