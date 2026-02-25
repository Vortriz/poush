#import "sections/outlines.typ": *
#import "sections/glossary.typ": acr-theme
#import "sections/titlepage.typ": titlepage

#import "utils/block-quote.typ": block-quote
#import "utils/tables.typ": *

#let thesis(
    // For document metadata.
    // https://typst.app/docs/reference/model/document/
    metadata: (
        title: none,
        author: (),
        description: none,
        keywords: (),
        date: auto,
    ),

    // The paper size to use.
    paper-size: "a4",

    // The title page of the thesis.
    titlepage: titlepage(),

    // Frontmatter of thesis.
    // Contains abstract, ToC, etc.
    // Pages are arranged as in the specified order.
    frontmatter: (
        create-outline(
            preset: outline-presets.toc,
            kind: none,
        ),
    ),

    // The content of your work.
    body,
) = {
    set document(..metadata)

    set page(paper: paper-size)
    set text(size: 11pt, number-type: "old-style")
    set enum(indent: 1.1em)
    // set outline(indent: auto)

    set heading(numbering: "1.1")

    let href-color = rgb("#3251A3")
    show link: it => text(fill: href-color, it)
    show ref: it => {
        set text(fill: href-color, weight: "bold") if (
            it.element != none and it.element.func() == heading
        )
        it
    }

    // section heading style
    show heading.where(level: 1): set heading(supplement: [Chapter])
    show heading.where(level: 1): it => context {
        set align(center)
        set line(length: 100%, stroke: 0.5pt)
        set stack(dir: ttb, spacing: 1em)
        pagebreak(weak: true, to: "odd")

        let styled-heading = (
            line(),
            text(size: 20.74pt, it.body),
            line(),
        )

        if it.numbering == none {
            stack(..styled-heading)
        } else {
            let num = counter(heading).get().first()
            stack(
                text(size: 12pt, weight: "regular", smallcaps(
                    [#it.supplement #num],
                )),
                ..styled-heading,
            )
        }
        v(2em)
    }

    // show to table caption on top with left alignment and bold supplement
    show figure.where(kind: "i-figured-table"): tbl => {
        set figure.caption(position: top)
        show figure.caption: cpt => {
            set align(left)
            let heading_counter = context counter(heading).get().first()
            let val = context cpt.counter.get().first()
            strong[Table #heading_counter.#val: ] + cpt.body
        }
        tbl
    }

    // apply the show rules (these can be customized)
    show heading: i-figured.reset-counters
    show figure: i-figured.show-figure

    // Pages start here
    set pagebreak(weak: true, to: "odd")

    {
        titlepage
        pagebreak()
    }

    set page(numbering: "i")
    for item in frontmatter {
        item
        pagebreak()
    }

    show smallcaps: it => text(tracking: 0.05em, it)

    {
        set page(numbering: "1")
        set pagebreak(weak: false, to: none)
        body
    }
}
