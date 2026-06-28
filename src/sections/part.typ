#let section_counter = counter("section_counter")

#let create-part(title) = {
    section_counter.step()

    context {
        let num = section_counter.display("I.")
        heading(numbering: none)[#metadata((num: num, title: title))]
    }
}
