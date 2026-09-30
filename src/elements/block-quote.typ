#let block-quote(source, body) = grid(
    columns: 3,
    align: (horizon, auto),
    inset: (x: 2mm),
    rotate(
        -90deg,
        reflow: true,
        text(
            font: "Open Sans",
            size: 7pt,
            fill: luma(50%),
        )[cited from #source],
    ),
    grid.vline(stroke: 1.5pt + luma(50%)),
    grid.cell(
        inset: (y: 1.5mm),
        {
            set enum(indent: 0.5em)
            set list(indent: 0.5em)

            text(fill: luma(70), body)
        },
    ),
)
