#import "util.typ": github-logo
#import "model.typ": *

#let show-watermark(enable: true, body) = {
  let watermark-text = [预览]
  set page(foreground: if enable {
    rotate(-30deg, rect(width: 200%, height: 200%, fill: tiling(
      size: (120pt, 80pt),
      place(dy: 10pt, text(font: font.serif, size: 1.5em, fill: luma(216), watermark-text)),
    )))
  })

  body
}

#let show-body(..args, body) = {
  let config = args.named()
  let spinoff = config.at("spinoff", default: false)

  set document(author: ("fa_555 <fa_555@foxmail.com>",), date: datetime.today())

  set text(font: font.serif, weight: "medium") // 应付 Source Han Serif SC 的偏细字重
  show regex("[\u4e00-\u9fa5]+"): set text(
    baseline: baseline-bias,
  ) // 应付 Source Han Serif SC 的偏低基线
  set par(leading: .5em, spacing: .85em, justify: true)

  show highlight: it => underline(offset: .3em, text(fill: red, weight: "black", it))

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    align(center, it)
    v(.5em)
  }

  set table(stroke: stroke, align: center + horizon)

  show math.equation: set text(font: font.math)
  show math.equation.where(block: false): it => math.display(it)

  show raw: set text(font: font.mono)

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
        [提供信息或贡献内容请到 #if spinoff { link("mailto:fa_555@foxmail.com", `fa_555`) } else { link("https://github.com/ArtveFlinaInBupt/dormitory")[#github-logo `ArtveFlinaInBupt/dormitory`] }],
      ),
    ),
  )

  show: show-watermark.with(enable: not "release" in sys.inputs and not spinoff)

  body
}
