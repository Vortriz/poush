#import "../deps.typ": marginalia, note, notefigure, wideblock

// regular margin note
#let sidenote = note.with(
    side: "outer",
    flush-numbering: true,
    numbering: (..i) => super(
        size: 5pt,
        numbering("1", ..i),
    ),
    text-style: (size: 8pt),
    par-style: (justify: false),
)

// asides (they don't need numbering)
#let aside = note.with(
    side: "outer",
    counter: none,
    text-style: (size: 8pt),
    par-style: (justify: false),
)

// quote in the margin
#let marginalia-quote(quote, author, source: none) = note(
    side: "outer",
    counter: none,
    text-style: (size: 8pt),
    par-style: (justify: false, spacing: 0.8em),
)[
    "#quote"

    #align(right)[
        #sym.dash.em #author,
        #if source != none {
            emph(source)
        }
    ]
]

// we are not using `notefigure` because there seems to be no way to set that figure's numbering to `none`.
// if we had used `notefigure`, then it would appear in the list of figures and get numbered, which is not what we want for side images.
#let sideimage(img, caption: none) = note(
    side: "outer",
    numbering: none,
    counter: none,
    text-style: (size: 8pt),
    par-style: (justify: false),
    {
        img

        if caption != none {
            text(size: 8pt, caption)
        }
    },
)

// normal figures will have captions in the margin with bottom-aligned captions
#let normal-figure(..kwargs) = {
    set figure(gap: 0pt)
    set figure.caption(position: bottom)
    show figure.caption.where(position: bottom): note.with(
        alignment: "bottom",
        counter: none,
        shift: "avoid",
        keep-order: true,
    )
    place(
        top,
        float: true,
        clearance: 3em,
        figure(..kwargs),
    )
}

// wide figures will span into the margin, and their captions will be at the normal position (below the figure)
#let wide-figure(..kwargs) = place(
    top,
    float: true,
    clearance: 3em,
    wideblock(figure(..kwargs)),
)
