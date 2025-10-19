#import "../utils/text.typ": caps

#let acr-theme = (
    // Main section
    // [TODO] style it
    section: (title, body) => {
        heading(level: 1, title)
        body
    },
    // Group of related terms
    group: (name, index, total, body) => {
        // index = group index, total = total groups
        show heading: it => {
            set text(weight: "regular")
            set block(above: 2.5em, below: 1.5em)
            caps(it)
        }
        if name != "" {
            heading(level: 2, name)
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
