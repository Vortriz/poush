#import "@preview/outrageous:0.4.1"
#import "@preview/i-figured:0.2.4"

#import "../utils.typ": caps, centered-geometry

#let outline-fill = {
    set text(fill: black)
    set repeat(gap: 0.5em)
    set pad(left: 0.5em, right: 0.5em)
    pad(repeat([.]))
}

#let outline-presets = (
    toc: (
        font-weight: ("bold", "regular"),
        vspace: (1.75em, none),
        font: (auto,),
        fill: (none, outline-fill),
        gap: (1em,),
        fill-right-pad: 0em,
        fill-align: true,
        prefix-transform: (lvl, prefix) => {
            for i in "IVXLCDM" {
                if type(prefix) == content and prefix.text.contains(i) {
                    []
                }
            }
        },
        body-transform: (lvl, prefix, body) => {
            for i in "IVXLCDM" {
                if type(prefix) == content and prefix.text.contains(i) {
                    set text(weight: "bold", size: 0.8em)
                    v(0pt)
                    h(-2em)
                    caps([#prefix #h(1em) #body])
                }
            }
        },
        page-transform: (lvl, num) => {
            text(fill: black, num)
        },
    ),
    figures: (
        font-weight: (auto,),
        vspace: (none,),
        font: (auto,),
        fill: (outline-fill,),
        gap: (auto,),
        fill-right-pad: 0em,
        fill-align: true,
        prefix-transform: (lvl, prefix) => {
            let (supplement, _, number) = prefix.children
            let v = if (
                number.text.ends-with(regex("[^\d]1[^\d]*"))
                    and not number.text.starts-with("1")
            ) {
                v(10pt)
            }
            box[#v#number]
        },
        page-transform: (lvl, num) => {
            text(fill: black, num)
        },
    ),
)

#let create-outline(
    preset: outline-presets.figures,
    title: [List of Figures],
    kind: image,
) = {
    set page(
        margin: centered-geometry,
        footer-descent: 0.5em,
    )
    show outline: set heading(outlined: true)
    show outline.entry: outrageous.show-entry.with(..preset)
    let parts-and-headings = figure
        .where(kind: "part", outlined: true)
        .or(heading.where(outlined: true))

    if kind != none {
        i-figured.outline(title: title, target-kind: kind)
    } else {
        // title is ignored if kind is none
        // because we want typst to automatically set it based on text language
        outline(target: parts-and-headings)
    }

    // hack to ensure that the page inserted is blank
    set page(numbering: none)
    pagebreak(weak: true, to: "odd")
}
