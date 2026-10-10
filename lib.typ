#let template(body) = {
  set text(
    font: "Liberation Serif",
    lang: "ru",
    region: "ru",
    size: 14pt,
    overhang: false,
    hyphenate: false,
  )

  set page(
    binding: left,
    supplement: [стр. ],
    numbering: "1",
    margin: (
      top: 2cm,
      bottom: 2cm,
      left: 3cm,
      right: 1cm,
    ),
  )

  set par(
    leading: 0.5em, // TODO: добавить вариации 1 и 1.5
    spacing: 0.5em,
    first-line-indent: (amount: 1.25cm, all: true),
    justify: true,
    justification-limits: (
      spacing: (min: 100%, max: 100%),
    ),
  )

  // TODO: Отступы ровно в одну строку
  let line_width(it, left_inset: 0cm) = context {
    let h = measure([TEXT]).height
    let l = par.leading
    block(above: h + 2 * l, below: h + 2 * l, inset: (left: left_inset), it)
  }

  set heading(numbering: (..args) => numbering("1.1", ..args.pos().slice(1)))
  show heading.where(level: 1): set heading(numbering: none)
  show heading.where(level: 1): set align(center)
  show heading.where(level: 1): it => {
    counter(heading).step()
    it
  }
  show heading: set text(size: 14pt)
  set heading(supplement: none, hanging-indent: -1.25cm)
  show heading: line_width.with(left_inset: 1.25cm)

  // TODO: независимые размеры номера и тела
  show math.equation: set text(size: 12pt)
  show math.equation.where(block: true): line_width.with(left_inset: 1.25cm)
  show math.equation.where(block: true): it => align(it, left)
  set math.equation(numbering: "(1)", supplement: none)

  show figure.where(kind: table): line_width
  show figure.where(kind: table): it => {
    set figure.caption(position: top)
    show figure.caption: set align(left)
    it
  }
  set table(stroke: 0.5pt)
  // TODO: #show table.header: strong
  set table.cell(align: horizon)
  // TODO: исправить колонки максимальной длинны

  show figure.where(kind: raw): line_width
  show figure.where(kind: image): line_width.with(left_inset: 1.25cm)

  set figure.caption(separator: [~--~])

  // show regex("^-(\\s|$)"): [---~]
  show regex("\\s-(\\s|$)"): [~--~]
  // TODO: короткое тире для диапозонов чисел; мб решить через regex формул

  show list: it => pad(
    terms(
      ..it.children.map(item => terms.item([], item.body)),
      separator: [-#h(3pt)],
      hanging-indent: -1.25cm,
    ),
    left: 1.25cm,
  )

  show enum: set block(inset: (left: 1.25cm))

  show raw.where(block: true): set text(size: 10pt)

  show figure.where(kind: raw): set block(breakable: true, inset: (right: 1em))

  show raw.where(block: true): block.with(
    fill: luma(245),
    inset: 10pt,
    radius: 4pt,
  )

  show raw.where(block: false): box.with(
    fill: luma(245),
    inset: 2pt,
    radius: 2pt,
  )

  show figure.where(kind: image): set figure(supplement: [Рисунок])

  // set list(marker: [-], indent: 1.25cm, body-indent: 0.3em)
  // set enum(numbering: "a.1)", indent: 1.25cm)

  // show math.equation.where(block: true): it => pad(align(it, left), left: 1.25cm)

  // set table(align: horizon)
  // show table: set par(justify: false)

  // set figure(numbering: "1")
  // // show figure: it => pad(it, top: 1em, bottom: 1em)

  // show figure.where(kind: table): it => {
  //   // set figure.caption(position: top) it
  // }
  // show figure.caption.where(kind: table): set align(left)
  // show figure.where(kind: table): set block(breakable: true)

  // set list(marker: [-])
  // show list: it => pad(it, left: 1.25cm)

  body
}

#import "titlepage.typ": *
