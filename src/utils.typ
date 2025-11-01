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

#let theofig-reset-counters(kinds, except: ()) = {
  for kind in kinds {
    if kind not in except {
      counter(figure.where(kind: kind)).update(0)
    }
  }
}
