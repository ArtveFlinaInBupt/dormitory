#import "/template/util.typ": *
#import "/template/style.typ": show-body

#import "campus-cell.typ": *

#show: show-body

#let male-colour = eastern.darken(5%)
#let female-colour = fuchsia.darken(5%)
#let mixed-colour = color.mix(male-colour, female-colour)

#let good-colour = green.darken(25%)
#let bad-colour = red.darken(25%)
#let neutral-colour = blue
#let unknown-colour = yellow.darken(25%)
#let wip-colour = gray

#let male = text.with(fill: male-colour)
#let female = text.with(fill: female-colour)
#let mixed = text.with(fill: mixed-colour)

#let good = text.with(fill: good-colour)
#let bad = text.with(fill: bad-colour)
#let neutral = text.with(fill: neutral-colour)
#let unknown = text.with(fill: unknown-colour)
#let wip = text.with(fill: wip-colour)

#let quest = unknown[?]

#let 性别图例 = table(
  inset: (x: 1em),
  table.header()[*性别图例*],
  male[男寝],
  female[女寝],
  mixed[混寝],
  wip[未知],
)
#let 好坏图例 = table(
  inset: (x: 1em),
  table.header()[*好坏图例*],
  good[好 / 近],
  bad[坏 / 远],
  neutral[中],
  wip[建设中],
  unknown[待确认\ 或待补充],
)
#let 好坏条 = stack(
  spacing: .5em,
  good[好],
  box(
    width: .1em,
    height: 59.5em, // 需在更新表格后手动调整
    fill: gradient.linear(green, red, angle: 90deg),
  ),
  bad[坏],
)
// @typstyle off
#let 主体表格 = table(
  columns: (..(auto,) * 15, 20em),
  inset: .5em,
  align: (x, y) => if y != 0 and x == 15 { left } else { center },
  table.header(
    tcell(rowspan: 3)[*所在校区*],
    tcell(rowspan: 3)[*宿舍楼*],
    tcell(colspan: 12)[*配置*],
    tcell(rowspan: 3)[*竣工年份*],
    tcell(rowspan: 3)[*其他说明*\ #unknown[（欢迎补充）]],
    tcell(rowspan: 2)[住户类型],
    tcell(rowspan: 2)[人数],
    tcell(rowspan: 2)[家具],
    tcell(rowspan: 2)[卫生间],
    tcell(rowspan: 2)[阳台],
    tcell(rowspan: 2)[楼层 / 电梯],
    tcell(rowspan: 2)[水电网供应],
    tcell(colspan: 5)[距离],
    [快递站],
    [外卖柜],
    [浴室楼 / 浴室],
    [教学楼群],
    [科研楼],
  ),

  沙河-cell(rowspan: 5, body: [沙河校区]),
  female[雁南 S6],
  tcell(rowspan: 5, [本科生\ 硕士研究生\ 博士研究生]),
  tcell(rowspan: 5, good[4]),
  tcell(rowspan: 5, good[上床下桌]),
  tcell(rowspan: 5, good[独卫\ +\ 公卫#super(dagger)]),
  tcell(rowspan: 5, good[有]),
  tcell(rowspan: 3, good[6 层\ 有电梯]),
  tcell(rowspan: 5, good[正常]),
  tcell(rowspan: 5, bad[远]),
  tcell(rowspan: 5, bad[小南门柜]),
  good[层浴，有隔板],
  tcell(rowspan: 5, []),
  tcell(rowspan: 5, []),
  [2020],
  [
    单独一期工程修建，与 S1 \~ S5 无关

    面积大于其他宿舍，家具更好，上下床走台阶而非爬梯子
  ],

  [
    #female[雁南 S5] \
    #mixed[雁南 S4] \
    #male[雁南 S3] \
    #male[雁南 S2] \
    #male[雁南 S1] \
  ],
  good[层浴],
  [2016],
  [
    S4 有一部分宿舍现已与 S4 之间封死，成为女生宿舍，由 S5 代管，从 S5 进出
  ],
  [#male[雁北 E]\ #male[雁北 D2]],
  good[层浴，有隔板#super(dagger)],
  tcell(rowspan: 3)[2014],
  [
    在 S6 没建好时曾经是女寝，改男寝后浴室隔板没拆
  ],
  [#male[雁北 D1]\ #male[雁北 C]],
  good[6 层\ 有电梯#super(dagger.double)],
  tcell(rowspan: 2, good[层浴]),
  tcell(rowspan: 2)[
    面积略小于雁南
  ],
  [#male[雁北 B]\ #male[雁北 A]],
  neutral[6 层\ 部分有电梯#super(dagger.double)],

  本部-cell(rowspan: 10, body: [西土城\ 校区\ （校本部）]),
  mixed[学 8],
  [博士研究生],
  good[4],
  good[上床下桌],
  neutral[独卫],
  good[有],
  neutral[12 层\ 2 部电梯],
  bad[主楼翻修期间\ 常随机停水],
  good[近],
  neutral[北门柜],
  [#neutral[近]\ #neutral[部分寝室有独浴]\ #bad[但无热水]],
  neutral[中],
  neutral[中],
  [#quest\ 早于 2001],
  [部分房间地漏不可用，楼板渗水，搭配独浴和停水忘关水龙头有奇效],

  [#female[学 9]\ #female[学 11]],
  [本科生],
  good[4],
  good[上床下桌],
  neutral[公卫],
  bad[无],
  neutral[5 层\ 无电梯],
  bad[每天凌晨\ 停冲厕用中水],
  good[近],
  good[北门柜],
  neutral[中],
  bad[远],
  bad[远],
  [2024],
  [
    空间很小，胜在新

    每天凌晨停冲厕用中水

    说好的层浴还会有吗？
  ],

  female[学 29],
  [硕士研究生\ 博士研究生],
  [8 人套间\ 每室 #good[2 \~ 4] 人],
  good[普通家用\ 床铺桌椅],
  neutral[套间独卫],
  good[有],
  neutral[20 层\ 2 部电梯],
  good[正常#quest],
  bad[远],
  good[东门柜],
  bad[远\ #neutral[有独浴]但无热水],
  bad[远],
  neutral[中],
  [#quest\ 早于 2003],
  [
    曾经是家属区的一部分，非典时期被征用为非典塔，后空置直到学校扩招被征用为宿舍；高层曾用作留学生宿舍

    只有一楼有热饮用水

    不限电功率

    19 \~ 20 层有燃气供应
  ],

  male[学 10],
  [本科生\ 硕士研究生\ 博士研究生],
  neutral[6],
  good[上床下桌],
  neutral[公卫],
  good[有],
  neutral[15 层\ 10 部电梯],
  good[正常#quest],
  good[近],
  good[北门柜],
  neutral[近],
  bad[远],
  neutral[中],
  [2011],
  [],

  [#mixed[学 3]\ #male[学 5]],
  [本科生\ 硕士研究生],
  neutral[6],
  good[上床下桌],
  bad[公卫],
  good[有],
  bad[15 层\ 2 部电梯],
  bad[每天凌晨\ 停冲厕用中水],
  neutral[中],
  neutral[北门柜\ #neutral[西门柜]#wip[（学 13\ 工地暂时阻断）]],
  neutral[中],
  neutral[中],
  bad[远],
  [2004],
  [
    均摊千人一部电梯，有时等待时间极长

    除一楼和顶楼外层高很低，床上难以坐直
  ],

  female[学 4],
  [本科生\ 硕士研究生\ 博士研究生],
  neutral[6],
  bad[上下铺],
  neutral[独卫],
  good[有],
  neutral[12 层\ 2 部电梯],
  bad[主楼翻修期间\ 常随机停水],
  neutral[中],
  neutral[北门柜\ 西门柜],
  [#neutral[中]\ #neutral[部分寝室有独浴]\ #bad[但无热水]],
  neutral[中],
  bad[远],
  [#quest\ 早于 2001],
  [
    单寝面积略大于学 6

    有和学 8 相同的所有问题

    此外，独浴可用率和使用率相较学 8 更低，淋浴喷头可能并不干净
  ],

  male[学 6],
  [本科生],
  neutral[6],
  bad[上下铺],
  bad[独卫],
  [除#bad[一楼]外#good[有]],
  bad[6 层\ 无电梯],
  bad[随机停电\ 随机停冲厕用中水],
  good[近],
  good[科研楼柜],
  neutral[近],
  bad[远],
  good[近],
  [2003],
  [
    里面好像个迷宫，第一次去不知道楼梯在哪

    离经管楼和科研楼近，也许可以……
  ],

  [#male[学 1]],
  [本科生],
  bad[8],
  bad[上下铺],
  bad[公卫],
  good[有],
  neutral[5 层\ 无电梯],
  good[正常#quest],
  bad[远],
  good[西门柜],
  bad[远],
  good[近],
  bad[远],
  [1993],
  [
    有翻修计划，预计将会在 2025 年底开始
  ],

  wip[学 2], tcell(colspan: 14, rowspan: 2, wip[正在翻修]), wip[学 13],
)

#let 表格注 = stack(
  dir: ttb,
  spacing: .5em,
  [#super(dagger)雁北 D2, E 楼为一个区域，内部部分连通。D2 楼借用 E 楼公卫和层浴浴室，可能需要前往其他楼层。],
  [#super(dagger.double)雁北 A, B, C, D1 楼为一个区域，内部部分连通。该区域两部电梯均位于 D1 部分，A, B, C 楼需要借道；A, B 二楼与 A 六楼无法通过电梯到达，需要步行一层。],
)

= 柏油 · 宿舍

#disclaimer

只讨论绝大多数宿舍配置，*不讨论特种房间*。特种房间定义为占比小于 $1 \/ 10$ 的房间。

虽然表里有些距离评价是远，但是巴掌大的校园再远能有多远呢？不提供到食堂的距离评价：从任何宿舍到食堂都比教学楼群到食堂更近。不提供沙河宿舍到教学楼、科研楼的距离评价。

发现把沙河宿舍编号全倒着放正好大体符合由好到坏（归功于雁北 E, D2 浴室有隔板，雁北缺电梯），挺好玩的，所以就倒着放了。

本文档实际上旨在提供信息而非排名，因此不接受任何有关排名顺序的建议和批评——几乎所有人都觉得别人住得比自己好，学 3, 5, 8, 9, 10, 11, 29 甚至沙河雁北中的任何一个放前面都有人不满意，被喷得实在烦。

学校所有建筑物内（包括但不限于宿舍）

- 全部配备空调，
- 免费不限流量无线网络全覆盖，一般至少可以跑出 #qty[120 \~ 160][Mbps] 的速度，

下表中不再说明。

#text(fill: red.darken(25%))[*新生请谨慎参考本表内容：沙河雁南大部分房间可能有改造为六人间非上床下桌的计划。本表尚未更新因该改造尚未落地，也未见符合传言的实物图。*]

#{
  show: align.with(center + horizon)

  stack(
    dir: ltr,
    spacing: 3em,
    stack(
      spacing: 2em,
      性别图例,
      好坏图例,
    ),
    grid(
      columns: 2,
      align: (bottom, left),
      column-gutter: 1em,
      row-gutter: .5em,
      好坏条, 主体表格,
      [], 表格注,
    ),
  )
}

特种房间不完全列表（仅说明和其他房间不同之处）：

#grid(
  columns: 2,
  gutter: .5em,
  [- *学 3 大 6 人间*：], [更大的空间，无阳台，有超大落地窗],
  [- *学 4 10 人间*：], [10 人（5 张上下铺），多个房间，无阳台],
  [- *学 5 10 人间*：], [10 人（5 张上下铺），更大的空间，无阳台],
  [- *学 10 大 6 人间*：], [更大的空间],
)
