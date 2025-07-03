#import "/template/util.typ": *
#import "/template/model.typ": baseline-bias
#import "/template/style.typ": show-body

#show: show-body

#let active(body) = text(fill: red)[\[#body\]]

// @typstyle off
#let specified-cell(color, body) = tcell(
  fill: color.background,
  text(fill: color.foreground)[#body]
)

#let 沙河-colour = (background: teal.lighten(85%), foreground: teal.darken(25%))
#let 海南-colour = (background: green.lighten(85%), foreground: green.darken(25%))
#let 本部-colour = (background: red.lighten(85%), foreground: red.darken(25%))
#let invalid-colour = (background: white, foreground: white)

#let 沙河-cell(body: [沙]) = specified-cell(沙河-colour, body)
#let 海南-cell(body: [海南]) = specified-cell(海南-colour, body)
#let 本部-cell(body: [本]) = specified-cell(本部-colour, body)
#let invalid-cell(body: []) = specified-cell(invalid-colour, body)


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
    }, // 处理思源宋导致的 baseline 问题
    radius: .25em,
    text(fill: item.foreground, item.name),
  )
}

#let data = (
  (
    name: "信息与通信工程学院",
    code: 311,
    count: 2,
    source: [23 级大三前回迁],
  ),
  (
    name: "电子工程学院",
    code: 312,
    count: 2,
    source: [23 级大三前回迁],
  ),
  (
    name: "计算机学院（国家示范性软件学院）",
    code: 313,
    count: 2,
    source: [
      23 级大二前回迁 \
      24 级大二前未回迁 \
      #active[有活跃异动，未稳定] \
    ],
  ),
  // 老自动化院 314 RIP
  // 软件院 315? RIP
  (
    name: "数字媒体与设计艺术学院",
    code: 316,
    count: 5,
    source: [21 级毕业前未曾回迁],
  ),
  // 邮政院 317 RIP
  (
    name: "网络空间安全学院",
    code: 318,
    count: 5,
    source: [21 级毕业前未曾回迁],
  ),
  (
    name: "经济管理学院",
    code: 321,
    count: 1,
    source: [24 级大二前回迁],
  ),
  (
    name: "人文学院",
    code: 331,
    fill: (
      沙河-cell(),
      沙河-cell(),
      沙河-cell(body: [沙#super(dagger.double)]),
      沙河-cell(),
      沙河-cell(),
    ),
    source: [21 级毕业前未曾回迁],
  ),
  (
    name: "马克思主义学院",
    code: 332,
    fill: (..(invalid-cell(),) * 4, 沙河-cell()),
    source: [],
  ),
  // 理学院 341 RIP
  (
    name: "国际学院",
    code: 351,
    count: (1, 3),
    source: [24 级大二前回迁],
  ),
  (
    name: "玛丽女王海南学院",
    code: 377,
    fill: (..(海南-cell(),) * 4, invalid-cell()),
    source: [],
  ),
  (
    name: "未来学院",
    code: 378,
    count: (2, 2),
    source: [23 级大三前回迁],
  ),
  (
    name: "集成电路学院",
    code: 379,
    count: 2,
    source: [23 级大三前回迁],
  ),
  (
    name: "卓越工程师学院",
    code: 38,
    fill: (..(invalid-cell(),) * 4, 本部-cell()),
    source: [
      #active[有活跃异动，未稳定] \
    ],
  ),
  (
    name: "智能工程与自动化学院",
    code: 386,
    count: 5,
    source: [21 级毕业前未曾回迁],
  ),
  (
    name: "数学科学学院",
    code: 387,
    count: 5,
    source: [21 级毕业前未曾回迁],
  ),
  (
    name: "物理科学与技术学院",
    code: 388,
    count: 5,
    source: [21 级毕业前未曾回迁],
  ),
  (
    name: "人工智能学院",
    code: 391,
    count: 2,
    source: [23 级大三前回迁],
  ),
  // (
  //   name: "",
  //   code: 0,
  //   count: 0,
  //   source: [],
  // ),
)

#let gen-row-fill(..args) = {
  let TOTAL = 5
  let 沙河-count = args.pos().at(0, default: 5)
  let 本部-count = args.pos().at(1, default: TOTAL - 沙河-count)
  let 空-count = TOTAL - 沙河-count - 本部-count
  (..(沙河-cell(),) * 沙河-count, ..(本部-cell(),) * 本部-count, ..(invalid-cell(),) * 空-count)
}

