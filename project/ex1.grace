import "graphix" as g
var graphics := g.create(500,500)
//def b = {
//  print("clicked stage")
//}
//graphics.addStageListener(b)

def text = graphics.addText.setContent("Press mouse in this window").at(20@20).draw
def input = graphics.addInputBox
input.draw
//def circle = graphics.addCircle
//circle.click := {
//  print("mouse move")
//}
//circle.click := {
//  graphics.addText.setContent("I'm touched").at(180@200).draw
//}
//circle.setpress
//circle.draw    