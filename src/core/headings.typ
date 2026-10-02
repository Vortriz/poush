#import "part.typ": _part-style
#import "../utils.typ": spaced-upper

#let _headings-style(figure-kinds, doc) = {
    // helper function to select headings by level
    let heading-range(start, stop) = selector.or(
        ..range(start, stop, inclusive: true).map(l => heading.where(level: l)),
    )

    // not to justify block headings
    show heading-range(1, 4): set par(justify: false)

    // spacing between heading numbering and body
    show heading-range(2, 4): it => {
        if it.numbering != none {
            stack(
                dir: ltr,
                spacing: 1em,
                counter(heading).display(),
                it.body,
            )
        } else {
            it.body
        }
    }

    // no bookmarks for heading level > 3
    show heading-range(4, 6): set heading(bookmarked: false)

    // level 1 heading style (chapters)
    show heading.where(level: 1): set heading(supplement: [Chapter])
    show heading.where(level: 1): set block(below: 2.75em)
    show heading.where(level: 1): it => {
        pagebreak(weak: true, to: "odd")

        if it.body.func() == metadata {
            show: _part-style(it.body.value)
        } else {
            set align(center)
            set line(length: 100%, stroke: 0.5pt)
            set stack(dir: ttb, spacing: 1em)

            let styled-heading = (
                line(),
                text(size: 20.74pt, it.body),
                line(),
            )

            if it.numbering == none {
                stack(..styled-heading)
            } else {
                let num = context counter(heading).get().first()
                stack(
                    text(
                        size: 12pt,
                        weight: "regular",
                        smallcaps[#it.supplement #num],
                    ),
                    ..styled-heading,
                )
            }

            let counters = (
                ..figure-kinds.map(
                    kind => figure.where(kind: kind),
                ),
                math.equation,
            ).map(counter)

            for c in counters {
                c.update(0)
            }

            counter("marginalia-note").update(0)
        }
    }

    // level 2 headings are uppercased
    show heading.where(level: 2): set block(above: 2.5em, below: 1.5em)
    show heading.where(level: 2): it => text(
        size: 12pt,
        weight: "regular",
        spaced-upper(it),
    )

    // level 3 headings are slightly enlarged and italicized
    show heading.where(level: 3): set block(above: 2em, below: 1.25em)
    show heading.where(level: 3): set text(
        size: 12pt,
        style: "italic",
        weight: "regular",
        tracking: 0.01em,
    )

    // level 4 headings are italicized
    show heading.where(level: 4): set block(above: 2.25em, below: 1.25em)
    show heading.where(level: 4): set text(
        style: "italic",
        weight: "regular",
        tracking: 0.01em,
    )

    // level 5 headings are run-in
    show heading.where(level: 5): it => (
        block(below: 0em) + box(inset: (right: 0.8em), it.body)
    )

    doc
}
