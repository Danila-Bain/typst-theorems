#import "../theofigs.typ": *
#set page(paper: "a6", margin: 6mm)
#set text(10pt, lang: "ru")

#set ref(supplement: none)
#show ref: set text(blue)

#set heading(numbering: "1.")
#set math.equation(numbering: n => numbering("(1)", n))

#show theofig-selector(): show-figure-caption(strong)

= Plain numbering (default)

Definitions (in Russian):

    #definition[]<def:1>
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

    #definition[]<def:2.1>
    #definition[]
    $
      f^o r_m u^l a
    $ 

    = Per-section numbering (second time)

    #definition[]<def:3.1>
    $
      f^o r_m u^l a
    $ 
    $
      f^o r_m u^l a
    $ <eq:last>

= Referencing

Because in Russian the words for "definition", "equation", etc. can 
have different forms in a sentence, we remove supplement in *all* references,
and write "определение" (definition), "уравнение" (equation), "рисунок" (figure), etc. explicitly:

После определения @def:1 шло определение @def:2.1, а определению @def:3.1 мы уделили внимание в последнию очередь.
В конце мы написали уравнение @eq:last.

