#import "../lib.typ": *

#import "@preview/glossy:0.8.0": *

#let info = (
    title: "Some Awesome Title",
    author: "John B Doe",
    date: datetime(year: 2025, month: 6, day: 1),
)
#set outline(depth: 2)

#show: thesis.with(
    // Document's metadata
    metadata: (
        title: info.title,
        author: (info.author),
        description: [An awesome description of the thesis.],
        keywords: ("thesis", "science"),
        date: info.date,
    ),

    paper-size: "us-letter",

    titlepage: titlepage(
        title: info.title,
        author: info.author,
        date: info.date,
        degree: [Doctor of Sciences],
        major: [Computer Science],
        department: [Department of Computer Science],
        supervisors: (
            (
                name: [Great Professor],
                affiliation: [The University, \
                    Faculty of Science and Technology, \
                    Department of Computer Science
                ],
            ),
            (
                name: [Another Great Professor],
                affiliation: [External Company A/S],
            ),
        ),
        institution: [The University],
        logo: "/template/assets/logo.png",
    ),

    frontmatter: (
        colophon[This dissertation was prepared with Typst using #link("https://github.com/Vortriz/poush", [Poush]) template. The main text is set in Libertinus Serif. The monospace font is `DejaVu Sans Mono`.],

        // Abstract
        generic-section(title: [Abstract], body: [
            #set par(justify: true)
            #lorem(700)
        ]),

        // ToC
        create-outline(
            preset: outline-presets.toc,
            kind: none,
        ),

        // List of figures
        create-outline(
            preset: outline-presets.figures,
            title: [List of Figures],
        ),

        // List of tables
        create-outline(
            preset: outline-presets.figures,
            title: [List of Tables],
            kind: table,
        ),

        // List of listings
        create-outline(
            preset: outline-presets.figures,
            title: [List of Listings],
            kind: raw,
        ),
    ),

    backmatter: (
        generic-section(
            title: [Used Software & Generative AI Declaration ],
            body: [#lorem(200)],
        ),
        generic-section(title: [Acknowledgements], body: [#lorem(300)]),
    ),
)

#show: init-glossary.with(yaml("chapters/glossary.yaml"))



#pagebreak()
= Introduction
See @my-chapter, @my-section, @my-subsection, @fig:my-figure, @tbl:my-table, and @lst:my-listing.

== High-contrast Imaging

=== Atmospheric influences, adaptive optics, and speckles

==== Transmission, emission, and atmospheric windows <bs>

===== Dark frame subtraction
#lorem(30)

@bs

@aa is a great.

@aar is also great.

@bb is nice.


#pagebreak()
#booktbl(
    columns: 7,
    header-rows: 2,
    // combine header cells
    cells((0, (1, 4)), colspan: 3, stroke: (bottom: 0.03em)),
    // table notes, remarks, and caption
    note((1, (1, 4)), [$m v$ is in kg·m².]),
    note((1, (3, 6)), [Time is in secs.]),
    note(sym.dagger, (2, 0), [Another note.]),
    remarks: [_Note:_ ] + lorem(18),
    caption: [This is a caption],
    note-fun: x => super(text(fill: blue, x)),
    note-numbering: "a",
    // content
    [],
    [tol $= mu_"single"$],
    [],
    [],
    [tol $= mu_"double"$],
    [],
    [],
    [],
    [$m v$],
    [Rel.~err],
    [Time],
    [$m v$],
    [Rel.~err],
    [Time],
    [trigmv],
    [11034],
    [1.3e-7],
    [3.9],
    [15846],
    [2.7e-11],
    [5.6],
    [trigexpmv],
    [21952],
    [1.3e-7],
    [6.2],
    [31516],
    [2.7e-11],
    [8.8],
    [trigblock],
    [15883],
    [5.2e-8],
    [7.1],
    [32023],
    [1.1e-11],
    [1.4e1],
    [expleja],
    [11180],
    [8.0e-9],
    [4.3],
    [17348],
    [1.5e-11],
    [6.6],
)
#block-quote(lorem(6))[
    1. #lorem(30)

    2. #lorem(20)

    3. #lorem(80)
]
#figure([a], caption: [Steps of compilation. (altered)])
#pagebreak()
== Publications
#figure(
    [```rush fn fib(n: int) -> int {}```],
    caption: [Generating Fibonacci numbers using rush.],
) <my-listing>
=== Features
#pagebreak()
#figure(
    table(),
    caption: [Lines of code of the project's components in commit '`f8b9b9a`'.],
)
#pagebreak()
#figure(
    table(),
    caption: [Most important features of the rush programming language.],
)
#figure(
    table(),
    caption: [Data types in the rush programming language.],
) <my-table>
#pagebreak()
= Exoplanets, a primer <my-chapter>
== Lexical and Syntactical Analysis <my-section>
=== Formal Syntactical Definition by a Grammer <my-subsection>
#figure(
    [```rust fn main() {}```],
    caption: [Grammar for basic arithmetic in EBNF notation.],
)
=== Grouping Characters Into Tokens
#pagebreak()
#figure(
    [```rust fn main() {}```],
    caption: [The rush '`Lexer`' struct definition.],
)
#figure(table(), caption: [Advancing window of a lexer.])
#pagebreak()
#figure(
    [```rust fn main() {}```],
    caption: [Simplified '`Token`' struct definition.],
)
=== Constructing a Tree
#figure([a], caption: [Abstract syntax tree for '`1+2**3`'.]) <my-figure>
#pagebreak()
#figure(table(), caption: [Mapping from EBNF grammar to Rust type definitions.])
==== Operator Precedence
#figure(
    [```rust fn main() {}```],
    caption: [Example language a traditional LL(1) parser cannot parse.],
)
#pagebreak()
==== Pratt Parsing
#figure(
    [a],
    caption: [Abstract syntax tree for '`1+2**3`' using Pratt parsing.],
)
#pagebreak()
#figure(
    [```rust fn main() {}```],
    caption: [Pratt-parser: Implementation for token precedences.],
)
#figure(
    [```rust fn main() {}```],
    caption: [Pratt-parser: Implementation for expressions.],
)
#pagebreak()
#figure(
    [```rust fn main() {}```],
    caption: [Pratt-parser: Implementation for grouped expressions.],
)
#figure(
    [```rust fn main() {}```],
    caption: [Pratt-parser: Implementation for infix-expressions.],
)
#figure([a], caption: [Token precedences for the input '`(1+2*3)/4**5`'.])
#pagebreak()
==== Parser Generators
== Semantic Analysis
=== Defining the Semantics of a Programming Language
=== The Semantic Analyzer
#pagebreak()
#figure(
    [```rust fn main() {}```],
    caption: [A rush program which adds two integers.],
)
==== Implementation
#pagebreak()
#figure(
    [```rust fn main() {}```],
    caption: [Fields of the '`Analyzer`' struct.],
)
#figure(
    [```rust fn main() {}```],
    caption: [Output when compiling an invalid rush program.],
)
#pagebreak()
#figure(
    [```rust fn main() {}```],
    caption: [Analyzer: Validation of the '`main`' function's signature.],
)
#pagebreak()
#figure(
    [```rust fn main() {}```],
    caption: [Analyzer: The '`let_stmt`' method.],
)
#pagebreak()
#figure(
    [```rust fn main() {}```],
    caption: [Analyzer: Analysis of expressions during semantic analysis.],
)
#figure(
    [```rust fn main() {}```],
    caption: [Analyzer: Obtaining the type of expressions.],
)
#pagebreak()
#figure(
    [```rust fn main() {}```],
    caption: [Analyzer: Validation of argument type compatibility.],
)
#pagebreak()
#figure(
    [```rust fn main() {}```],
    caption: [Analyzer: Determining whether an expression is constant.],
)
==== Early Optimizations
#figure(
    [```rust fn main() {}```],
    caption: [Redundant '`while`' loop inside a rush program.],
)
#pagebreak()
#figure([```rust fn main() {}```], caption: [Analyzer: Loop optimization.])
#figure([a], caption: [How semantic analysis affects the abstract syntax tree.])
#figure([a], caption: [How semantic analysis affects the abstract syntax tree.])
#figure([a], caption: [How semantic analysis affects the abstract syntax tree.])
#figure([a], caption: [How semantic analysis affects the abstract syntax tree.])
#figure([a], caption: [How semantic analysis affects the abstract syntax tree.])
#figure([a], caption: [How semantic analysis affects the abstract syntax tree.])
#figure([a], caption: [How semantic analysis affects the abstract syntax tree.])
#figure([a], caption: [How semantic analysis affects the abstract syntax tree.])
#figure([a], caption: [How semantic analysis affects the abstract syntax tree.])
#pagebreak()

