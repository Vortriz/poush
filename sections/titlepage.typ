#import "../utils.typ": caps
#import "centered.typ": centered-section

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
    degree: [Doctor of Sciences],
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
) = centered-section({
    set align(center)
    show smallcaps: it => text(size: 1.1em, it)

    v(0.25fr)

    par(
        leading: 1.5em,
        text(
            size: 1.3em,
            caps(title),
        ),
    )

    v(1fr)

    [
        A thesis submitted to attain the degree of \
        #smallcaps(degree) \
    ]

    v(1fr)

    [
        presented by \
        #smallcaps(author) \
    ]

    if date != none [
        #date.display(date-format)
    ]

    v(1fr)

    [
        accepted on the recommendation of \
        #for supervisor in supervisors [
            #smallcaps(supervisor.name) \
        ]
    ]

    v(1fr)

    if institution != none [
        #smallcaps(institution)
    ]
})