#let gen-row-data(row) = {
  let fill = if "count" in row.keys() {
    let count = row.count
    if type(count) == int {
      gen-row-fill(row.count)
    } else if type(count) == array {
      gen-row-fill(..count)
    }
  } else {
    if row.fill.len() != 5 {
      panic("Row fill must have exactly 5 elements, got " + repr(row.fill))
    }
    row.fill
  }

  (
    [(#row.code) #row.name],
    // [#row.name\ (#row.code)],
    ..fill,
    [#row.source],
  )
}

#let 校区说明表格 = table(
  columns: (auto, auto, auto, 24em),
  align: (x, y) => if x == 3 and y != 0 { left } else { center } + horizon,
  table.header()[*校区名称*][*图例*][*地址*][*说明*],

  [沙河校区],
  沙河-cell(),
  [北京市昌平区\ 沙河高教园区],
  [
    位于沙河大学城，附近有外交学院、北航、北师大、央财等众多高校的沙河校区。

    距地铁#get-subway(27)沙河站、沙河高教园站均短于 #qty[1][km]。

    近年新修建，生活环境较优渥，但周边稍显荒凉。

    #text(fill: 沙河-colour.foreground)[沙河校区]和#text(fill: 本部-colour.foreground)[西土城校区]之间单程乘地铁（含前往地铁站）约 #qty[1][h]，乘免费校车约 #qty[40][min]。
  ],

  [西土城校区\ （校本部）],
  本部-cell(),
  [北京市海淀区\ 西土城路 10 号],
  [
    位于北三环以内，距离二环（西城区）仅 #qty[2][km]。周边有多个商业区。

    东门与北师大西门仅一街之隔；距法大、央财、电影学院、北航、北大医学部均约 #qty[10][min] 自行车程；北航以北是学院路 8 校。

    距地铁蓟门桥站约 #qty[200][m]，距地铁北太平庄站、西土城站、大钟寺站、四道口站（在建）均短于 #qty[1.5][km]，涉及地铁 #get-subway(10), #get-subway(12), #get-subway(13), #get-subway(19), #get-subway(27)，线路优质，出行便利。
  ],

  [海南校区],
  海南-cell(),
  [海南省陵水黎族自治县\ 黎安国际教育创新试验区],
  [
    全新的环境，2022 年投入使用。

    全国一流的住宿条件，毕竟交通实在太不便了。
  ],

  [宏福校区],
  [],
  [],
  [普通全日制学生现已不再分配到宏福校区。高考志愿中出现该字样的同学入学应前往#text(fill: 沙河-colour.foreground)[沙河校区]。],
)

#let 详表 = align(
  left,
  stack(
    spacing: .5em,
    dir: ttb,
    table(
      columns: 7,
      inset: .5em,
      table.header(
        tcell(rowspan: 3)[*学院*],
        tcell(colspan: 5)[*校区*（宿舍所在地）],
        tcell(rowspan: 3)[*信息来源*],
        tcell(colspan: 4)[本科生],
        tcell(rowspan: 2)[研究生#super(dagger)],
        /// fmt off
        [大一], [大二], [大三], [大四],
      ),

      ..data.map(gen-row-data).flatten(),
    ),
    [#super(dagger)曾经所有沙河校区的研究生须在毕业年级回迁本部，但自 2025 年起似乎不再有该要求。#active[有活跃异动，\ 未稳定]],
    [#super(dagger.double)人文学院法学专业联培学生大三学年前往中国政法大学参与联合培养。],
  ),
)

= 柏油 · 校区

#disclaimer

尽量为所有的信息给出来源；规划持续变动，请以实际为准，不要过依赖本图。

#text(fill: red.darken(25%))[*欢迎新生参考该表的内容决定报考意愿。*]

- 校区简介：

  #figure(校区说明表格)

- 校区分配：

  目前，北邮遵循的分配策略为：

  - 所有本科新生都在沙河；
  - 本科生以学院为单位在某个时间点后回迁本部；
  - 研究生以学院为单位倾向于分配在同一校区#super(dagger)。

  #figure(详表)
