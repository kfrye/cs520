import "createGraphNew" as gr
factory method shape {
  var color is public := "black"
  var fill is public := false
  var location is public := 20@20
}

factory method createGraphics(canvasHeight, canvasWidth) {
  var id := 0
  var myWindow
  var circles := list.empty
  var rects := list.empty
  var polyStars := list.empty
  var roundRects := list.empty
  var ellipses := list.empty
  var texts := list.empty
  var stage := gr.stage(canvasHeight, canvasWidth)
  
  method draw {
      stage.removeAllEventListeners
      for (circles) do { x -> x.draw }
      for (rects) do { x -> x.draw }
      for (polyStars) do { x -> x.draw }
      for (roundRects) do { x -> x.draw }
      for (ellipses) do { x -> x.draw }
      for (texts) do { x -> x.draw }
  }
  method play(sound) {
      native "js" code ‹
        createjs.Sound.play(var_sound._value); 
      ›
    }
  method addCircle {
      
      def circle = object {
        inherits shape
        var radius is public := 15
        var jscircle

        method click := (block) {
          stage.addListener(jscircle, block)
        }
        method draw {
          jscircle:=gr.circle
          jscircle.setLocation(location)
          jscircle.setBounds(location, radius*2, radius*2)
          if (fill) then {
            jscircle.beginFill(color)
          } else {
            jscircle.beginStroke(color)
          }
          jscircle.draw(radius)
          stage.add(jscircle)
          stage.update
        }
        method update {
          stage.removeChild(jscircle)
          stage.update
          draw
        }
      }
      
      circles.add(circle)
      circle
  }
  
  method addRect {
      
      def rect = object {
        inherits shape
        var jsrect
        var height is public := 15
        var width is public := 15
        
        method click := (block) {
          stage.addListener(jsrect, block)
        }
        
        method draw {
          stage.removeChild(jsrect)
          jsrect:=gr.rect
          jsrect.setLocation(location)
          jsrect.setBounds(location, width, height)
          if (fill) then {
            jsrect.beginFill(color)
          } else {
            jsrect.beginStroke(color)
          }
          jsrect.draw(width, height)
          stage.add(jsrect)
          stage.update
        }
        method update {
          stage.removeChild(jsrect)
          stage.update
          draw
        }
      }
      
      rects.add(rect)
      rect
    }
}

var graphics := createGraphics(500,500)
var circle := graphics.addCircle
circle.radius := 10
circle.color := "red"
circle.fill := true
circle.draw
circle.click := { 
  print("clicked circle") 
  circle.color := "blue"
  circle.location := 30@30
  circle.update
}

var rect := graphics.addRect
rect.location := 100@100
rect.draw
rect.click := { 
  print("clicked rectangle")
  graphics.play("note3")
  circle.location := 100@50
  circle.color := "red"
  graphics.draw
}
