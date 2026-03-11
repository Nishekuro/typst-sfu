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
]
