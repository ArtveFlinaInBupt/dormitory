#import "/template/model.typ": *

#let get-subway(name) = {
  let Beijing-subway-data = (
    "10": (
      background: rgb(0, 146, 188), // Typst 对 CMYK 的支持或许有问题
      name: "10",
      url: "https://www.pantone.com/color-finder/313-C",
    ),
    "12": (
      background: rgb(155, 90, 26),
      name: "12",
      url: "https://www.pantone.com/color-finder/154-C",
    ),
    "13": (
      background: rgb(244, 218, 64),
      foreground: rgb(0, 51, 128), // cmyk(100%, 60%, 0%, 50%),
      name: "13",
      url: "https://www.pantone.com/color-finder/7404-C",
    ),
    "19": (
      background: rgb(221, 156, 223),
      foreground: rgb(0, 51, 128), // cmyk(100%, 60%, 0%, 50%),
      name: "19",
      url: "https://www.pantone.com/color-finder/251-C",
    ),
    "27": (
      background: rgb(217, 134, 186),
      name: "昌平线",
      cjk: true,
      url: "https://www.pantone.com/color-finder/673-C",
    ),
  )
  let item = Beijing-subway-data.at(str(name))
  if "cjk" not in item {
    item.cjk = false
  }
  if "foreground" not in item {
    item.foreground = white
  }

  let y-offset = .25em

  box(
    fill: item.background,
    inset: (x: .15em),
    outset: if item.cjk {
      (
        top: y-offset - baseline-bias,
        bottom: y-offset + baseline-bias,
      )
    } else {
      (y: y-offset)
    }, // 处理思源字体导致的 baseline 问题
    radius: .25em,
    text(fill: item.foreground, weight: "regular", item.name),
  )
}
