// deps
#import "deps.typ": hydra, subpar

// sections
#import "sections/titlepage.typ": titlepage
#import "sections/colophon.typ": colophon
#import "sections/part.typ": part
#import "sections/outlines.typ": _outlines-style

// elements
#import "elements/epigraph.typ": epigraph
#import "elements/block-quote.typ": block-quote

// misc
#import "headings.typ": _headings-style
#import "utils.typ": (
    centered-page, centered-section, footer, header, spaced-upper,
)

// extensions
#import "extensions/glossary.typ": abbreviations-theme
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

#let link-color = rgb("#3251A3")

#let thesis(figure-kinds: (image, table, raw), doc) = {
    show ref: it => {
        let el = it.element
        if el != none and el.func() == heading {
            text(fill: link-color, weight: "bold", it)
        } else if (
            el != none and (el.func() == figure or el.func() == math.equation)
        ) {
            text(fill: link-color, it)
        } else {
            it
        }
    }
    show link: it => {
        set text(fill: link-color)

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

    show: _headings-style.with(figure-kinds)

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

    show: _outlines-style.with(figure-kinds)

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

    show bibliography: centered-section

    doc
}

#let start-appendix = body => {
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
    align: top,
    show-sub-caption: (num, caption) => [
        #set text(size: 9pt)
        #strong(num) #caption.body
    ],
)
