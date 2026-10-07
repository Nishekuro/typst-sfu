#let template(body) = {
  set text(
    lang: "ru",
    region: "ru",
    size: 14pt,
    overhang: false,
    hyphenate: false,
    discretionary-ligatures: true, // TODO: ни на что не влияет?
    number-type: "lining", // TODO: ни на что не влияет?
    number-width: "proportional",
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

  let line_width(it) = context {
    let h = measure([TEXT]).height
    let l = par.leading
    block(above: h + 2 * l, below: h + 2 * l, inset: (left: 1.25cm), it)
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
  show heading: line_width

  show figure: line_width
  set figure.caption(separator: [~---~])

  show math.equation: set text(size: 12pt)

  show math.equation.where(block: true): line_width
  show math.equation.where(block: true): it => align(it, left)
  set math.equation(numbering: "(1)", supplement: none)

  set list(marker: [-], indent: 1.25cm, body-indent: 0.3em)
  set enum(numbering: "a.1)", indent: 1.25cm)

  // show regex("^-(\\s|$)"): [---~]
  show regex("\\s-(\\s|$)"): [~---~]
  // TODO: короткое тире для диапозонов чисел

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

  // show figure.where(kind: raw): set block(breakable: true)
  // show figure.where(kind: raw): set align(left)

  // show raw.where(block: true): block.with(
  //   fill: luma(240),
  //   inset: 10pt,
  //   radius: 4pt,
  // )

  // set list(marker: [-])
  // show list: it => pad(it, left: 1.25cm)

  body
}

#let titlepage(
  institute: "Институт",
  department: "Кафедра",
  workType: "ОТЧЕТ ПО ЛАБОРАТОРНОЙ РАБОТЕ №0",
  topic: "Тема",
  variant: "Вариант",
  teacher: "ФИО",
  student: "ФИО",
  studentID: "Номер группы",
  footer: "Нижний колонтитул",
) = [
  // Настройки документа
  #set text(font: "Liberation Serif", size: 14pt, lang: "ru")
  #set page(
    footer: [#footer],
    margin: (top: 2cm, bottom: 2cm, left: 3cm, right: 1cm),
  )
  #set par(leading: 0.5em, spacing: 0.5em)
  #set align(center)

  // Вспомогательные элементы
  #let signature = text(size: 10pt, baseline: 14pt)[
    #overline([подпись, дата], offset: 0.5em)
  ]

  // Шапка документа
  Министерство науки и высшего образования РФ\
  #text(size: 12pt)[
    Федеральное государственное автономное\
    образовательное учреждение высшего образования\
  ]
  *«СИБИРСКИЙ ФЕДЕРАЛЬНЫЙ УНИВЕРСИТЕТ»*\
  #institute\
  #department

  // Основное содержание
  #grid(
    rows: (1fr, 1fr),
    [
      #align(horizon)[
        #text(size: 16pt)[*#workType*]\
        #topic\
        #variant
      ]
    ],
    [
      #align(top)[
        #grid(
          columns: (2fr, 1fr, 1fr),
          align: (left, center, right),
          row-gutter: 2em,
          [Преподаватель], [#signature], [#teacher],
          [Студент #studentID], [#signature], [#student],
        )
      ]
    ],
  )
  #pagebreak()
  // TODO: `document`
]
