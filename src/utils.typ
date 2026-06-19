#import "deps.typ": hydra

// unlike `smallcaps`, `upper` is not a element function, so it can't be targeted with show rule. This is a workaround to apply the same tracking to uppercased text.
#let caps(it) = text(
    tracking: 0.05em,
    spacing: 0.2em,
    upper(it),
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
