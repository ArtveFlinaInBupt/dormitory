#import "/template/util.typ": *
#import "/template/style.typ": show-body

#import "model/color.typ": (
  bad-color, female-color, good-color, male-color, mixed-color, neutral-color, unknown-color,
  wip-color,
)
#import "model/campus-cell.typ": 本部-cell, 沙河-cell

#let tint = mixed-color

#show: show-body.with(tint: tint)

#let male = text.with(fill: male-color)
#let female = text.with(fill: female-color)
#let mixed = text.with(fill: mixed-color)

#let good = text.with(fill: good-color)
#let bad = text.with(fill: bad-color)
#let neutral = text.with(fill: neutral-color)
#let unknown = text.with(fill: unknown-color)
#let wip = text.with(fill: wip-color)

#let quest = unknown[?]

#let 性别图例 = table(
  inset: (x: 1em),
  table.header[*性别图例*],
  male[男],
  female[女],
  [#mixed[混合]#fn(1)],
  wip[无住户],
)
#let 好坏图例 = table(
  inset: (x: 1em),
  table.header[*好坏图例*],
  good[好 / 近],
  bad[坏 / 远],
  neutral[中],
  wip[建设中],
  unknown[待确认\ 或待补充],
)

#let 主体表格 = {
  let all-columns = (
    校区: (required: false),
    楼名: (meta: true),
    住户: (:),
    人数: (:),
    家具: (:),
    卫生间: (:),
    阳台: (:),
    楼层: (:),
    水电网: (:),
    快递站: (:),
    外卖柜: (:),
    浴室: (:),
    教学楼: (:),
    科研楼: (:),
    装修年份: (:),
    住宿费: (:),
    说明: (align: left + horizon, width: 20em, meta: true),
  )
    .pairs()
    .enumerate()
    .map(((i, (k, v))) => (
      k,
      (x: i, required: true, width: auto, align: center + horizon, meta: false, ..v),
    ))
    .to-dict()

  let dorm-name-cell = tcell.with(x: all-columns.楼名.x)
  let description-cell = tcell.with(x: all-columns.说明.x)

  let dormitory(rows: 1, ..args) = {
    let columns = args.named()
    assert.eq(type(columns), dictionary, message: "dormitory() expects a dictionary of columns")

    let required-columns = all-columns.filter(it => it.required).keys()
    assert.eq(columns.keys(), required-columns, message: {
      "dormitory() missing or extra columns, require "
      repr(required-columns)
      ", got"
      repr(columns.keys())
    })

    let into-canonical = it => if type(it) == dictionary and it.keys() == ("rows", "body") {
      it
    } else {
      (rows: 1, body: it)
    }

    columns
      .pairs()
      .map(((k, v)) => {
        v = if type(v) != array { (v,) } else { v }.map(into-canonical)
        v.last().rows += rows - v.fold(0, (acc, v) => acc + v.rows)
        v.map(it => tcell(x: all-columns.at(k).x, rowspan: it.rows, it.body))
      })
      .flatten()
  }

  table(
    columns: all-columns.values().map(it => it.width),
    align: (x, y) => if y == 0 { center + horizon } else { all-columns.values().at(x).align },
    table.header(
      tcell(rowspan: 3)[*所在校区*],
      tcell(rowspan: 3)[*宿舍楼*\ 旧名 \[新名 (如有)\]],
      tcell(colspan: 12)[*配置*],
      tcell(rowspan: 3)[*最后装修\ 年份*],
      tcell(rowspan: 3)[*住宿费\ #text(size: .7em)[元 / 学年]*],
      tcell(rowspan: 3)[*其他说明*\ #unknown[（欢迎补充）]],

      tcell(rowspan: 2)[近 5 年\ 住户类型],
      tcell(rowspan: 2)[每室人数\ #text(size: .7em)[括号内为床位数]],
      tcell(rowspan: 2)[家具],
      tcell(rowspan: 2)[卫生间#fn(4)],
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

    沙河-cell(x: all-columns.校区.x, rowspan: 7, body: [沙河校区]),

    ..dormitory(
      rows: 2,
      楼名: wip({
        let box = box.with(baseline: (at: horizon, shift: -font.axis-height))
        $
          #box[研究生 A1\ 研究生 A2\ 研究生 B1\ 研究生 B2\ 研究生 B3]
          [#box[雁西 1 号楼\ 雁西 2 号楼\ 雁西 3 号楼\ 雁西 4 号楼\ 雁西 5 号楼\ 雁西 6 号楼]]
        $
      }),
      住户: (wip[  博], wip[本硕 ]),
      人数: (wip[2], wip[4]),
      家具: (wip[单层家具], wip[上床下桌]),
      卫生间: quest,
      阳台: wip[有],
      楼层: wip[10 层#quest\ 有电梯#quest],
      水电网: wip[正常#quest],
      快递站: (wip[远], wip[中]),
      外卖柜: wip[小南门柜],
      浴室: quest,
      教学楼: [],
      科研楼: [],
      装修年份: [2026],
      住宿费: quest,
      说明: [
        本学期即将投入使用，猜测内部环境与学 13 类似，也有 2 人间与 4 人间

        名为研究生公寓，实际上不只有研究生居住
      ],
    ),

    ..dormitory(
      rows: 5,
      楼名: (
        female[雁南 S6 \[雁南 5 号楼\]],
        [#female[雁南 S5 \[雁南 4 号楼\]]\ #female[雁南 S4 \[雁南 3 号楼\]]\ #male[雁南 S3 \[雁南 2 号楼\]\ 雁南 S2 \[雁南 1 号楼\]]],
        [#male[雁北 E \[雁北 6 号楼\]]\ #male[雁北 D2 \[雁北 5 号楼\]]],
        [#male[雁北 D1 \[雁北 4 号楼\]]\ #male[雁北 C \[雁北 3 号楼\]]],
        [#male[雁北 B \[雁北 2 号楼\]]\ #male[雁北 A \[雁北 1 号楼\]]],
      ),
      住户: [本硕博],
      人数: (good[4], [#good[4]\ #neutral[5 (6)], #neutral[6]], (rows: 3, body: good[4])),
      家具: (
        good[上床下桌],
        [
          #good[上床下桌] \
          #neutral[
            床床#hide[#backlink("about:blank")[]] \
            床#backlink("https://baike.baidu.com/pic/TFBOYS/9083733/0/3c6d55fbb2fb4316390c99072da4462309f7d3b8")[桌] \
          ]
        ],
        (rows: 3, body: good[上床下桌]),
      ),
      卫生间: good[独卫\ +\ 公卫#fn(2)#fn(3)],
      阳台: good[有],
      楼层: (
        (rows: 3, body: good[6 层\ 有电梯]),
        good[6 层\ 有电梯#fn(3)],
        neutral[6 层\ 部分有电梯#fn(3)],
      ),
      水电网: good[正常],
      快递站: ((rows: 2, body: good[近]), (rows: 3, body: neutral[中])),
      外卖柜: bad[小南门柜],
      浴室: good[层浴#fn(2)],
      教学楼: [],
      科研楼: [],
      装修年份: ([2020], [2016], (rows: 3, body: [2014])),
      住宿费: ([1200], [900#quest], (rows: 3, body: [1200])),
      说明: (
        [
          单独一期工程修建，与 S1 \~ S5 无关

          单寝面积大于其他宿舍楼，家具也更好
        ],
        [
          经历过临时 4 改 6 又改 4 的#ruby[瞎折腾][风波]，目前保留的非 4 人间多为原寝主动选择维持原样
        ],
        (
          rows: 3,
          body: [
            单寝面积略小于雁南
          ],
        ),
      ),
    ),

    本部-cell(x: all-columns.校区.x, rowspan: 12, body: [西土城\ 校区\ （校本部）]),

    ..dormitory(
      rows: 3,
      楼名: (male[学 13\ （2 人间）], [#wip[学 1]\ #male[学 2]], male[学 13\ （4 人间）]),
      住户: ([  博], quest, [ 硕 ]),
      人数: (good[2], (rows: 2, body: good[4])),
      家具: good[上床下桌],
      卫生间: neutral[公卫],
      阳台: ([仅有#neutral[假阳台]], good[有], [仅有#neutral[假阳台]]),
      楼层: neutral[5 层\ 无电梯],
      水电网: (
        [#bad[蜂窝信号奇差]\ （校园网正常）],
        good[正常#quest],
        [#bad[蜂窝信号奇差]\ （校园网正常）],
      ),
      快递站: bad[远],
      外卖柜: good[西门柜],

      浴室: (bad[远\ #wip[楼浴尚未启用]], bad[远\ #wip[层浴尚未启用]], bad[远\ #wip[楼浴尚未启用]]),
      教学楼: (neutral[中], good[近], neutral[中]),
      科研楼: bad[远],
      装修年份: [2025–2026],
      住宿费: ([750], quest, [750]),
      说明: [
        使用沙河雁南换下的家具
      ],
    ),

    ..dormitory(
      楼名: female[学 29],
      住户: [#ruby[仅元][本]硕博],
      人数: [8 人套间\ 每室 #good[2 \~ 4] 人],
      家具: good[单层家具],
      卫生间: neutral[套间\ 卫生间\ （坐便）],
      阳台: good[有],
      楼层: neutral[20 层\ 2 部电梯],
      水电网: good[正常#quest],
      快递站: bad[远],
      外卖柜: good[东门柜],
      浴室: bad[远 #v(.25em) #neutral[有套间浴室]\ 但无热水],
      教学楼: bad[远],
      科研楼: neutral[中],
      装修年份: [#quest\ 早于 2003],
      住宿费: [1200],
      说明: [
        可参考#backlink("https://bbs.byr.cn/#!article/Picture/3377378")[北邮人论坛]

        曾经是家属区眷 29 楼，非典时期被征用为非典塔，后空置直到学校扩招被征用为宿舍；高层曾用作留学生宿舍

        只有一楼有热饮用水
      ],
    ),

    ..dormitory(
      楼名: [#female[学 9]\ #female[学 11]],
      住户: [本  ],
      人数: good[4],
      家具: good[上床下桌],
      卫生间: neutral[公卫],
      阳台: bad[无],
      楼层: neutral[5 层\ 无电梯],
      水电网: bad[凌晨停冲厕中水],
      快递站: good[近],
      外卖柜: good[北门柜],
      浴室: neutral[中\ #wip[层浴尚未启用]],
      教学楼: bad[远],
      科研楼: bad[远],
      装修年份: [2024],
      住宿费: [750],
      说明: [
        单寝面积很小
      ],
    ),

    ..dormitory(
      rows: 2,
      楼名: (mixed[学 8], female[学 4\ （4 人间）]),
      住户: ([#ruby[仅元][本] 博], [  博]),
      人数: good[4],
      家具: good[上床下桌],
      卫生间: neutral[独卫],
      阳台: good[有],
      楼层: neutral[12 层\ 2 部电梯],
      水电网: good[正常#quest],
      快递站: (good[近], neutral[中]),
      外卖柜: (neutral[北门柜], neutral[北门柜\ 西门柜]),
      浴室: (
        [#neutral[近]\ #neutral[部分寝室有独浴]\ #bad[但无热水]],
        [#neutral[中]\ #neutral[部分寝室有独浴]\ #bad[但无热水]],
      ),
      教学楼: (neutral[中], neutral[中]),
      科研楼: (neutral[中], bad[远]),
      装修年份: [#quest\ 早于 2001],
      住宿费: ([1200], [850]),
      说明: [
        部分房间地漏不可用，楼板渗水，搭配独浴和停水忘关水龙头有奇效
      ],
    ),

    ..dormitory(
      楼名: [#mixed[学 3]\ #male[学 5]],
      住户: [#male[本]硕 ],
      人数: neutral[6],
      家具: good[上床下桌],
      卫生间: bad[公卫],
      阳台: good[有],
      楼层: bad[15 层\ 2 部电梯],
      水电网: bad[凌晨停冲厕中水],
      快递站: neutral[中],
      外卖柜: neutral[北门柜\ 西门柜],
      浴室: neutral[中],
      教学楼: neutral[中],
      科研楼: bad[远],
      装修年份: [2004],
      住宿费: [900],
      说明: [
        均摊千人一部电梯，有时等待时间极长

        除一楼和顶楼外层高很低，床上难以坐直
      ],
    ),

    ..dormitory(
      楼名: male[学 10],
      住户: [本硕博],
      人数: neutral[6],
      家具: good[上床下桌],
      卫生间: neutral[公卫],
      阳台: good[有],
      楼层: neutral[15 层\ 7 部电梯],
      水电网: good[正常#quest],
      快递站: good[近],
      外卖柜: good[北门柜],
      浴室: neutral[近],
      教学楼: bad[远],
      科研楼: neutral[中],
      装修年份: [2011],
      住宿费: [900],
      说明: [
        可参考#backlink("https://bbs.byr.cn/#!article/Picture/3382014")[北邮人论坛]

        楼道内通风、采光差

        无夜间门禁
      ],
    ),

    ..dormitory(
      楼名: male[学 6\ （4 人间）],
      住户: [本  ],
      人数: neutral[4 (6)],
      家具: bad[上下铺],
      卫生间: bad[独卫],
      阳台: [除#bad[一楼]外#good[有]],
      楼层: bad[6 层\ 无电梯],
      水电网: bad[年均一次夏季停电],
      快递站: good[近],
      外卖柜: good[科研楼柜],
      浴室: neutral[近],
      教学楼: bad[远],
      科研楼: good[近],
      装修年份: [2003],
      住宿费: [1020],
      说明: [
        有翻修计划，正在方案设计阶段
      ],
    ),

    ..dormitory(
      楼名: female[学 4\ （6 人间）],
      住户: [本硕 ],
      人数: neutral[6],
      家具: bad[上下铺],
      卫生间: neutral[独卫],
      阳台: good[有],
      楼层: neutral[12 层\ 2 部电梯],
      水电网: good[正常#quest],
      快递站: neutral[中],
      外卖柜: neutral[北门柜\ 西门柜],
      浴室: [#neutral[中]\ #neutral[部分寝室有独浴]\ #bad[但无热水]],
      教学楼: neutral[中],
      科研楼: bad[远],
      装修年份: [#quest\ 早于 2001],
      住宿费: [850],
      说明: [
        单寝面积略大于学 6

        有和学 8 相同的所有问题
      ],
    ),

    ..dormitory(
      楼名: male[学 6\ （6 人间）],
      住户: [本  ],
      人数: neutral[6],
      家具: bad[上下铺],
      卫生间: bad[独卫],
      阳台: [除#bad[一楼]外#good[有]],
      楼层: bad[6 层\ 无电梯],
      水电网: bad[年均一次夏季停电],
      快递站: good[近],
      外卖柜: good[科研楼柜],
      浴室: neutral[近],
      教学楼: bad[远],
      科研楼: good[近],
      装修年份: [2003],
      住宿费: [1020],
      说明: [
        有翻修计划，正在方案设计阶段
      ],
    ),
  )
}

#let 表格注 = stack(
  dir: ttb,
  spacing: .5em,
  ..(
    [表中列出的所有#mixed[混寝]宿舍楼中性别混合的最小单位均为*楼层*。也即，不存在同一楼层内男女混住的情况。],
    [雁北 D2, E 楼为一个区域，内部部分连通，共用电梯。D2 楼借用 E 楼公卫、水房、浴室，可能需要前往其他层。],
    [雁北 A, B, C, D1 楼为一个区域，内部部分连通。该区域两部电梯均位于 D1 部分，A, B, C 楼需要借道；A, B 二楼与 A 六楼无法通过电梯到达，需要步行一层；B 楼和 D 楼借用位于 A 楼和 C 楼的各一套公卫、水房、浴室，可能需要前往其他层。],
    [如无特别指出，则该楼内大部分卫生间均为蹲便；部分楼低层也设无障碍卫生间，使用坐便。],
  )
    .enumerate()
    .map(((n, it)) => fn(n + 1) + it),
)

#let 好坏条 = stack(
  spacing: .5em,
  good[好],
  context rect(
    width: .1em,
    height: measure(主体表格).height - (2em + 2 * /* stack.spacing */.5em + 3em + 6 * table.inset),
    fill: gradient.linear(green, red, angle: 90deg),
  ),
  bad[坏],
)

= 柏油 · #text(fill: tint)[宿舍]

表格内只讨论绝大多数宿舍的配置，不讨论占比较少的特殊房间。

表格旨在提供信息而非斗个高低，因此不接受类似“某某宿舍排高了，应该往后放”的建议和批评——几乎所有人都觉得别人住得比自己好，笔者收到的大部分反馈只是纯粹的发牢骚。

#{
  set align(center + horizon)

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
      row-gutter: spacing.par-spacing,
      好坏条, 主体表格,
      [], 表格注,
    ),
  )
}

特殊房间列表，仅说明和其他房间不同之处：

#grid(
  columns: 2,
  column-gutter: .5em,
  row-gutter: spacing.par-spacing / 2,
  [- *学 3 大 6 人间*：], [更大的空间，无阳台，有超大落地窗],
  [- *学 4 10 人间*：], [10 人（5 张上下铺），多个房间，无阳台],
  [- *学 5 10 人间*：], [10 人（5 张上下铺），更大的空间，无阳台],
  [- *学 6 套间*：], [由 3 个普通房间合成，另有一个客厅],
  [- *学 10 大 6 人间*：], [更大的空间],
  [- *学 13 有阳台房间*：], [2 人间和 4 人间均存在；阳台大小不一，同时兼有假阳台],
)
