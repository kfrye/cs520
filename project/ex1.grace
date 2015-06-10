import "graphix" as g
var graphics := g.create(500,500)
def b = {
  print("clicked stage")
}
graphics.addStageListener(b)

def text = graphics.addText.setContent("Press mouse in this window").at(20@20).draw

