// unlike `smallcaps`, `upper` is not a element function, so it can't be targeted with show rule. This is a workaround to apply the same tracking to uppercased text.
#let caps(it) = text(
    tracking: 0.05em,
    spacing: 0.2em,
    upper(it),
)

// margins for centered page geometry
// used in frontmatter and backmatter
#let centered-geometry = (
    top: 4.5cm,
    bottom: 3.5cm,
    inside: 3cm,
    outside: 3cm,
)
