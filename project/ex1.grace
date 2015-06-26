import "graphix" as g
var graphics := g.create(200,200)
//def b = {
//  print("clicked stage")
//}
//graphics.addStageListener(b)

//def text = graphics.addText.setContent("Press mouse in this window").at(20@20).draw
def input = graphics.addInputBox.setLocation(50@50).setWidth(30).setBorderColor("red")
def codeBlock = {
  print("submitted!")
}

input.onSubmit(codeBlock)
input.draw

def circle = graphics.addCircle.filled(true).draw
circle.click := {
  print("mouse move")
  input.destroy
}
//circle.click := {
//  graphics.addText.setContent("I'm touched").at(180@200).draw
//}
//circle.setpress
//circle.draw    