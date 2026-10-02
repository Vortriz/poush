#let section_counter = counter("section_counter")

#let part = title => {
    section_counter.step()

    context {
        let num = section_counter.display("I.")
        heading(
            numbering: none,
            metadata((num: num, title: title)),
        )
    }
}

#let _part-style = val => {
    set page(margin: 0cm)
    set align(center + horizon)
    set text(weight: "regular", bottom-edge: "descender")
    show: it => smallcaps(it)

    stack(
        spacing: 0.5em,
        text(size: 11pt, lower[Part #val.num.slice(0, -1)]),
        line(length: 2.25em, stroke: 0.025em),
        text(size: 12pt, upper(val.title)),
    )
}
