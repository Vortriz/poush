// deps
#import "deps.typ": hydra

// sections
#import "sections/titlepage.typ": titlepage
#import "sections/centered.typ": centered-page, centered-section
#import "sections/colophon.typ": colophon

// elements
#import "elements/epigraph.typ": epigraph
#import "elements/block-quote.typ": block-quote

// utils
#import "utils.typ": caps, footer, header

// extensions
#import "extensions/glossary.typ": acr-theme
#import "extensions/outrageous.typ": create-outline, i-figured, outline-presets
#import "extensions/marginalia.typ": (
    aside, marginalia, marginalia-quote, normal-figure, sideimage, sidenote,
    wide-figure, wideblock,
)
#import "extensions/tblr.typ": booktbl, tabular


#let thesis = doc => {
    set text(
        size: 11pt,
        number-type: "old-style",
    )

    set heading(numbering: "1.1")
    set enum(indent: 1.1em)

    let href-color = rgb("#3251A3")
    show link: it => text(fill: href-color, it)
    show ref: it => {
        set text(fill: href-color, weight: "bold") if (
            it.element != none and it.element.func() == heading
        )
        it
    }

    // for spacing between heading numbering and body
    // for heading level > 2
    show heading: it => block({
        if it.numbering != none {
            grid(
                columns: (auto, 1fr),
                inset: (right: 1em),
                counter(heading).display(), it.body,
            )
        } else {
            it.body
        }
    })

    show heading: set par(justify: false)

    // level 1 heading style (sections)
    show heading.where(level: 1): set heading(supplement: [Chapter])
    show heading.where(level: 1): set block(below: 2.75em)
    show heading.where(level: 1): it => {
        {
            set page(header: none)
            pagebreak(weak: true, to: "odd")
        }

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
    }

    // level 2 headings are uppercased
    show heading.where(level: 2): set block(above: 2.5em, below: 1.5em)
    show heading.where(level: 2): it => {
        set text(
            size: 12pt,
            weight: "regular",
        )
        caps(it)
    }

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
    show heading.where(level: 4): set heading(bookmarked: false)
    show heading.where(level: 4): set text(
        style: "italic",
        weight: "regular",
        tracking: 0.01em,
    )

    // level 5 headings are run-in
    show heading.where(level: 5): set heading(bookmarked: false)
    show heading.where(level: 5): it => (
        block(below: 0em) + box(inset: (right: 0.8em), it.body)
    )

    show heading.where(level: 6): set heading(bookmarked: false)

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

    // marginalia setup
    show: marginalia.setup.with(
        book: true,
        top: 4cm,
        bottom: 2.88cm,
        inner: (far: 2.75cm, width: 0cm, sep: 0cm),
        outer: (far: 2.25cm, width: 4.7cm, sep: 0.8cm),
    )

    set page(
        header: {
            show: wideblock.with(side: "both")
            header
        },
        footer: footer,
        footer-descent: 1em,
    )
    show smallcaps: it => text(tracking: 0.05em, it)
    set par(
        justify: true,
        leading: 0.56em,
        spacing: 1.1em,
        first-line-indent: 1.5em,
    )
    doc
}
