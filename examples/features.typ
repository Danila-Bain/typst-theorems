#import "../theofigs.typ": *
#set page(paper: "a6", margin: 6mm)
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
#theofig-kinds-list.insert(-1, "problem")
#show theofig-selector(..theofig-kinds-list): show-figure-caption(strong) 

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

  Supported languages: #for lang in theofig-translations-list.keys() [#lang, ]
]
