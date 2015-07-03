import "graphix" as g
var graphics := g.create(200,200)

var i := 1
var startAngle := 360
var startPoint := 125@125

var circle := graphics.addCircle.colored("blue").setRadius(5).at(125@125).draw

var block := {
  if(i <= 8) then {
    def endAngle = 360 - ((180/8)*i)
    def arc = graphics.addArc.at(125@125).setStartAngle(startAngle).setEndAngle(endAngle)
    arc.setRadius(100).colored("red").setAnticlockwise(true).draw
    startAngle := endAngle
    
    def hDist = 125 - ((100 / 7) * i)
    def endPoint = hDist@125
    def line = graphics.addLine.setStart(startPoint).setEnd(endPoint).draw
    startPoint := endPoint
    
    circle.location := hDist@125
    circle.draw
    i := i + 1
  }
  else {
    graphics.clearTicker
  }
}

graphics.tickEvent(block, 1)