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
