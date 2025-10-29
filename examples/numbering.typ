#import "../theofig.typ": *
#set page(paper: "a6", margin: 6mm)
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

