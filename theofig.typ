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

/// Per-language list of default suppliments 
/// ```example
/// #theofig-translations()
/// ```
#let theofig-translations = (
  "en": (
    "proof":          "Proof",
    "lemma":          "Lemma",
    "remark":         "Remark", 
    "theorem":        "Theorem",
    "example":        "Example",
    "statement":      "Statement",
    "corollary":      "Corollary",
    "algorithm":      "Algorithm",
    "definition":     "Definition",
  ),
  "ru": (
    "proof":          "Доказательство",
    "lemma":          "Лемма",
    "remark":         "Замечание", 
    "theorem":        "Теорема",
    "example":        "Пример",
    "statement":      "Утверждение",
    "corollary":      "Следствие",
    "algorithm":      "Алгоритм",
    "definition":     "Определение",
  ),
  "de": (
    "proof":          "Beweis",
    "lemma":          "Lemma",
    "remark":         "Bemerkung", 
    "theorem":        "Satz",
    "example":        "Beispiel",
    "statement":      "Aussage",
    "corollary":      "Korollar",
    "algorithm":      "Algorithmus",
    "definition":     "Definition",
  ),
  "fr": (
    "proof":          "Preuve",
    "lemma":          "Lemme",
    "remark":         "Remarque", 
    "theorem":        "Théorème",
    "example":        "Exemple",
    "statement":      "Énoncé",
    "corollary":      "Corollaire",
    "algorithm":      "Algorithme",
    "definition":     "Définition",
  ),
  "es": (
    "proof":          "Demostración",
    "lemma":          "Lema",
    "remark":         "Observación", 
    "theorem":        "Teorema",
    "example":        "Ejemplo",
    "statement":      "Enunciado",
    "corollary":      "Corolario",
    "algorithm":      "Algoritmo",
    "definition":     "Definición",
  ),
  "it": (
    "proof":          "Dimostrazione",
    "lemma":          "Lemma",
    "remark":         "Osservazione", 
    "theorem":        "Teorema",
    "example":        "Esempio",
    "statement":      "Enunciato",
    "corollary":      "Corollario",
    "algorithm":      "Algoritmo",
    "definition":     "Definizione",
  ),
  "pt": (
    "proof":          "Prova",
    "lemma":          "Lema",
    "remark":         "Observação", 
    "theorem":        "Teorema",
    "example":        "Exemplo",
    "statement":      "Enunciado",
    "corollary":      "Corolário",
    "algorithm":      "Algoritmo",
    "definition":     "Definição",
  ),
  "pl": (
    "proof":          "Dowód",
    "lemma":          "Lemat",
    "remark":         "Uwaga", 
    "theorem":        "Twierdzenie",
    "example":        "Przykład",
    "statement":      "Stwierdzenie",
    "corollary":      "Wniosek",
    "algorithm":      "Algorytm",
    "definition":     "Definicja",
  ),
  "cs": (
    "proof":          "Důkaz",
    "lemma":          "Lemma",
    "remark":         "Poznámka", 
    "theorem":        "Věta",
    "example":        "Příklad",
    "statement":      "Tvrzení",
    "corollary":      "Důsledek",
    "algorithm":      "Algoritmus",
    "definition":     "Definice",
  ),
  "zh": (
    "proof":          "证明",
    "lemma":          "引理",
    "remark":         "注释", 
    "theorem":        "定理",
    "example":        "例子",
    "statement":      "命题",
    "corollary":      "推论",
    "algorithm":      "算法",
    "definition":     "定义",
  ),
  "ja": (
    "proof":          "証明",
    "lemma":          "補題",
    "remark":         "注", 
    "theorem":        "定理",
    "example":        "例",
    "statement":      "命題",
    "corollary":      "系",
    "algorithm":      "アルゴリズム",
    "definition":     "定義",
  ),
  "ko": (
    "proof":          "증명",
    "lemma":          "보조정리",
    "remark":         "비고", 
    "theorem":        "정리",
    "example":        "예",
    "statement":      "명제",
    "corollary":      "따름정리",
    "algorithm":      "알고리즘",
    "definition":     "정의",
  ),
  "ar": (
    "proof":          "برهان",
    "lemma":          "لمّة",
    "remark":         "ملاحظة", 
    "theorem":        "نظرية",
    "example":        "مثال",
    "statement":      "قضية",
    "corollary":      "نتيجة",
    "algorithm":      "خوارزمية",
    "definition":     "تعريف",
  ),
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



// #let theorem-figure-defaults = none
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


#let figure-where-kind-in(kinds, except: ()) = {
  return selector.or(
    ..kinds
    .filter(
      kind => kind not in except
    )
    .map(
      kind => figure.where(kind: kind)
    )
  )
}


#let show-figure-caption(..functions) = it => {
  for func in functions.pos() {
    it = [
      #show figure.caption: func
      #it
    ]
  }
  it
}

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


#let theofig-reset-counters(kinds, except: ()) = {
  for kind in kinds {
    if kind not in except {
      counter(figure.where(kind: kind)).update(0)
    }
  }
}
