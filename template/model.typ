#let font = (
  serif: ((name: "STIX Two Text", covers: "latin-in-cjk"), "Source Han Serif SC"),
  mono: ("Fira Code",),
  math: ("STIX Two Math", "STIX Two Text", "Source Han Serif SC"),
)

#let colors = (link: blue)

#let stroke = (paint: luma(50%), thickness: .75pt)

#let backlink(url, body) = {
  // show: underline.with(offset: .25em, stroke: (
  //   thickness: .5pt,
  // ))

  // workaround
  show: box.with(
    outset: (bottom: .25em),
    stroke: (bottom: (paint: colors.link, thickness: .5pt)), // avoid context
  )

  link(url, body + " " + text(font: font.mono, weight: "light")[↗️])
}
