#import "util.typ": github-logo
#import "model.typ": *

#let show-body(body) = {
  set document(author: ("fa_555 <fa_555@foxmail.com>",), date: datetime.today())

  set text(font: font, weight: "medium") // 应付 Source Han Serif SC 的偏细字重
  show regex("[\u4e00-\u9fa5]+"): set text(
    baseline: baseline-bias,
  ) // 应付 Source Han Serif SC 的偏低基线
  set par(leading: .5em, spacing: .85em, justify: true)

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    align(center, it)
    v(.5em)
  }

  set table(stroke: stroke, align: center + horizon)

  show math.equation: set text(font: math-font)
  show math.equation.where(block: false): it => math.display(it)

  show raw: set text(font: mono-font)

  set list(indent: 1em)

  show link: set text(fill: blue)

  set page(
    height: auto,
    width: auto,
    margin: 4em,
    footer: text(
      gray,
      grid(
        columns: (auto, 1fr, auto),
        align: (left, center, right),
        [最后更新：#datetime.today().display("[year] 年 [month] 月 [day] 日")],
        [],
        [贡献内容请到 #link("https://github.com/ArtveFlinaInBupt/dormitory")[#github-logo `ArtveFlinaInBupt/dormitory`]],
      ),
    ),
  )

  body
}
