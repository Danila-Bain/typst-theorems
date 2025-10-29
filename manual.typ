#set page(width: 100mm, height: auto, margin: 8mm)
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
