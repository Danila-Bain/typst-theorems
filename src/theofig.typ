#import "translations.typ": theofig-translations
#import "utils.typ": (
  figure-where-kind-in, 
  show-figure-caption, 
  theofig-reset-counters
)

/// List of default kinds of environments defined by this package.
/// The purpose to this variable is to be used in cunjunction with
/// selector `figure-where-kind-in` for styling:
/// 
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


#let theofig(
  ..caption,
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



#let theofig-styles = (
  "bold-title": (it, kinds) => {
    show figure-where-kind-in(kinds): show-figure-caption(strong)
    it
  },
  "italic-title": (it, kinds) => {
    show figure-where-kind-in(kinds): show-figure-caption(emph)
    it
  },
  "italic-body": (it, kinds) => {
    show figure-where-kind-in(kinds): (it) => {
      show figure.caption: emph
      show: emph
      it
    }
    it
  },
  "block": (it, kinds) => {
    show figure-where-kind-in(kinds): (it) => {
      show: block.with(stroke: 1pt, inset: 6pt, radius: 3pt)
      it
    }
    it
  },
  "breakable": (it, kinds) => {
    show figure-where-kind-in(kinds): (it) => {
      set block(breakable: true)
      it
    }
    it
  },
  "not-breakable": (it, kinds) => {
    show figure-where-kind-in(kinds): (it) => {
      set block(breakable: false)
      it
    }
    it
  },
)

#let theofig-style(..options, kinds: (), except: ()) = (it) => {
  let kinds = kinds
  if (kinds == ()) {
    kinds = theofig-kinds.filter(x => x not in except)
  }
  for option in options.pos() {
    it = (theofig-styles.at(option))(it, kinds)
  }
  it
}

#let theofig-style-light = theofig-style.with("italic-title", "breakable")
#let theofig-style-default = theofig-style.with("bold-title", "breakable")
#let theofig-style-italic = theofig-style.with("bold-title", "italic-body", "breakable")
#let theofig-style-block = theofig-style.with("bold-title", "block")
#let theofig-style-block-italic = theofig-style.with("bold-title", "italic-body", "block")

