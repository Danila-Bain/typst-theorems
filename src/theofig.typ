#import "translations.typ": theofig-translations
#import "utils.typ": (
  figure-where-kind-in, 
  show-figure-caption, 
  theofig-reset-counters
)


/// This is the core factory function which implements a theorem-like
/// environment on top of `figure`. Most user-facing environments (e.g.
/// `#theorem`, `#definition`, `#proof`) are created with `.with(...)`
/// specializations of this function.
/// 
/// 
/// 
/// - body (content): The contents of the environment.
///   === Example
///   #code-example-row(```typst
///   #theorem[One body]
///   #theorem[Another body]
///   ```)
///
/// - ..caption (array with one element): Additional text in supplement, i.e. 
///   author, year, or source of the theorem, like in *Theorem 1 (Cauchy, 1831).*
///   === Example
///   #code-example-row(```typst
///   #theorem[1910][$1 + 1 = 2$.]<th-1>
///   #theorem[Newton–Leibniz][
///     $ integral_a^b f'(x) dif x = f(b) - f(a). $
///   ]
///   Note the absence of caption in reference of @th-1.
///   ```)
///
/// - kind (auto, str): The internal `figure.kind` value. If
///   left `auto` and a string `supplement` is provided (not `auto` or
///   `content`), the function will set `kind = lower(supplement)` so the kind
///   can be inferred from the supplement like `"Theorem"` $->$ `"theorem"`.
/// 
/// - supplement (auto, str, content): The figure supplement (the
///   textual label that appears as the environment title, e.g. `"Theorem"`,
///   `"Definition"`). Behavior:
///   - `auto` — the function attempts to translate the `kind` using
///     `theofig-translations` keyed by `text.lang` (so environments adapt to
///     document language).
///   - If `supplement` explicitly provided as string and `translate-supplement
///     == true`, the code will try to translate the supplement using
///     `theofig-translations` dictionary using contextual `text.lang`. If
///     there is no match in dictionary or `translate-supplement == false`,
///     `supplement` is used as is.
///   - If `kind` is `auto` and `supplement`, `kind` is set to
///     `lower(supplement)` (automatic kind from supplement).
/// 
/// - number (auto, int, label, other): Allows overriding the environment
///   number. Behaviors:
///   - `auto` --- default tracking (no manual override).
///     `int` --- uses that integer as the numbering (wrapped into a numbering
///     function). If `numbering == none`, it produces an error.
///   - `label` --- uses the counter number  of an existing labeled figure; if
///     `numbering == auto` the code also sets up `numbering` to produce
///     the same numbering as the labeled figure's counter value.
///   - other values are used verbatim with `numbering = (..) => number`.
/// 
/// - numbering (auto, none, str, function): The formatting function/style
///   for the displayed number (e.g. Roman, alphabetic).
///   Setting `auto` makes the function use either `figure.numbering` (default),
///   otherwise this argument takes precedence over `figure.numbering`, which
///   can be set using show rules or `figure-options` argument.
/// 
/// - block-options (dictionary): Options passed to the inner
///   `block(...)` call; use to control visual block styling (stroke, inset,
///   radius, breakable, width etc.) without affecting nested blocks (as show
///   rules do).
/// 
/// - figure-options (dictionary): Options passed to
///   `figure(...)`. If `numbering` is determined (not `auto`), `figure-options` is
///   augmented with `numbering: numbering`.
/// 
/// - format-caption (none, function, array of functions): Function(s) applied to
///   the `supplement` (the title part) before rendering. If `none`, no special
///   formatting is applied. Typical values: `emph`, `smallcaps`, `strong`, or
///   user-provided functions.
/// 
/// - format-body (none, function, array of functions): Function(s) applied to the
///   body content (the environment contents). If `none`, no additional formatting
///   is applied.
///
/// - separator (none, str, content): Text appended between caption (supplement
///   + caption + numbering) and the body. Overridden if `figure.caption.separator` 
///   show rule is set to non-`auto`.
///
///   === Example 1
///   #code-example-row(```typst
///   #definition[#lorem(4)]
///   #definition(separator: ":")[#lorem(4)]
///   // #show figure.where(kind: "definition"): set figure.caption(separator: "?")
///   // #definition[#lorem(4)]
///   ```)
/// 
/// - translate-supplement (bool): Whether a provided `supplement` should be
///   passed through `theofig-translations` dictionary to allow localized titles. 
///   If `true` and `supplement` provided, package will attempt to map the lowercased 
///   supplement through `theofig-translations` for
///   the current contextual `text.lang`. Note that if figure and a reference to it 
///   are in different languages, figure caption and reference supplement will have
///   different languages as well.
/// 
/// - qed (bool): If `true`, a `math.qed` marker (rendered as a box `∎`) is
///   added after the body. This is used for `proof` to append the end-of-proof
///   marker. Note that `math.qed` symbol can be changed using 
///   `show math.qed: ...` rule.
#let theofig(
  ..caption,
  body,
  kind: auto, 
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
) = {
  
  let caption = caption.pos().at(0, default: none)
  
  if (kind == auto and type(supplement) == str) { kind = lower(supplement) }

  let supplement = context { 
    if (supplement == auto) {
      theofig-translations.at(text.lang).at(kind, default: kind)
    } else if type(supplement) == str and translate-supplement {
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
