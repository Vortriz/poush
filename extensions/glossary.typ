#import "../utils/text.typ": caps

#let acr-theme = (
    // Main section
    section: (title, body) => {
        heading(level: 1, numbering: none, title)

        // to offset the extra space added by the first level 2 heading in the group
        v(-2.5em)

        body
    },
    // Group of related terms
    group: (name, index, total, body) => {
        // index = group index, total = total groups
        show heading: it => block(above: 2.5em, below: 1.5em)[
            #set text(weight: "regular")
            #caps(it)
        ]
        if name != "" {
            heading(level: 2, numbering: none, name)
        }
        body
    },
    // Individual glossary entry
    entry: (entry, index, total) => {
        // index = entry index, total = total entries in group
        set block(above: 0.6em, below: 0.6em)
        grid(
            columns: (auto, auto, 75%),
            column-gutter: 1em,
            strong(entry.short), repeat([.], gap: 0.3em), entry.long,
        )
    },
)
