import "createGraphNew" as gr
factory method shape {
  var color is public := "black"
  var fill is public := false
  var location is public := 20@20
  var myStage

  var jsShapeObject
  method click := (block) {
    myStage.addListener(jsShapeObject, block)
  }
  method setBounds {
//     jsShapeObject.setBounds(location, bWidth, bHeight)
  }
  method shapeDraw {}
  method draw {
    jsShapeObject.setLocation(location)
    setBounds
    if (fill) then {
      jsShapeObject.beginFill(color)
    } else {
      jsShapeObject.beginStroke(color)
    }
    shapeDraw
    myStage.add(jsShapeObject)
    myStage.update
  }
  method update {
    myStage.removeChild(jsShapeObject)
    print ("updating circle")
    myStage.update
    jsShapeObject.move(130, 130)
    setBounds
    if (fill) then {
      jsShapeObject.beginFill(color)
    } else {
      jsShapeObject.beginStroke(color)
    }
    shapeDraw
    myStage.add(jsShapeObject)
    myStage.update
  }

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
  
  method drawall {
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
      jsShapeObject :=gr.circle
      myStage:=stage
      method setBounds{
        jsShapeObject.setBounds(location, radius*2, radius*2)
      }
      method shapeDraw {
        jsShapeObject.draw(radius)
      }
    }
    circles.add(circle)
    circle
  }
  
  method addRect {
      
    def rect = object {
      inherits shape
      jsShapeObject := gr.rect
      var height is public := 15
      var width is public := 15
      myStage:=stage
      
      
      method setBounds{
        jsShapeObject.setBounds(location, width, height)
      }
      method shapeDraw {
        jsShapeObject.draw(width, height)
      }
    }
    
    rects.add(rect)
    rect
  }
  method addPolyStar {
      def polyStar = object {
        inherits shape
        
        var size is public := 20
        var sides is public := 5
        var pointSize is public := 2
        var angle is public := -90
        
        jsShapeObject := gr.polyStar
        myStage:=stage
        
        
        method setBounds{
          var x := location.x - size
          var y := location.y - size
          jsShapeObject.setBounds(x@y, 2*size, 2*size)
        }
        method shapeDraw {
          jsShapeObject.draw(location, size, sides, pointSize, angle)
        }
      }
      polyStars.add(polyStar)
      polyStar
    }
    method addRoundRect {
      
      def roundRect = object {
        inherits shape
        var height is public := 15
        var width is public := 15
        var radius is public := 15
        jsShapeObject := gr.roundRect
        myStage:=stage
        
        method setBounds{
          jsShapeObject.setBounds(location, width, height)
        }
        method shapeDraw {
          jsShapeObject.draw(location, width, height, radius)
        }
      }
      roundRects.add(roundRect)
      roundRect
    }
    
    method addEllipse {
      
      def ellipse = object {
        inherits shape
        var height is public := 15
        var width is public := 15
        
        jsShapeObject := gr.ellipse
        myStage:=stage
        
        method setBounds{
          jsShapeObject.setBounds(location, width, height)
        }
        method shapeDraw {
          jsShapeObject.draw(location, width, height)
        }
      }
      ellipses.add(ellipse)
      ellipse
    }
    
    method addText {
      
      def text = object {
        var location is public
        var color is public := "black"
        var jsText
        var content is public := "Did you forget to set text.content?"
        var font is public := "12px Arial"
        
        method click:=(block) {
          stage.addListener(jsText, block)
        }
        
        method draw {
          jsText := gr.text
          jsText.text(location, content, font, color)
          stage.add(jsText)
          stage.update
        }
      }
      texts.add(text)
      text
    }
}
