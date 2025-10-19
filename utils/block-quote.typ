#let block-quote(source, body) = grid(
    columns: 3,
    align: (horizon, auto),
    inset: (x: 2mm),
    // [TODO] as much as I understand, the TeX template uses the default Sans Serif font
    rotate(-90deg, reflow: true, text(
        font: "Open Sans",
        size: 7pt,
        fill: luma(50%),
    )[cited from #source]),
    grid.vline(stroke: 1.5pt + luma(50%)),
    grid.cell(
        inset: (left: 0pt, y: 1.5mm),
        text(fill: luma(70), body),
    ),
)
