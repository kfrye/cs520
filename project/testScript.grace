import "graphix" as g

var graphics := g.create(500,200)

def colors = list.with<String>("red", "orange", "yellow", "green", "blue", "purple", "pink", "black")
var index := 1
while { index < 9} do {
  def x = index * 40 + 20
  def circle = graphics.addCircle.at(x@20).setRadius(10).filled(true)
  circle.color := colors[index]
  def note = "note" ++ index
  def newLocation = x@40
  def oldLocation = x@20
  var clicked := true
  circle.click := {
    if(clicked) then {
      graphics.play(note)
      circle.location := newLocation
      clicked := false
    }
    else {
      circle.location := oldLocation
      clicked := true
    }
    circle.draw
  }
  circle.draw
  index := index + 1
}

def custom = graphics.addCustomShape.colored("blue").addPoint(50@100).addPoint(100@100).addPoint(70@120).draw
custom.click := {
  graphics.play("whoosh")
}
def ellipse = graphics.addEllipse.colored("red").at(150@100).filled(true).setWidth(20).setHeight(40).draw
ellipse.click := {
  graphics.play("snap")
}
def text = graphics.addText.colored("purple").setContent("Hello world").at(50@150).draw

def star = graphics.addPolyStar.colored("green").setSides(7).at(200@100)

var clicked := false
star.click := {
  if(clicked) then {
    star.color := "green"
    star.sides := 12
    clicked := false
  }
  else {
    star.sides := 7
    star.color := "red"
    clicked := true
  }
  graphics.play("snap")
  star.draw
}
star.draw