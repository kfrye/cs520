import "createJsGraphicsWrapper" as gr

var ret := 1

factory method shape {
  var color is public := "black"
  var fill is public := false
  var location is public := 20@20
  var myStage
  var jsShapeObject
  
  method colored(c) {
    color := c
    self
  } 
  
  method filled(f) {
    fill := f
    self
  } 
  
  method at(l) {
    location := l
    self
  }
  
  method click := (block) {
    myStage.addListener(jsShapeObject, block)
  }
  method setpress {
    jsShapeObject.setpress
  }
  method mouseup := (block) {
    myStage.addMouseUpListener(jsShapeObject, block)
  }
  method setBounds {} // abstract method
  method shapeDraw {} // abstract method
  method draw {
    clearDuplicate
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
    self
  }
  
  method clearDuplicate is confidential{
    myStage.removeChild(jsShapeObject)
    jsShapeObject.clear
  }
}

factory method create(canvasHeight, canvasWidth) {
  var shapes := list.empty
  var inputs := list.empty
  var stage := gr.stage(canvasHeight, canvasWidth)

  method drawall {
    for (shapes) do {x -> x.draw}
  }
  method play(sound) {
    native "js" code ‹
      createjs.Sound.play(var_sound._value); 
    ›
  }
  method addStageListener(block) {
    stage.addStageListener(block)
  }
  
  method clear {
    stage.removeAllChildren
    stage.removeAllEventListeners
    stage.update
  }
  
  method addCircle {
    def circle = object {
      inherits shape
      var radius is public := 15
      jsShapeObject := gr.circle
      myStage:=stage
      
      method setRadius(r) {
        radius := r
        self
      }
      method setBounds is confidential {
        def x = location.x - radius
        def y = location.y - radius
        jsShapeObject.setBounds(x@y, radius*2, radius*2)
      }
      method shapeDraw is confidential {
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
      
      method setHeight(h) { 
        height := h 
        self
      }
      method setWidth(w) { 
        width := w 
        self
      }
      method setBounds is confidential {
        jsShapeObject.setBounds(location, width, height)
      }
      method shapeDraw is confidential {
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
        method setSize(s) {
          size := s 
          self
        }
        method setSides(s) {
          sides := s
          self
        }
        method setPointSize(p) {
          pointSize := p
          self
        }
        method setAngle(a) {
          angle := a
          self
        }
        method setBounds is confidential {
          var x := location.x - size
          var y := location.y - size
          jsShapeObject.setBounds(x@y, 2*size, 2*size)
        }
        method shapeDraw is confidential {
          jsShapeObject.draw(size, sides, pointSize, angle)
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
        method setHeight(h) {
          height := h
          self
        }
        method setWidth(w) {
          width := w
          self
        }
        method setRadius(r) {
          radius := r
          self
        }
        method setBounds is confidential {
          jsShapeObject.setBounds(location, width, height)
        }
        method shapeDraw is confidential {
          jsShapeObject.draw(location, width, height, radius)
        }
      }
      shapes.add(roundRect)
      roundRect
    }
    
    method addEllipse {
      
      def ellipse = object {
        inherits shape
        var height is public := 15
        var width is public := 15
        
        jsShapeObject := gr.ellipse
        myStage:=stage
        method setWidth(w) {
          width := w
          self
        }
        method setHeight(h) {
          height := h
          self
        }
        method setBounds is confidential {
          jsShapeObject.setBounds(location, width, height)
        }
        method shapeDraw is confidential {
          jsShapeObject.draw(width, height)
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
        method at(l) {
          location := l
          self
        }
        method colored(c) {
          color := c
          self
        }
        method setContent(c) {
          content := c
          self
        }
        method click:=(block) {
          stage.addListener(jsText, block)
        }
        
        method draw {
          jsText := gr.text
          jsText.setLocation(location)
          jsText.draw(content, font, color)
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
        method setStart(s) {
          start := s
          self
        }
        method setEnd(e) {
          end := e
          self
        }
        method setBounds is confidential {
          jsShapeObject.setBounds(start, end.x-start.x, end.y-start.y)
        }
        method shapeDraw is confidential {
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
        var width is public := 10 
        var height is public := 10
        
        method setBounds is confidential {
          jsShapeObject.setBounds
        }
        
        method shapeDraw is confidential {
          jsShapeObject.draw(color, color)
        }
        
        method addPoint(p) {
          jsShapeObject.addPoint(p)
          self
        }
        
      }
      shapes.add(customShape);
      customShape
    }
    
    method addInputBox {
        def input = object {
            var width is public := 50
            var height is public := 20
            var location is public := 0@0
            var fontSize is public := 14
            var fontFamily is public := "Arial"
            var fontColor is public := "black"
            var backgroundColor is public := "white"
            var borderColor is public := "black"
            var jsInputObject := 0
            var submitBlock := {}
            
            method setWidth(w) {
                width := w
                self
            }
            
            method setHeight(h) {
                height := h
                self
            }
            
            method setLocation(l) {
                location := l
                self
            }
            
            method setBorderColor(c) {
              borderColor := c
              self
            }
            
            method draw {
                jsInputObject := gr.inputBox(stage)
                jsInputObject.location := location
                jsInputObject.width := width
                jsInputObject.height := height
                jsInputObject.fontSize := fontSize
                jsInputObject.fontFamily := fontFamily
                jsInputObject.fontColor := fontColor
                jsInputObject.backgroundColor := backgroundColor
                jsInputObject.borderColor := borderColor
                jsInputObject.onSubmit(jsInputObject,submitBlock)
                jsInputObject.draw
                self
            }
            
            method focus {
              jsInputObject.focus
            }
            
            method onSubmit(block) {
              if(jsInputObject != 0) then {
                jsInputObject.onSubmit(jsInputObject, block)
              }
              submitBlock := block
            }
            
            method destroy {
                jsInputObject.destroy
            }
        }
        inputs.add(input)
        input
    }
}
