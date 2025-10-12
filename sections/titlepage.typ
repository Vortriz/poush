#let titlepage(
    title,
    author,
    degree,
    major,
    department,
    supervisors,
    institution,
    logo,
    date,
    date-format,
) = {
    set page(margin: (top: 3cm, bottom: 3cm, inside: 3cm, outside: 3cm))
    set align(center)
    show smallcaps: it => text(size: 13pt, it)

    v(0.5fr)

    par(text(size: 14.4pt, tracking: 0.4pt, upper(title)))

    v(1fr)

    (
        [
            A thesis submitted to attain the degree of \
            #smallcaps(degree) \
        ]
            + if major != none [
                with a major in \
                #smallcaps(major) \
            ]
            + if department != none [
                at the \
                #smallcaps(department) \
            ]
    )

    v(1fr)

    par[
        presented by \
        #smallcaps(author) \
    ]

    if date != none {
        par(date.display(date-format))
    }

    v(1fr)

    par(
        [
            accepted on the recommendation of \
        ]
            + for supervisor in supervisors [
                #smallcaps(supervisor.name) \
            ],
    )

    v(1fr)

    if logo != none {
        image(logo, height: 5cm)
    }

    if institution != none {
        par(smallcaps(institution))
    }
}
