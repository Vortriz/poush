// deps
#import "deps.typ": hydra, subpar

// sections
#import "sections/titlepage.typ": titlepage
#import "sections/centered.typ": centered-page, centered-section
#import "sections/colophon.typ": colophon
#import "sections/part.typ": create-part

// elements
#import "elements/epigraph.typ": epigraph
#import "elements/block-quote.typ": block-quote

// utils
#import "utils.typ": caps, footer, header

// extensions
#import "extensions/glossary.typ": acr-theme
#import "extensions/outrageous.typ": create-outline, outline-presets
#import "extensions/marginalia.typ": (
    aside, marginalia, marginalia-quote, normal-figure, sideimage, sidenote,
    wide-figure, wideblock,
)
#import "extensions/tblr.typ": booktbl, tabular


#let sub-figure-numbering = (super, sub) => numbering(
    "1.1a",
    counter(heading).get().first(),
    super,
    sub,
)
#let figure-numbering = super => numbering(
    "1.1",
    counter(heading).get().first(),
    super,
)
#let equation-numbering = super => numbering(
    "(1.1)",
    counter(heading).get().first(),
    super,
)

#let thesis = doc => {
    let href-color = rgb("#3251A3")
    show ref: it => {
        let el = it.element
        if el != none and el.func() == heading {
            text(fill: href-color, weight: "bold", it)
        } else {
            it
        }
    }
    show link: it => {
        set text(fill: href-color)

        let icon-path = "assets/external_link.svg"
        if type(it.dest) == str and not repr(it.body).contains(icon-path) {
            link(
                it.dest,
                {
                    it.body
                    box(
                        image(icon-path),
                        height: 0.5em,
                        inset: (left: 0.15em),
                    )
                },
            )
        } else {
            it
        }
    }

    // helper function to select headings by level
    let headings(start, stop) = selector.or(
        ..range(start, stop, inclusive: true).map(l => heading.where(level: l)),
    )

    // not to justify block headings
    show headings(1, 4): set par(justify: false)

    // spacing between heading numbering and body
    show headings(2, 4): it => {
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
    show headings(4, 6): set heading(bookmarked: false)

    // level 1 heading style (chapters)
    show heading.where(level: 1): set heading(supplement: [Chapter])
    show heading.where(level: 1): set block(below: 2.75em)
    show heading.where(level: 1): it => {
        {
            set page(header: none)
            pagebreak(weak: true, to: "odd")
        }

        if it.body.func() == metadata {
            let val = it.body.value
            centered-page[
                #set page(footer: none)
                #set align(center + horizon)
                #set stack(spacing: 0.75em)
                #show: smallcaps

                #stack(
                    upper(
                        text(size: 9pt, tracking: 0.1em, weight: "bold")[
                            Part #val.num.slice(0, -1)
                        ],
                    ),
                    line(length: 10%, stroke: 0.025em),
                    upper(
                        text(size: 14pt, tracking: 0.1em, weight: "regular")[
                            #val.title
                        ],
                    ),
                )
            ]
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

            let figures = (image, table, raw).map(
                kind => figure.where(kind: kind),
            )
            let counters = (..figures, math.equation).map(counter)

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
        caps(it),
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

    // Tables have captions on top
    show figure.where(kind: table): set figure.caption(position: top)

    show figure.caption: it => {
        set text(size: 9pt)
        set par(justify: true)
        set align(left)

        context (
            strong[#it.supplement #it.counter.display(it.numbering)]
                + [: ]
                + it.body
        )
    }

    // marginalia setup
    show: marginalia.setup.with(
        book: true,
        top: 4cm,
        bottom: 2.88cm,
        inner: (far: 2.75cm, width: 0cm, sep: 0cm),
        outer: (far: 2.25cm, width: 4.7cm, sep: 0.8cm),
    )

    set page(
        header: wideblock(side: "both", header),
        footer: footer,
        footer-descent: 1em,
    )

    set heading(numbering: "1.1.1.1")

    set text(
        size: 11pt,
        number-type: "old-style",
    )

    set par(
        justify: true,
        leading: 0.56em,
        spacing: 1.1em,
        first-line-indent: 1.5em,
    )

    set figure(numbering: figure-numbering)
    set math.equation(numbering: equation-numbering)

    show smallcaps: set text(tracking: 0.05em)

    set enum(indent: 1.1em)

    doc
}

#let start-appendix(body) = {
    context {
        let current-array = counter(heading).get()
        counter(heading).update((current-array.at(0), 0))
    }
    set heading(numbering: "1.A.1.1")
    body
}

#let multifigure = subpar.grid.with(
    numbering: figure-numbering,
    numbering-sub-ref: sub-figure-numbering,
)
