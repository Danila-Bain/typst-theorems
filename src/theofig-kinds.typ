#import "theofig.typ": *

/// List of default kinds of environments defined by this package:
///
/// #theofig-kinds.map(s => raw("\"" + s + "\"")).join(", ", last: ", and ").
/// 
/// The purpose to this variable is to be used together with
/// selector `figure-where-kind-in` for styling:
/// #code-example-row(```typ
/// #show figure-where-kind-in(
///   theofig-kinds
/// ): block.with(
///     stroke: 1pt, radius: 3pt, inset: 5pt,
/// )
/// #definition[]
/// #theorem[]
/// #proof[]
/// ```)
#let theofig-kinds = (
  "algorithm",
  "corollary",
  "definition",
  "example",
  "lemma",
  "problem",
  "proof",
  "remark", 
  "solution",
  "statement",
  "theorem", 
)

#let algorithm   = theofig.with(kind: "algorithm",   supplement: "Algorithm",   translate-supplement: true)
#let corollary   = theofig.with(kind: "corollary",   supplement: "Corollary",   translate-supplement: true, numbering: none)
#let definition  = theofig.with(kind: "definition",  supplement: "Definition",  translate-supplement: true)
#let example     = theofig.with(kind: "example",     supplement: "Example",     translate-supplement: true)
#let lemma       = theofig.with(kind: "lemma",       supplement: "Lemma",       translate-supplement: true)
#let problem     = theofig.with(kind: "problem",     supplement: "Problem",     translate-supplement: true)
#let proof       = theofig.with(kind: "proof",       supplement: "Proof",       translate-supplement: true, numbering: none, qed: true)
#let proposition = theofig.with(kind: "proposition", supplement: "Proposition", translate-supplement: true)
#let remark      = theofig.with(kind: "remark",      supplement: "Remark",      translate-supplement: true)
#let solution    = theofig.with(kind: "solution",    supplement: "Solution",    translate-supplement: true, numbering: none)
#let statement   = theofig.with(kind: "statement",   supplement: "Statement",   translate-supplement: true)
#let theorem     = theofig.with(kind: "theorem",     supplement: "Theorem",     translate-supplement: true)
