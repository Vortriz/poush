#import "../lib.typ": thesis

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
