#import "../deps.typ": subpar
#import "../globals.typ": figure-numbering, sub-figure-numbering

#let multifigure = subpar.grid.with(
    numbering: figure-numbering,
    numbering-sub-ref: sub-figure-numbering,
    align: top,
    show-sub-caption: (num, caption) => [
        #set text(size: 9pt)
        #strong(num) #caption.body
    ],
)
