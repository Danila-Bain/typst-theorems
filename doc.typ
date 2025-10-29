#import "@preview/tidy:0.4.1"
#import "theofig.typ"

#set text(lang: "en")

#let docs = tidy.parse-module(
  read("theofig.typ"),
  scope: (theofig: theofig),
  name: "theofig",
  preamble: "import theofig: *\n",
)

#tidy.show-module(
  docs, 
  // style: 
  // tidy.styles.minimal, 
)
