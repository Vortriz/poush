#import "../utils/text.typ": caps

#let titlepage(
    // Title of the thesis.
    title: [Your Title],
    // Author name to be displayed
    author: [Author],
    // Date that will be displayed on cover page.
    // The value needs to be of the 'datetime' type.
    // More info: https://typst.app/docs/reference/foundations/datetime/
    date: datetime.today(),
    // Format in which the date will be displayed on cover page.
    // More info: https://typst.app/docs/reference/foundations/datetime/#format
    date-format: "[month repr:long] [day padding:zero], [year repr:full]",
    // The degree you are working towards
    degree: [Doctor of Sciences],
    // What field you are majoring in
    major: none,
    // The faculty and department at which you are working
    department: none,
    // The supervisor(s) for your work. Takes an array of [Name], [Affiliation]
    supervisors: (
        (
            name: [Supervisor Name],
            affiliation: [The University, \
                Faculty of Science and Technology, \
                Department of Computer Science],
        ),
    ),
    // The name of your institution.
    institution: none,
    // The path to logo of your institution.
    logo: none,
) = {
    set page(margin: (top: 3cm, bottom: 3cm, inside: 3cm, outside: 3cm))
    set align(center)
    show smallcaps: it => text(size: 13pt, it)

    v(0.5fr)

    par(leading: 1.5em, text(size: 14.4pt, caps(title)))

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
