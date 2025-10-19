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

#lorem(90)

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
