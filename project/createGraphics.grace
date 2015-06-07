import "createJsGraphicsWrapper" as gr
factory method shape {
  var color is public := "black"
  var stroke is public := "black"
  var fill is public := false
  var location is public := 20@20
  var myStage

  var jsShapeObject
  method click := (block) {
    myStage.addListener(jsShapeObject, block)
  }
  method setBounds {} // abstract method
  method shapeDraw {} // abstract method
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
    myStage.update
    jsShapeObject.move(location.x, location.y) // TODO: Fix this with location variable
    setBounds
    if (fill) then {
      jsShapeObject.beginFill(color)
    } else {
      jsShapeObject.beginStroke(color)
    }
    shapeDraw // TODO: Fix this
    myStage.add(jsShapeObject)
    myStage.update
  }
}


factory method createGraphics(canvasHeight, canvasWidth) {
  var id := 0
  var myWindow
  var shapes := list.empty
  var circles := list.empty
  var rects := list.empty
  var polyStars := list.empty
  var roundRects := list.empty
  var ellipses := list.empty
  var texts := list.empty
  var lines := list.empty
  var customShapes := list.empty
  var stage := gr.stage(canvasHeight, canvasWidth)
  
  method drawall {
    stage.removeAllEventListeners
    for (shapes) do {x -> x.draw}
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
    shapes.add(circle)
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
        jsShapeObject.draw(width, height, location)
      }
    }
    
    shapes.add(rect)
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
      shapes.add(polyStar)
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
      shapes.add(ellipse)
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
          jsText.draw(location, content, font, color)
          stage.add(jsText)
          stage.update
        }
      }
      shapes.add(text)
      text
    }
    
    method addLine {
      def line = object {
        inherits shape
        var start is public := 0@0
        var end is public := 50@50
        
        jsShapeObject := gr.line
        myStage := stage
        
        method setBounds{
          jsShapeObject.setBounds(start, end.x-start.x, end.y-start.y)
        }
        method shapeDraw {
          jsShapeObject.draw(start, end)
        }
      }
      shapes.add(line)
      line
    }
    
    method addCustomShape {
      def customShape = object {
        inherits shape
        jsShapeObject := gr.customShape
        myStage := stage
        
        method setBounds {
          jsShapeObject.setBounds();
        }
        
        method shapeDraw {
          jsShapeObject.draw(color, stroke)
        }
        
        method addPoint(p) {
          jsShapeObject.addPoint(p)
        }
      }
      shapes.add(customShape);
      customShape
    }
}