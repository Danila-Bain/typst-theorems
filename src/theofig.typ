#import "translations.typ": theofig-translations
#import "utils.typ": (
  figure-where-kind-in, 
  show-figure-caption, 
  theofig-reset-counters
)


#let theofig(
  kind: none, 
  supplement: auto, 
  number: auto,
  numbering: auto, 
  block-options: (:),
  figure-options: (:),
  format-caption: strong,
  format-body: none,
  separator: ".",
  translate-supplement: true,
  qed: false,
  ..caption,
  body
) = {
  
  let caption = caption.pos().at(0, default: none)
  
  if (kind == none and supplement != auto) { kind = lower(supplement) }

  let supplement = context { 
    if (supplement == auto) {
      theofig-translations.at(text.lang).at(kind, default: kind)
    } else if translate-supplement {
      theofig-translations.at(text.lang).at(lower(supplement), default: supplement)
    } else {
      supplement
    }
  } 

  if (number != auto) {
      if type(number) == label {
        if numbering == auto {
          numbering = (..) => context {
            std.numbering(figure.numbering, 
                          counter(figure.where(kind: kind)).at(number).first())
          }
        } else {
          numbering = (..) => {
            std.numbering(numbering, 
                          counter(figure.where(kind: kind)).at(number).first())
          }
        }
      } else if type(number) == int {
        if numbering == auto {
          numbering = (..) => context std.numbering(figure.numbering, number)
        } else {
          numbering = (..) => std.numbering(numbering, number)
        }
      } else {
          numbering = (..) => number
      }
  }

  if numbering != auto {
    figure-options += (numbering: numbering)
  }

  figure(
    placement: none, 
    kind: kind, 
    supplement: supplement, 
    ..figure-options,
    block(
      width: 100%,
      breakable: true,
      ..block-options,
      context {

        let supplement = supplement
        let numbering = numbering 
        let body = body
        
        if number != auto {
          counter(figure.where(kind: kind)).update(n => n - 1)
        }

        if numbering == auto {
          numbering = figure.numbering
        }

        if numbering != none {
          supplement += [ #counter(figure.where(kind: kind)).display(numbering)]
        }

        if caption != none { 
          supplement += [ (#caption)] 
        }

        if (figure.caption.separator != auto) {
          separator = figure.caption.separator
        }
        supplement += separator

        if format-caption != none {
            supplement = format-caption(supplement)
        }
        if format-body != none {
            body = format-body(body)
        }

        set par(first-line-indent: par.first-line-indent + (all: false))

        align(
          left, 
          [
            #box(figure.caption(supplement)) #body #if (qed) { h(1fr); math.qed }
          ]
        )
      }
    )
  )
}

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
  "proof",
  "lemma",
  "remark", 
  "theorem", 
  "example",
  "statement",
  "corollary",
  "algorithm",
  "definition",
  "problem",
  "solution",
)

#let definition  = theofig.with(kind: "definition",  supplement: "Definition")
#let theorem     = theofig.with(kind: "theorem",     supplement: "Theorem")
#let proof       = theofig.with(kind: "proof", numbering: none, qed: true)

#let lemma       = theofig.with(kind: "lemma",       supplement: "Lemma")
#let statement   = theofig.with(kind: "statement",   supplement: "Statement")
#let remark      = theofig.with(kind: "remark",      supplement: "Remark")
#let corollary   = theofig.with(kind: "corollary",   supplement: "Corollary", numbering: none)
#let proposition = theofig.with(kind: "proposition", supplement: "Proposition")

#let example     = theofig.with(kind: "example",     supplement: "Example")
#let algorithm   = theofig.with(kind: "algorithm",   supplement: "Algorithm")
#let problem     = theofig.with(kind: "problem",     supplement: "Problem")
#let solution    = theofig.with(kind: "solution",    supplement: "Solution", numbering: none)
