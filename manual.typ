#set page(width: 200mm, height: auto, margin: 8mm)
This document at the moment consists \ of the examples that author wants to work.

#page[
  #import "theofig.typ": *

  = Default Style

  == English

  #theorem[Just a text]

  #theorem[Caption][Just a text]

  #definition[Just a text]

  #definition[Caption][Just a text]

  == Russian

  #set text(lang: "ru")

  #theorem[Just a text]

  #theorem[Caption][Just a text]
]

#page[
  #import "theofig.typ": *

  = Styling 

  #show figure: it => if it.kind in theofig-kinds {
    show figure.caption: strong
    it
  } else {it}


  #theorem[#lorem(50)]

  #figure(caption: lorem(5))[
    #lorem(50)
  ]
]

#page[

  = Custom commands

  #import "theofig.typ": *


  #let problem = theofig.with(supplement: "Problem")
  #let hard_problem = theofig.with(supplement: "Problem", numbering: n => $#n^*$)

  #let solution = theofig.with(supplement: "Solution", numbering: none)
  #let hint = theofig.with(supplement: "Hint", numbering: none, separator: ":")

  #theofig-kinds.insert(-1, "problem")
  #theofig-kinds.insert(-1, "solution")
  #show: theofig-style-default(kinds: theofig-kinds)

  #show: theofig-style("italic-title", kinds: ("hint",))

  #problem[What $1 + 1$ equals to in $ZZ_2$?]

  #solution[Observe that $1 + 1$ is $2$, and $2 mod 2$ is $0$. Hense, the answer is $0$.]

  #hard_problem[Prove that $ZZ_2$ is a field.]

  #hint[Verify all axioms of a field exaustively.]

]

#page[
  = Supported features

  #import "theofig.typ": *
  #show ref: set text(blue)

  #set math.equation(numbering: n => numbering("(1)", n))

  #show theofig-selector(): show-figure-caption(strong)

  #theorem[Just a theorem.]
  #theorem(numbering: none)[Just a theorem without number.]
  #lemma(kind: "theorem")[
    Setting kind to "theorem" makes "lemma" share numbering with it.
  ]
  #theorem[Author][Just a theorem with caption.]
  #proof[Just a proof.]
  #proof(qed: false)[Just a proof without `math.qed` at the end.]

  #definition[Just a definition.]<def>
  #definition[Just a definition that references @def[Def.].]


  #let apology = theofig.with(supplement: "Apology")
  #apology[Custom element before applying any styling.]


  #let postulate = theofig.with(supplement: "Postulate")
  #show theofig-selector("postulate", ): show-figure-caption(emph)
  #postulate[Custom element with specified styling.]

  #let problem = theofig.with(supplement: "Problem")

  // do that in preambule in place of
  // `#show theofig-selector(): show-figure-caption(strong)`
  #theofig-kinds.insert(-1, "problem")
  #show theofig-selector(..theofig-kinds): show-figure-caption(strong) 

  #problem[Custom element with generic styling.]


  // #definition[Just a definition in a box (all following definitions will be in a box).]
  // #definition[Just a definition]
  //
  = Languages support
  #[
    #set text(lang: "ru")
    #theorem[#lorem(5)]

    #set text(lang: "es")
    #theorem[#lorem(5)]

    #set text(lang: "de")
    #theorem[#lorem(5)]

    #set text(lang: "ja")
    #theorem[#lorem(5)]

    Supported languages: #for lang in theofig-translations.keys() [#lang, ]
  ]

]


