#let titlepage(
    title,
    author,
    degree,
    major,
    department,
    supervisors,
    date,
    date-format,
) = {
    set page(margin: (top: 3cm, bottom: 3cm, inside: 3cm, outside: 3cm))
    set align(center)
    set par(leading: 1.5em)

    v(0.75fr)

    par(text(size: 14.4pt, tracking: 0.4pt, upper(title)))

    v(1fr)

    (
        par[
            A thesis submitted to attain the degree of \
            #text(size: 13pt, (smallcaps(degree))) \
        ]
            + if major != none [
                with a major in \
                #text(size: 13pt, (smallcaps(major))) \
            ]
            + if department != none [
                at the \
                #text(size: 13pt, (smallcaps(department))) \
            ]
    )

    v(1fr)

    par[
        presented by \
        #text(size: 13pt, (smallcaps(author)))
    ]

    v(1fr)

    let supervisors-names = for supervisor in supervisors [
        #supervisor.name \
    ]

    par[accepted on the recommendation of]

    par(leading: 0.65em, supervisors-names)

    v(0.75fr)

    if date != none {
        par(date.display(date-format))
    }
}
