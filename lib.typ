#import "sections/titlepage.typ": titlepage
#import "sections/glossary.typ": acr-theme

#import "utils/block-quote.typ": block-quote

#let thesis(
    // The title for your work.
    title: [Your Title],
    // Author.(has to be string type)
    author: "Author",
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
        )
    ),
    // The name of your institution.
    institution: none,
    // The path to logo of your institution.
    logo: none,
    // Date that will be displayed on cover page.
    // The value needs to be of the 'datetime' type.
    // More info: https://typst.app/docs/reference/foundations/datetime/
    date: datetime.today(),
    // Format in which the date will be displayed on cover page.
    // More info: https://typst.app/docs/reference/foundations/datetime/#format
    date-format: "[month repr:long] [day padding:zero], [year repr:full]",
    // The paper size to use.
    paper-size: "a4",
    // The content of your work.
    body,
) = {
    set document(title: title, author: author, date: if date != none {
        date
    } else {
        auto
    })

    set page(paper: paper-size)
    set text(size: 11pt, number-type: "old-style")
    set enum(indent: 1.1em)

    titlepage(
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
    )

    body
}
