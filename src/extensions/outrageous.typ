#import "../deps.typ": i-figured, outrageous
#import "../utils.typ": caps
#import "../sections/centered.typ": centered-section

#let outline-fill = {
    set text(fill: black)
    set repeat(gap: 0.5em)
    set pad(left: 0.5em, right: 0.5em)
    pad(repeat([.]))
}

#let outline-presets = (
    toc: (
        font-weight: ("bold", "regular"),
        vspace: (1.6em, none),
        font: (auto,),
        fill: (none, outline-fill),
        gap: (1em,),
        fill-right-pad: 0em,
        fill-align: true,

        body-transform: (level, prefix, body) => {
            if body.func() == metadata {
                let val = body.value
                v(1em)
                text(
                    size: 9pt,
                    weight: 750,
                    tracking: 0.1em,
                )[
                    #box(width: 2em)[#smallcaps(upper(val.num))]
                    #smallcaps(upper(val.title))
                ]
            } else {
                body
            }
        },

        page-transform: (lvl, num) => {
            text(fill: black, num)
        },
    ),
    figures: (
        font-weight: (auto,),
        vspace: (0.6em, none),
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
                v(1em)
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
) = centered-section({
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
})
