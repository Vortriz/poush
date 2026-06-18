#import "../lib.typ": *
#import "@preview/glossy:0.9.1": *

#show: thesis
#set page(paper: "us-letter")
#show: init-glossary.with(yaml("chapters/glossary.yaml"))


// Frontmatter ------------------------------------

#set page(numbering: "i")

#titlepage(
    title: [Some long and awesome title for your spectacular thesis on a very niche subject],
    author: "John B Doe",
    date: datetime(year: 2025, month: 6, day: 1),
    degree: [Doctor of Sciences],
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
)

#colophon[This dissertation was prepared with Typst using #link("https://github.com/Vortriz/poush", [Poush]) template. The main text is set in Libertinus Serif. The monospace font is `DejaVu Sans Mono`.]

// Abstract
#generic-section(
    title: [Abstract],
    body: [
        // #lorem(700)
        Over the past thirty years, exoplanet science—that is, the study of planets beyond our Solar System— has become one of the most thriving and dynamic subfields of astronomy. At the time of this writing, close to 6000 extrasolar planets have been discovered through various methods, and measurements from groundbreaking instruments such as the James Webb Space Telescope (JWST) allow us to study their properties in unprecedented detail. Complementing these hardware advances, there has recently been an increased interest in methods for processing observational data, especially through the use of machine learning (ML). This should not come as a surprise, considering the success that ML has had in other domains, and given that both the detection and characterization of exoplanets are fundamentally challenging inference problems which require the extraction of information from complex, noisy data that push traditional analysis techniques to their limits.

        In this thesis, we present three contributions to this young research field at the intersection of exoplanet science and ML, which trace an arc from the detection of extrasolar planets with the help of ML to the characterization of their atmospheres. The first study addresses the problem of post-processing data from high-contrast imaging. We show how we can combine physical domain knowledge about the data with techniques from the field of causal inference to learn pixel-wise models for the systematic noise that allow us to denoise the data and thus reveal previously unseen companions. We demonstrate the applicability of our approach on four publicly available datasets from the VLT/NACO instrument. A particular innovation of our approach is the explicit incorporation of the external observing conditions, which experiments improves the denoising performance.

        In the second study, we turn to the problem of atmospheric retrieval; that is, the inference of parameters such as the chemical composition from an observed exoplanet spectrum. We show that we can use neural networks to replace a key component in the standard Bayesian inference pipeline; namely the parameterization of the thermal structure. This reduces the number of parameters needed to describe an atmosphere, thus speeding up retrievals or freeing up computational resources for other parameters of interest. In addition, it effectively allows performing atmospheric retrieval with pressure–temperature profiles from self-consistent atmospheric models, which are usually too computationally expensive for Bayesian parameter inference.

        Finally, in the third contribution, we completely replace the traditional atmospheric characterization workflow using stochastic samplers with a simulation-based inference approach based on continuous normalizing flows. We combine this approach with importance sampling to ensure the reliability of our results and show that we can learn models that amortize over different assumptions for the noise in the data, thus boosting the practical applicability of our method. We demonstrate this practical applicability and validate it against traditional alternatives through extensive experiments on simulated emission spectra of a gas giant-type exoplanet.
    ],
)

#set outline(depth: 2)

// ToC
#create-outline(
    preset: outline-presets.toc,
    kind: none,
)

// List of figures
#create-outline(
    preset: outline-presets.figures,
    title: [List of Figures],
)

// List of tables
#create-outline(
    preset: outline-presets.figures,
    title: [List of Tables],
    kind: table,
)

// List of listings
#create-outline(
    preset: outline-presets.figures,
    title: [List of Listings],
    kind: raw,
)


// Body -------------------------------------------

#set page(numbering: "1")
#counter(page).update(1)

= Introduction

#epigraph(
    [For then why may not every one of these Stars or Suns have as great a Retinue as our Sun, of Planets, with their Moons, to wait upon them?],
    [Christiaan Huygens],
    [Cosmotheoros, Book II (1698)],
)

