#import "@preview/tblr:0.4.1": *

#let booktbl = tblr.with(
    stroke: none,
    column-gutter: 0.6em,
    // booktabs style rules
    rows(within: "header", auto, inset: (y: 0.5em)),
    rows(within: "header", auto, align: center),
    hline(within: "header", y: 0, stroke: 0.08em),
    hline(within: "header", y: end, position: bottom, stroke: 0.05em),
    rows(within: "body", 0, inset: (top: 0.5em)),
    hline(y: end, position: bottom, stroke: 0.08em),
    rows(end, inset: (bottom: 0.5em)),
)
