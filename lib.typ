#let template(body) = {
  set text(font: "Liberation Serif", size: 14pt, lang: "ru")
  set page(
    numbering: "1",
    margin: (top: 2cm, bottom: 2cm, left: 3cm, right: 1cm),
  )
  set par(
    leading: 0.5em,
    spacing: 0.5em,
    first-line-indent: (amount: 1.25cm, all: true),
    justify: true,
  )

  set heading(numbering: "1.1")
  show heading: set text(size: 14pt)
  show heading: it => pad(it, left: 1.25cm, bottom: 0.5em)

  show math.equation.where(block: true): it => pad(it, top: 1em, bottom: 1em)

  set table(align: horizon)
  show table: set par(justify: false)

  set figure(numbering: "1")
  set figure.caption(separator: [ -- ])
  show figure: it => pad(it, top: 1em, bottom: 1em)

  show figure.where(kind: image): set figure(supplement: [Рисунок])

  show figure.where(kind: table): it => {
    set figure.caption(position: top)
    it
  }
  show figure.caption.where(kind: table): set align(left)
  show figure.where(kind: table): set block(breakable: true)

  show figure.where(kind: raw): set block(breakable: true)
  show figure.where(kind: raw): set align(left)

  show raw.where(block: true): block.with(
    fill: luma(240),
    inset: 10pt,
    radius: 4pt,
  )

  set list(marker: [-])
  show list: it => pad(it, left: 1.25cm)

  body
}