#page[

  = Russian Numbering

  #import "theofig.typ": *
  #set text(10pt, lang: "ru")

  #set ref(supplement: none)
  #show ref: set text(blue)

  #set heading(numbering: "1.")
  #set math.equation(numbering: n => numbering("(1)", n))

  #show theofig-selector(): show-figure-caption(strong)

  = Plain numbering (default)

  Definitions (in Russian):

  #definition[]<ru_def:1>
  #definition[]

  $
  f^o r_m u^l a
  $ 

  //    PREAMBULE
  ////////////////////
  #let thm-numbering(n) = numbering("1.1", counter(heading).get().first(), n)
  #let eq-numbering(n) = numbering("(1.1)", counter(heading).get().first(), n)

  #show theofig-selector(): set figure(numbering: thm-numbering)
  #set math.equation(numbering: eq-numbering)

  #show heading: theofig-reset-counters
  #show heading: it => {counter(math.equation).update(0); it}
  ////////////////////

  = Per-section numbering

  #definition[]<ru_def:2.1>
  #definition[]
  $
  f^o r_m u^l a
  $ 

  = Per-section numbering (second time)

  #definition[]<ru_def:3.1>
  $
  f^o r_m u^l a
  $ 
  $
  f^o r_m u^l a
  $ <ru_eq:last>

  = Referencing

  Because in Russian the words for "definition", "equation", etc. can 
  have different forms in a sentence, we remove supplement in *all* references,
  and write "определение" (definition), "уравнение" (equation), "рисунок" (figure), etc. explicitly:

  После определения @ru_def:1 шло определение @ru_def:2.1, а определению @ru_def:3.1 мы уделили внимание в последнию очередь.
  В конце мы написали уравнение @ru_eq:last.

]


#page[

  = Numbering

  #import "theofig.typ": *
  #set text(10pt)
  #show ref: set text(blue)

  #set heading(numbering: "1.")
  #set math.equation(numbering: n => numbering("(1)", n))

  #show theofig-selector(): show-figure-caption(strong)

  = Plain numbering (default)

  #definition[]<def:1>
  #definition[]

  $
  f^o r_m u^l a
  $ 
  $
  f^o r_m u^l a
  $ 


  #let thm-numbering(n) = numbering("1.1", counter(heading).get().first(), n)
  #let eq-numbering(n) = numbering("(1.1)", counter(heading).get().first(), n)

  #show theofig-selector(): set figure(numbering: thm-numbering)
  #set math.equation(numbering: eq-numbering)

  #show heading: theofig-reset-counters
  #show heading: it => {counter(math.equation).update(0); it}

  = Per-section numbering

  #definition[]<def:2.1>
  #definition[]
  $
  f^o r_m u^l a
  $ 
  $
  f^o r_m u^l a
  $ 

  = Per-section numbering (second time)

  #definition[]<def:3.1>
  #definition[]
  $
  f^o r_m u^l a
  $ 
  $
  f^o r_m u^l a
  $ <eq:last>

  = Referencing

  Among others there were @def:1, @def:2.1, @def:3.1. At the end, we wrote @eq:last.


]



#page[

  #import "theofig.typ": *
  #set text(10pt)

  = Styling

  #definition[Basic style.]

  #[
    #show theofig-selector(): show-figure-caption(emph)
    #definition[Italic title.]
  ]

  #[
    #show theofig-selector(): show-figure-caption(emph)
    #show theofig-selector(): set figure.caption(separator: [:])

    #definition[Italic title and semicolon separator.]
  ]

  #[
    #show theofig-selector(): show-figure-caption(strong)
    #definition[Bold title.]
  ]

  #[
    #show theofig-selector(): emph
    #show theofig-selector(): show-figure-caption(emph, strong)
    #definition[Bold title and intalic body.]
  ]

  #[
    #show theofig-selector(): block.with(stroke: 1pt, radius: 3pt, inset: 6pt)
    #show theofig-selector(): show-figure-caption(strong)
    #definition[Bold title and boxed with border.]
  ]

  #[
    #show theofig-selector(): block.with(fill: rgb(0,0,255,50), radius: 3pt, inset: 6pt)
    #show theofig-selector(): show-figure-caption(strong)
    #definition[Bold title and boxed with fill.]
  ]

  = Choosing what to style

  #block(inset: 5pt, stroke: 1pt)[

    Here, we set all environments to have bold title, except examples and remarks, for
    which we make italic title and semicolon separator. Also, we disable numbering
    for remarks and examples.

    #show theofig-selector(except: ("remark", "example")): show-figure-caption(strong)

    #show theofig-selector("remark", "example"): show-figure-caption(emph)
    #show theofig-selector("remark", "example"): set figure.caption(separator: [:]) 
    #show theofig-selector("remark", "example"): set figure(numbering: none)

    #theorem[Author][Statement of the theorem.]
    #proof[by me][Proof of the theorem.]
    #remark[We notice something.]
    #example[We discuss an example.]
  ]

]
