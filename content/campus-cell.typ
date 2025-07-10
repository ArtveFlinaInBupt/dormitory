#import "/template/util.typ": *

// @typstyle off
#let specified-cell(color, body, ..args) = tcell(
  fill: color.background,
  ..args.named(),
  text(fill: color.foreground)[#body]
)

#let 沙河-colour = (background: teal.lighten(85%), foreground: teal.darken(25%))
#let 海南-colour = (background: green.lighten(85%), foreground: green.darken(25%))
#let 本部-colour = (background: red.lighten(85%), foreground: red.darken(25%))
#let invalid-colour = (background: white, foreground: white)

#let 沙河-cell(body: [沙], ..args) = specified-cell(沙河-colour, body, ..args)
#let 海南-cell(body: [海南], ..args) = specified-cell(海南-colour, body, ..args)
#let 本部-cell(body: [本], ..args) = specified-cell(本部-colour, body, ..args)
#let invalid-cell(body: [], ..args) = specified-cell(invalid-colour, body, ..args)
