#import "../theofig.typ": *
#set page(paper: "a6", margin: 6mm)
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