Picture the night sky. A black canvas, filled with thousands upon thousands of stars. The Milky Way alone, our home galaxy, is estimated to contain at least one hundred billion of them (see, e.g., Bok & Bok, 1974  , p. 23), most of them too faint to be seen by the unaided eye. Statistically speaking, each of these stars harbors at least one planet (Cassan et al., 2012  ). While speculations concerning this matter can be traced back for centuries, the roots of exoplanet science as an empirical discipline are found in the 1990s, a mere three decades ago #sidenote[A detailed account of the discovery of the first planet in an orbit around a star that is not the Sun, and the discussions that ensued before the detection was accepted as such, has been compiled by Cenadelli & Bernagozzi (2015  ).]. Historically, much of the progress in the field has been driven by advances on the hardware side: larger telescopes with better adaptive optics, new instruments with higher resolution, or observations from space that eliminate the influence of the Earth’s atmosphere, have all contributed significantly to the fact that the detection of new exoplanets has almost become a routine afafir these days. In the near future, the next generation of ground-based telescopes will provide another major leap forward, possibly capturing the first image of a small, rocky exoplanet around a nearby star (Quanz et al., 2014  ). In addition to these hardware advances, however, there has also been a recent growth of interest in data processing, specifically in the application of machine learning (ML) methods. This very thesis may be taken as a case in point, but it is only one example of a larger trend that is illustrated in fig. 1.1. Machine learning for exoplanet science is a young but thriving area of research that is not only of interest to astrophysicists, but has even found its way into the limelight of a major ML conference in the form of two data challenges that were part of the NeurIPS competition track in 2022 and 2024 (see Changeat & Yip, 2023  ).

One does not have to look far to fnid the reasons for this development. First, improvements in hardware are pushing the limits of what is possible (e.g., what types of planets are accessible to observations), but at that very limit, advancing our understanding of extrasolar planets—for example, about their formation and evolution—again requires extracting information from complex, noisy data. Second, better hardware itself creates new challenges, both in terms of the quantity and the quality of the data. If we think specifically about atmospheric characterization, missions such as ARIEL (Atmospheric Remote-sensing Infrared Exoplanet Large-survey; Tinetti et al., 2021  ) will drastically increase the number of exoplanet spectra to be analyzed, likely pushing traditional inference methods to their limit in terms of the computational cost; an issue that we discuss in chapters 4 and 5 of this thesis. Regarding the quality of the data, higher spectral resolution also means higher sensitivity to more and more physical and chemical processes in the atmospheres of the observed planets, which in turn increases the complexity (and thus the cost) of the theoretical models that are required to interpret the data. Another important point to consider is the development of new hardware. On the one hand, there is the development process itself, which may require optimizing key instrument parameters by simulating entire surveys for different configurations, which brings us back to the question of scalability. On the other hand, new hardware can be designed already with the idea that its data products can be analyzed with ML, which may affect what data (and metadata) are collected and stored in the first place. Given how much of a driver exoplanet science is for astronomical instrument design,2 this is a possibility that is worth taking seriously.

The appeal thus seems clear: ML has demonstrated exceptional potential in many fields, from language modeling (e.g., OpenAI et al., 2023  ) to protein folding (Jumper et al., 2021  ), and it comes with the promise of being able to handle data that traditional approaches struggle with. At the same time, much of what we have discussed above is still that—a promise, or rather an opportunity, for the future. Things are moving fast, but as it stands, it seems fair to say that ML is not quite as mature and widely adopted in exoplanet science as in other fields. This thesis presents my contributions toward changing this, and toward further establishing ML methods as an important tool for detecting and studying

@aa is a great.

@aar is also great.

@bb is nice.

@smit54 is some reference.

#pagebreak()
#booktbl(
    columns: 7,
    header-rows: 2,
    // combine header cells
    tabular.cells((0, (1, 4)), colspan: 3, stroke: (bottom: 0.03em)),
    // table notes, remarks, and caption
    tabular.note((1, (1, 4)), [$m v$ is in kg·m².]),
    tabular.note((1, (3, 6)), [Time is in secs.]),
    tabular.note(sym.dagger, (2, 0), [Another note.]),
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
#pagebreak()
=== Fetch-Decode-Execute Cycle of the VM

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

// Backmatter -------------------------------------
#set heading(numbering: none)

#bibliography("references.bib", style: "apa"),

#glossary(
    title: "Acronyms & Abbreviations",
    theme: acr-theme,
)

#generic-section(
    title: [Used Software & Generative AI Declaration],
    body: [#lorem(200)],
)

#generic-section(
    title: [Acknowledgements],
    body: [#lorem(300)],
)
