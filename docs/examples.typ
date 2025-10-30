#set page(paper: "a4", height: auto, margin: 8mm)
#set text(10pt)
#set par(justify: true)

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

  = Custom commands

  #import "theofig.typ": *


  #let problem = theofig.with(supplement: "Problem")
  #let hard_problem = theofig.with(supplement: "Problem", numbering: n => $#n^*$)

  #let solution = theofig.with(supplement: "Solution", numbering: none)
  #let hint = theofig.with(supplement: "Hint", numbering: none, separator: ":")

  #theofig-kinds.insert(-1, "problem")
  #theofig-kinds.insert(-1, "solution")

  #show figure.where(kind: "hint"): show-figure-caption(emph)
  #show figure.where(kind: "hint"): show-figure-caption(strong.with(delta: -300))

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

  #show figure-where-kind-in(theofig-kinds): show-figure-caption(strong)

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
  #show figure.where(kind: "postulate"): show-figure-caption(emph)
  #postulate[Custom element with specified styling.]

  #let problem = theofig.with(supplement: "Problem")

  // do that in preambule in place of
  // `#show figure-where-kind-in(theofig-kinds): show-figure-caption(strong)`
  #theofig-kinds.insert(-1, "problem")
  #show figure-where-kind-in(theofig-kinds): show-figure-caption(strong) 

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

  #show figure-where-kind-in(theofig-kinds): show-figure-caption(strong)

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

  #show figure-where-kind-in(theofig-kinds): set figure(numbering: thm-numbering)
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

  #show figure-where-kind-in(theofig-kinds): show-figure-caption(strong)

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

  #show figure-where-kind-in(theofig-kinds): set figure(numbering: thm-numbering)
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

  = Example styles

  #let A = [
      #definition[#lorem(7)] 
      #theorem[#lorem(2)][
        #lorem(13)
        #figure(caption: [An image])[
          #image(bytes(range(256)), format: (encoding: "luma8", width: 16, height: 16))
        ]
        #lorem(5)
      ] 
      #proof[#lorem(8)] 
  ]

  #table(columns: (1fr, 1fr),
      [== Default style],
    [
      #A
    ],
    [
      == Not bold caption
      ```typst
      #show figure-where-kind-in(
        theofig-kinds
      ): show-figure-caption(strong.with(delta: -300))
      ```
    ],
    [
      #show figure-where-kind-in(theofig-kinds): show-figure-caption(strong.with(delta: -300))
      #A
    ],
    [
      == Italic body
      ```typst
      #show figure-where-kind-in(theofig-kinds): it => {
        show: emph                // apply emph
        show figure.caption: emph // remove emph from caption
        it
      }
      ```
    ],
    [
      #show figure-where-kind-in(theofig-kinds): it => {
        show: emph
        show figure.caption: emph
        it
      }
      #A
    ],
    [
      == Block
      ```typst
      #show figure-where-kind-in(theofig-kinds): block.with(
        inset: 5pt, stroke: 1pt, fill: aqua, radius: 5pt,
      )
      ```
    ],
    [
      #show figure-where-kind-in( theofig-kinds): block.with(
        inset: 5pt, stroke: 1pt, fill: aqua, radius: 5pt,
      )
      #A
    ],
    [
      == Custom numbering
      ```typst
      #show figure-where-kind-in(
        theofig-kinds
      ): set figure(numbering: "I")
      ```

      Note that nested figures will be affected by that, and you either
      have to explicitly reset correct numbering for nested figures, or 
      set numbering for each individual function using redefinitions like
      ```typst
      #let theorem = theorem.with(numbering: "I")
      #let definition = theorem.with(numbering: "I")
      // etc
      ```

    ],
    [
      #show figure-where-kind-in(theofig-kinds): set figure(numbering: "I")
      #A
    ],

  )

]


#page[
  #import "theofig.typ": *

  = Choosing what to style

  #block(inset: 5pt, stroke: 1pt)[

    Here, we set all environments to have bold title, except examples and remarks, for
    which we make italic title and semicolon separator. Also, we disable numbering
    for remarks and examples.

    #show figure-where-kind-in(theofig-kinds, except: ("remark", "example")): show-figure-caption(strong)

    #show figure-where-kind-in(("remark", "example")): show-figure-caption(emph)
    #show figure-where-kind-in(("remark", "example")): set figure.caption(separator: [:]) 
    #show figure-where-kind-in(("remark", "example")): set figure(numbering: none)



    #theorem[Author][Statement of the theorem.]
    #proof[by me][Proof of the theorem.]
    #remark[We notice something.]
    #example[We discuss an example.]
  ]

]