= Interpreting the Program
== Tree-Walking Interpreters
#figure(
    [```rust fn main() {}```],
    caption: [Tree-walking interpreter: Type definitions.],
)
#pagebreak()
=== Implementation
#figure(
    [```rust fn main() {}```],
    caption: [Tree-walking interpreter: '`Value`' and '`InterruptKind`' definitions.],
)
=== How the Interpreter Executes a Program
#figure(
    [a],
    caption: [Call stack at the point of processing the '`return`' statement.],
)
#pagebreak()
#figure(
    [```rust fn main() {}```],
    caption: [Tree-walking interpreter: Beginning of execution.],
)
#figure(
    [```rust fn main() {}```],
    caption: [Tree-walking interpreter: Calling of functions.],
)
#pagebreak()
#figure([```rust fn main() {}```], caption: [Example rush program.])
=== Supporting Pointers
#pagebreak()
== Using a Virtual Machine
=== Defining a Virtual Machine
#pagebreak()
#figure([```rust fn main() {}```], caption: [Struct definition of the VM.])
=== Register-Based and Stack-Based Machines
=== The rush Virtual Machine
#pagebreak()
#figure([```rust fn main() {}```], caption: [Minimal pointer example in rush.])
#figure([a], caption: [Linear memory of the rush VM.])
#pagebreak()
#figure(
    [```rust fn main() {}```],
    caption: [VM instructions for the minimal pointer example.],
)
=== How the Virtual Machine Executes a rush Program
#figure(
    [```rust fn main() {}```],
    caption: [A recursive rush program.],
) <recursive-rush-program>
#figure(
    [```rust fn main() {}```],
    caption: [Struct definition of a '`CallFrame`'.],
)
#pagebreak()
#figure([a], caption: [Example call stack of the rush VM.])
#figure(
    [```rust fn main() {}```],
    caption: [VM instructions matching the AST in @fig:ast-and-vm-instructions.],
)
#pagebreak()
=== Fetch-Decode-Execute Cycle of the VM
#figure(
    [```rust fn main() {}```],
    caption: [The '`run`' method of the rush VM.],
)
#pagebreak()
#figure(
    [```rust fn main() {}```],
    caption: [Parts of the '`run_instruction`' method of the rush VM.],
)
#pagebreak()
=== Comparing the VM to the Tree-Walking Interpreter
#figure(
    [a],
    caption: [AST and VM instructions of the recursive rush program in @lst:recursive-rush-program.],
) <ast-and-vm-instructions>
#pagebreak()
#pagebreak()
= Compiling to High-Level Targets
== How a Compiler Translates the AST
#figure([a], caption: [Abstract syntax tree for '`1 + 2 < 4`'.])
#pagebreak()
== The Compiler Targeting the rush VM
#pagebreak()
#pagebreak()
#pagebreak()
#pagebreak()
== Compilation to WebAssembly
=== WebAssembly Modules
#pagebreak()
#pagebreak()
=== The WebAssembly System Interface
#pagebreak()
=== Implementation
#pagebreak()
==== Function Calls
==== Logical Operators
#pagebreak()
=== Considering an Example rush Program
#pagebreak()
#pagebreak()
== Using LLVM for Code Generation
=== The Role of LLVM in a Compiler
#figure([a], caption: [Steps of compilation when using LLVM.])
=== The LLVM Intermediate Representation
#pagebreak()
==== Structure of a Compiled rush Program
#pagebreak()
#pagebreak()
=== The rush Compiler Using LLVM
#pagebreak()
#pagebreak()
#pagebreak()
#pagebreak()
#pagebreak()
=== Final Code Generation: The Linker
#figure([a], caption: [The linking process.])
#pagebreak()
=== Conclusions
#pagebreak()
== Transpilers
#pagebreak()
= Compiling to Low-Level Targets
== Low-Level Programming Concepts
=== Sections of an ELF File
=== Assemblers and Assembly Language
#pagebreak()
#figure([a], caption: [Level of abstraction provided by assembly.])
=== Registers
#pagebreak()
#figure([a], caption: [Relationship between registers, memory, and the CPU.])
#pagebreak()
=== Using Memory: The Stack
==== Alignment
#figure([a], caption: [Examples of memory alignment.])
#pagebreak()
=== Calling Conventions
#pagebreak()
=== Referencing Variables Using Pointers
#pagebreak()
#pagebreak()
== RISC-V: Compiling to a RISC Architecture
#figure(table(), caption: [Registers of the RISC-V architecture.])
=== Register Layout
#pagebreak()
=== Memory Access Through the Stack
#figure([a], caption: [Stack layout of the RISC-V architecture.])
=== Calling Convention
#pagebreak()
=== The Core Library
#pagebreak()
=== RISC-V Assembly
#pagebreak()
#pagebreak()
=== Supporting Pointers
=== Implementation
==== Struct Fields
#pagebreak()
#pagebreak()
==== Data Flow and Register Allocation
#pagebreak()
#figure(
    [a],
    caption: [Simplified integer register pool of the RISC-V rush compiler.],
)
#pagebreak()
#pagebreak()
#pagebreak()
==== Functions
#pagebreak()
==== Let Statements
#pagebreak()
==== Function Calls and Returns
#pagebreak()
#pagebreak()
#pagebreak()
==== Loops
#pagebreak()
#pagebreak()
== x86_64: Compiling to a CISC Architecture
=== x64 Assembly
#pagebreak()
=== Registers
#pagebreak()
#figure(table(), caption: [General purpose registers of the x64 architecture.])
#pagebreak()
=== Stack Layout and Calling Convention
#figure([a], caption: [Stack layout of the x64 architecture.])
=== Implementation
#pagebreak()
==== Struct Fields
#pagebreak()
==== Memory Management
==== Register Allocation
#pagebreak()
==== Functions
#pagebreak()
==== Function Calls
==== Control Flow
#figure([a], caption: [Structure of if-expressions in assembly.])
#pagebreak()
#pagebreak()
==== Integer Division and Float Comparisons
#pagebreak()
#pagebreak()
==== Pointers
#pagebreak()
== Conclusion: RISC vs. CISC Architectures
#pagebreak()
= Final Thoughts and Conclusions
#pagebreak()
#pagebreak()
#set heading(numbering: none)
#glossary(
    title: "Acronyms & Abbreviations",
    theme: acr-theme,
)
#pagebreak()
= Bibliography
