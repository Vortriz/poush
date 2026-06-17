// `upper` is not a element function, so it can't be targeted with with show rule like `smallcaps`. This is a workaround to apply the same tracking to uppercased text.
#let caps(it) = text(
    tracking: 0.05em,
    spacing: 0.2em,
    upper(it),
)
