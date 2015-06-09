import "createGraphics" as g

var graphics := g.createGraphics(500,500)
var circle := graphics.addCircle.at(130@130).setRadius(10).colored("red").filled(true).draw
 
var moved := false
var rect := graphics.addRect
rect.location := 100@100
rect.draw
rect.click := { 
  print("clicked rectangle")
  if (moved) then {
    moved := false
    rect.location := 100@100
    rect.update
  } else {
    moved := true
    rect.location := 30@30
    rect.update
  }
}

var customShape := graphics.addCustomShape

customShape.addPoint(40@40)
customShape.addPoint(80@40)
customShape.addPoint(80@80)
customShape.addPoint(40@80)
customShape.color := "blue"
customShape.draw
customShape.click := {
  print("clicked custom shape")
}
