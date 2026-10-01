#import "deps.typ": hydra
#import "globals.typ": (
    equation-numbering, figure-numbering, link-color, sub-figure-numbering,
)
#import "utils.typ": (
    centered-page, centered-section, footer, header, spaced-upper,
)

#import "core/colophon.typ": colophon
#import "core/figures.typ": _figures-style
#import "core/headings.typ": _headings-style
#import "core/outlines.typ": _outlines-style
#import "core/part.typ": part
#import "core/titlepage.typ": titlepage

#import "elements/block-quote.typ": block-quote
#import "elements/epigraph.typ": epigraph

#import "extensions/glossary.typ": abbreviations-theme
#import "extensions/marginalia.typ": (
    aside, marginalia, marginalia-quote, normal-figure, sideimage, sidenote,
    wide-figure, wideblock,
)
#import "extensions/subpar.typ": multifigure, subpar
#import "extensions/tblr.typ": booktbl, tabular


#let thesis(figure-kinds: (image, table, raw), doc) = {
    set page(
        paper: "us-letter",
        header: wideblock(side: "both", header),
        footer: footer,
        footer-descent: 1em,
    )

    show: marginalia.setup.with(
        book: true,
        top: 4cm,
        bottom: 2.88cm,
        inner: (far: 2.75cm, width: 0cm, sep: 0cm),
        outer: (far: 2.25cm, width: 4.7cm, sep: 0.8cm),
    )

    show: _outlines-style.with(figure-kinds)

    show: _headings-style.with(figure-kinds)

    show: _figures-style

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

    show smallcaps: set text(tracking: 0.05em)

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

    set math.equation(numbering: equation-numbering)

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

#let front-matter = body => {
    set page(numbering: "i")

    body
}

#let main-matter = body => {
    set page(numbering: "1")
    counter(page).update(1)

    body
}

#let back-matter = body => {
    set heading(numbering: none)

    body
}
