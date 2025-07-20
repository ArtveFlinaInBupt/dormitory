#import "/template/util.typ": *

#let freshman-hint = [
  #show: body => {
    set text(fill: red.darken(25%))
    set list(spacing: .75em, tight: false)
    show highlight: it => underline(offset: .3em, text(fill: red, weight: "black", it))
    align(center, block(
      stroke: (
        paint: red.darken(25%),
        thickness: 2pt,
        dash: "dotted",
      ),
      radius: 1em,
      inset: (right: 1em, y: .75em),
      fill: red.lighten(95%),
      align(left, body),
    ))
  }

  #align(center, {
    text(size: 1.25em)[#datetime.today().display("[year]") 高招季 Special：*新生可能需要的信息*]
    v(-.25em)
  })

  - 关于设施：学校所有宿舍内

    - 全部配备空调
    - 不存在晚熄灯和晚断电制度
    - 免费不限流量无线网络覆盖，一般至少可以跑出 #qty[120 \~ 160][Mbps] 的速度

  - 关于家具、户型参数

    - 大部分新生将要搬入沙河雁南，其中大部分房间近期有计划改造为#highlight[六人间非上床下桌]。本表尚未更新因该改造尚未落地，也未见符合改造计划的实物图。

    - 此前学校大部分家具尺寸为 $#qty[90][cm] times #qty[190][cm]$，但雁南新家具的招标参考图纸标注 $#qty[100][cm] times #qty[200][cm]$。

      - 由于从未有人见过神秘新家具的真实样貌，为稳妥起见，我们建议在购买床品时选择与两者皆相容的尺寸。

    - 学校原则上不允许安装床帘。若需购买，建议到校实地体验并测量尺寸后再决定。
]
