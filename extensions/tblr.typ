#import "@preview/tblr:0.5.0" as tabular

#let booktbl = tabular.tblr.with(
    stroke: none,
    column-gutter: 0.6em,
    // booktabs style rules
    tabular.rows(within: "header", auto, inset: (y: 0.5em)),
    tabular.rows(within: "header", auto, align: center),
    tabular.hline(within: "header", y: 0, stroke: 0.08em),
    tabular.hline(within: "header", y: end, stroke: 0.05em),
    tabular.rows(within: "body", 0, inset: (top: 0.5em)),
    tabular.hline(y: end, stroke: 0.08em),
    tabular.rows(end, inset: (bottom: 0.5em)),
)
