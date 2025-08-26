#import "/template/util.typ": *

#let freshman-hint = [
  #show: body => {
    set text(fill: red.darken(25%))
    set list(spacing: .75em, tight: false)
    align(center, block(
      stroke: (
        paint: red.darken(25%),
        thickness: 1pt,
        dash: "dotted",
      ),
      radius: 1em,
      inset: (right: 1em, y: .75em),
      fill: red.lighten(95%),
      align(left, body),
    ))
  }

  #align(center, {
    text(size: 1.25em)[#datetime.today().display("[year]") 开学季 Special：*本科新生可能需要的信息*]
    v(-.25em)
  })

  - 关于设施：学校所有宿舍房间内

    - 全部配备空调、暖气
    - 不存在晚熄灯和晚断电制度
    - 免费不限流量无线网络覆盖，一般至少可以跑出 #qty[120 \~ 160][Mbps] 的速度

  - 关于家具、户型参数

    - 大部分本科新生将要搬入沙河雁南，其中大部分房间近期改造为#highlight[六人间非上床下桌]。

    - 根据一些无法判断真假的传言，宿舍普通床铺尺寸在 $#qty[184.5][cm] times #qty[91][cm]$ 至 $#qty[192][cm] times #qty[91][cm]$ 不等的多种规格中以未知方式分配；床垫由学校统一配备。

      - 我们建议在置备其他床品时选择与各种规格都兼容的尺寸，或咨询自己的辅导员。

    - 宿舍原则上不允许安装不透明床帘。若需购买，建议到校实地体验并测量尺寸后再决定。
]
