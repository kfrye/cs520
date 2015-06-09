import "createGraphics" as g

var graphics := g.createGraphics(500,500)
//var circle := graphics.addCircle
//circle.radius := 10
//circle.color := "red"
//circle.fill := true
//circle.draw
//circle.click := { 
//  print("clicked circle") 
//  circle.color := "blue"
//  circle.location := 130@130
//  circle.update
//}

var rect := graphics.addRect
rect.location := 100@100
rect.draw
rect.click := { 
  print("clicked rectangle")
  rect.location := 30@30
  rect.update
}
//
var star := graphics.addPolyStar
star.location := 200@200
star.fill := true
star.color := "orange"
star.draw
star.click := { 
  print "star clicked"
  rect.location := 100@100
  rect.update
}

var customShape := graphics.addCustomShape

customShape.addPoint(40@40)
customShape.addPoint(80@40)
customShape.addPoint(80@80)
customShape.addPoint(40@80)
customShape.color := "red"
customShape.draw()
customShape.click := {
  print "custom clicked"
}
//
//var roundRect := graphics.addRoundRect
//roundRect.location := 200@100
//roundRect.radius := 5
//roundRect.width := 20
//roundRect.height := 20
//roundRect.color := "blue"
//roundRect.fill := true
//roundRect.click := {
//  print("clicked round rect")
//}
//roundRect.draw
//
//var ellipse := graphics.addEllipse
//ellipse.location := 50@400
//ellipse.width := 10
//ellipse.height := 20
//ellipse.color := "blue"
//ellipse.fill := true
//ellipse.draw
//
//var text := graphics.addText
//text.location := 300@300
//text.content := "Create Graphics"
//text.color := "purple"
//text.draw
//text.click := { print ("clicked text")}
//
//var line := graphics.addLine
//line.start := 50@50
//line.end := 100@100
//line.color := "purple"
//line.draw
//line.click := { print ("clicked Line")}
//
