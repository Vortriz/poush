#import "../lib.typ": *

#import "@preview/glossy:0.8.0": *

#show: thesis.with(
    title: [Some Awesome Title],
    author: "John B Doe",
    degree: [Doctor of Sciences],
    major: [Computer Science],
    department: [Department of Computer Science],
    supervisors: (
        (
            name: [Great Professor],
            affiliation: [The University, \
                Faculty of Science and Technology, \
                Department of Computer Science
            ],
        ),
        (
            name: [Another Great Professor],
            affiliation: [External Company A/S],
        ),
    ),
    institution: [The University],
    logo: "/template/assets/logo.png",
    date: datetime(year: 2025, month: 6, day: 1),
    date-format: "[month repr:long] [day padding:zero], [year repr:full]",
    paper-size: "us-letter",
)

#show: init-glossary.with(yaml("chapters/glossary.yaml"))

@aa is a great.

@aar is also great.

@bb is nice.
#pagebreak()
#booktbl(
    columns: 7,
    header-rows: 2,
    // combine header cells
    cells((0, (1, 4)), colspan: 3, stroke: (bottom: 0.03em)),
    // table notes, remarks, and caption
    note((1, (1, 4)), [$m v$ is in kg·m².]),
    note((1, (3, 6)), [Time is in secs.]),
    note(sym.dagger, (2, 0), [Another note.]),
    remarks: [_Note:_ ] + lorem(18),
    caption: [This is a caption],
    note-fun: x => super(text(fill: blue, x)),
    note-numbering: "a",
    // content
    [],
    [tol $= mu_"single"$],
    [],
    [],
    [tol $= mu_"double"$],
    [],
    [],
    [],
    [$m v$],
    [Rel.~err],
    [Time],
    [$m v$],
    [Rel.~err],
    [Time],
    [trigmv],
    [11034],
    [1.3e-7],
    [3.9],
    [15846],
    [2.7e-11],
    [5.6],
    [trigexpmv],
    [21952],
    [1.3e-7],
    [6.2],
    [31516],
    [2.7e-11],
    [8.8],
    [trigblock],
    [15883],
    [5.2e-8],
    [7.1],
    [32023],
    [1.1e-11],
    [1.4e1],
    [expleja],
    [11180],
    [8.0e-9],
    [4.3],
    [17348],
    [1.5e-11],
    [6.6],
)
#block-quote(lorem(6))[
    1. #lorem(30)

    2. #lorem(40)

    3. #lorem(20)

    4. #lorem(80)
]

#lorem(82)

$ sin x = sum_(i=123456)^n n! $

@bb is nice.

1. #lorem(30)

2. #lorem(40)

3. #lorem(20)

#pagebreak()

#glossary(
    title: "Acronyms & Abbreviations",
    theme: acr-theme,
)
