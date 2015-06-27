import "graphix" as g
var graphics := g.create(200,200)

def text = graphics.addText.setContent("Press mouse in this window").at(20@20).draw

graphics.addStageDownListener := {
  graphics.addText.setContent("I'm touched").at(180@200).draw
}
graphics.addStageUpListener := {
  graphics.clear
}
graphics.drawall