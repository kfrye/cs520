factory method shape {
  var color is public := "black"
  var fill is public := false
  var location is public := 20@20
}

factory method listener_default {
  var clickBlock := { }
  var clickIsSet := false
  var listenerIsCalled := false
  
  method click {
    clickBlock.apply
    listenerIsCalled := false
  }
  
  method click:=(block) {
    clickIsSet := true
    clickBlock := block
  }
  
  method addListener(stage, obj, listener) {
    native "js" code ‹
      var_stage.on("stagemousedown", function(event) { 
        var x = event.stageX;
        var y = event.stageY;
        var bounds = var_obj.getBounds();
        if(bounds.contains(x,y)) {
          callmethod(var_listener, "click", [0]);
        }
      });
    ›
  }
}

method createGraphics(canvasHeight, canvasWidth) {
  object {
    var id := 0
    var myWindow
    var circles := list.empty
    var rects := list.empty
    var polyStars := list.empty
    var roundRects := list.empty
    var ellipses := list.empty
    var texts := list.empty
    
    native "js" code ‹
      var width = var_canvasWidth._value;
      var height = var_canvasHeight._value;
      var size = "height=" + height.toString() + ",width=" + width.toString()
      myWindow = window.open("", "_blank", size);
      myWindow.document.title = "Grace Graphics";
      var canvas = myWindow.document.createElement("canvas");
      canvas.width = width;
      canvas.height = height;
      myWindow.document.body.appendChild(canvas);
      var stage = new createjs.Stage(canvas);
    ›
    method play(sound) {
      native "js" code ‹
        createjs.Sound.play(var_sound._value); 
      ›
    }
  
    method draw {
      native "js" code ‹ stage.removeAllEventListeners(); ›
      for (circles) do { x -> x.draw }
      for (rects) do { x -> x.draw }
      for (polyStars) do { x -> x.draw }
      for (roundRects) do { x -> x.draw }
      for (ellipses) do { x -> x.draw }
      for (texts) do { x -> x.draw }
    }
    
    method addCircle {
      var listener := listener_default
      
      def circle = object {
        inherits shape
        
        var radius is public := 15
        var jsShape is readable
        var name is public := "circle" ++ id.asString()
        id := id + 1
        
        method click:=(block) {
          listener.click := block
        }
        
        method draw {
          native "js" code ‹ 
            if(this.data.jsShape != null) {
              var circle = this.data.jsShape;
              stage.removeChild(circle);
            }
            var circle = new createjs.Shape();
            circle.name = this.data.name._value;
            var x = this.data.location.data.x._value;
            var y = this.data.location.data.y._value;
            var radius = this.data.radius._value
            var color = this.data.color._value
            circle.setBounds(x-radius, y-radius,2*radius, 2*radius);
            if(this.data.fill._value == true) {
              circle.graphics.beginFill(color).drawCircle(x, y, radius);
            }
            else {
              circle.graphics.beginStroke(color).drawCircle(x, y, radius);
            }
            if(var_listener.data.clickIsSet._value == true) {
              callmethod(var_listener, "addListener", [3], stage, circle, var_listener);
            }
            stage.addChild(circle);
            console.log("circle stage");
            console.log(stage);
            stage.update();
            this.data.jsShape = circle;
          ›
        }
      }
      circles.add(circle)
      circle
    }
    
    method addRect {
      var listener := listener_default
      
      def rect = object {
        inherits shape
        var jsShape
        var height is public := 15
        var width is public := 15
        var name is public := "rect" ++ id.asString()
        id := id + 1
        
        method click:=(block) {
          listener.click := block
        }
        
        method draw {
          native "js" code ‹ 
            if(this.data.jsShape != null) {
              var rect = this.data.jsShape;
              stage.removeChild(rect);
            }
            console.log(stage)
            var rect = new createjs.Shape();
            rect.name = this.data.name._value;
            var x = this.data.location.data.x._value;
            var y = this.data.location.data.y._value;
            var height = this.data.height._value
            var width = this.data.width._value
            rect.setBounds(x, y, width, height);
            var color = this.data.color._value
            if(this.data.fill._value == true) {
              rect.graphics.beginFill(color).drawRect(x, y, width, height);
            }
            else {
              rect.graphics.beginStroke(color).drawRect(x, y, width, height);
            }
            if(var_listener.data.clickIsSet._value == true) {
              callmethod(var_listener, "addListener", [3], stage, rect, var_listener);
            }
            stage.addChild(rect);
            stage.update();
            this.data.jsShape = rect;
          ›
        }
      }
      rects.add(rect)
      rect
    }
    
    method addPolyStar {
      var listener := listener_default
      
      def polyStar = object {
        inherits shape
        
        var size is public := 20
        var sides is public := 5
        var pointSize is public := 2
        var angle is public := -90
        var name is public := "polyStar" ++ id.asString()
        id := id + 1
        var jsShape
        
        method click:=(block) {
          listener.click := block
        }
        
        method draw {
          native "js" code ‹ 
            if(this.data.jsShape != null) {
              var jsShape = this.data.jsShape;
              stage.removeChild(jsShape);
            }
            var polyStar = new createjs.Shape();
            polyStar.name = this.data.name._value;
            var x = this.data.location.data.x._value;
            var y = this.data.location.data.y._value;
            var size = this.data.size._value;
            var sides = this.data.sides._value;
            var pointSize = this.data.pointSize._value;
            var color = this.data.color._value;
            var angle = this.data.angle._value;
            polyStar.setBounds(x-size, y-size, 2*size, 2*size);
            if(this.data.fill._value == true) {
              polyStar.graphics.beginFill(color).drawPolyStar(x, y, size, sides,
                pointSize, angle);
            }
            else {
              polyStar.graphics.beginStroke(color).drawPolyStar(x, y, size, sides,
                pointSize, angle);
            }
            if(var_listener.data.clickIsSet._value == true) {
              callmethod(var_listener, "addListener", [3], stage, polyStar, var_listener);
            }
            this.data.jsShape = polyStar
            stage.addChild(polyStar);
            stage.update();
          ›
        }
      }
      polyStars.add(polyStar)
      polyStar
    }
    
    method addRoundRect {
      var listener := listener_default
      
      def roundRect = object {
        inherits shape
        var jsShape
        var height is public := 15
        var width is public := 15
        var radius is public := 15
        var name is public := "roundRect" ++ id.asString()
        id := id + 1
        
        method click:=(block) {
          listener.click := block
        }
        
        method draw {
          native "js" code ‹ 
            if(this.data.jsShape != null) {
              var roundRect = this.data.jsShape;
              stage.removeChild(roundRect);
            }
            var roundRect = new createjs.Shape();
            roundRect.name = this.data.name._value;
            var x = this.data.location.data.x._value;
            var y = this.data.location.data.y._value;
            var height = this.data.height._value
            var width = this.data.width._value
            var radius = this.data.radius._value
            roundRect.setBounds(x, y, width, height);
            var color = this.data.color._value
            if(this.data.fill._value == true) {
              roundRect.graphics.beginFill(color).drawRoundRect(x, y, width, height, radius);
            }
            else {
              roundRect.graphics.beginStroke(color).drawRoundRect(x, y, width, height, radius);
            }
            if(var_listener.data.clickIsSet._value == true) {
              callmethod(var_listener, "addListener", [3], stage, roundRect, var_listener);
            }
            stage.addChild(roundRect);
            stage.update();
            this.data.jsShape = roundRect;
          ›
        }
      }
      roundRects.add(roundRect)
      roundRect
    }
    
    method addEllipse {
      var listener := listener_default
      
      def ellipse = object {
        inherits shape
        var jsShape
        var height is public := 15
        var width is public := 15
        var name is public := "ellipse" ++ id.asString()
        id := id + 1
        
        method click:=(block) {
          listener.click := block
        }
        
        method draw {
          native "js" code ‹ 
            if(this.data.jsShape != null) {
              var ellipse = this.data.jsShape;
              stage.removeChild(ellipse);
            }
            var ellipse = new createjs.Shape();
            ellipse.name = this.data.name._value;
            var x = this.data.location.data.x._value;
            var y = this.data.location.data.y._value;
            var height = this.data.height._value
            var width = this.data.width._value
            ellipse.setBounds(x, y, width, height);
            var color = this.data.color._value
            if(this.data.fill._value == true) {
              ellipse.graphics.beginFill(color).drawEllipse(x, y, width, height);
            }
            else {
              ellipse.graphics.beginStroke(color).drawEllipse(x, y, width, height);
            }
            if(var_listener.data.clickIsSet._value == true) {
              callmethod(var_listener, "addListener", [3], stage, ellipse, var_listener);
            }
            stage.addChild(ellipse);
            stage.update();
            this.data.jsShape = ellipse;
          ›
        }
      }
      ellipses.add(ellipse)
      ellipse
    }
    
    method addText {
      var listener := listener_default
      
      def text = object {
        var location is public := 0@0
        var color is public := "black"
        var jsShape
        var content is public := "Did you forget to set text.content?"
        var font is public := "12px Arial"
        var name is public := "text" ++ id.asString()
        id := id + 1
        
        method click:=(block) {
          listener.click := block
        }
        
        method draw {
          native "js" code ‹ 
            if(this.data.jsShape != null) {
              var text = this.data.jsShape;
              stage.removeChild(text);
            }
            var x = this.data.location.data.x._value;
            var y = this.data.location.data.y._value;
            var color = this.data.color._value;
            var font = this.data.font._value;
            var content = this.data.content._value;
            var text = new createjs.Text(content, font, color);
            text.name = this.data.name._value;
            text.x = x;
            text.y = y;
            bounds = text.getBounds()
            text.setBounds(x, y, bounds.width, bounds.height);
            
            if(var_listener.data.clickIsSet._value == true) {
              callmethod(var_listener, "addListener", [3], stage, text, var_listener);
            }
            stage.addChild(text);
            stage.update();
            console.log(stage);
            this.data.jsShape = text;
          ›
        }
      }
      texts.add(text)
      text
    }
    
    method addContainer {
      def container = object {
        var location is public := 0@0
        
        method add(otherShape) {
          native "js" code ‹
            console.log("container stage");
            console.log(stage);
            stage.update();
            var container = new createjs.Container();
            console.log(var_otherShape);
            var shape = var_otherShape.data.jsShape;
            
            //var shape = stage.getChildByName(var_otherShape.data.name._value);
            container.addChild(shape);
            container.x = this.data.location.data.x._value;
            container.y = this.data.location.data.y._value;
            stage.addChild(container);
            stage.update();
          › 
        }
      }
      container
    }
  }
}

var graphics := createGraphics(500,500)
var circle := graphics.addCircle 
circle.radius := 20
circle.fill := true
graphics.draw
//var text := graphics.addText
//text.location := 5@10
//text.content := "button"
//var rect := graphics.addRect

var container := graphics.addContainer
container.location := 100@100
container.add(circle)
//container.add(text)
//circle.radius := 10
//circle.color := "red"
//circle.fill := true
//circle.draw
//circle.click := { 
//  print("clicked circle") 
//  circle.color := "blue"
//  circle.location := 100@100
//  graphics.draw
//}
//var rect := graphics.addRect
//rect.location := 100@100
//rect.click := { 
//  print("clicked rectangle")
//  graphics.play("note3")
//  circle.location := 100@50
//  circle.color := "red"
//  graphics.draw
//}
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
//
//var ellipse := graphics.addEllipse
//ellipse.location := 50@400
//ellipse.width := 10
//ellipse.height := 20
//ellipse.color := "blue"
//ellipse.fill := true
//
//ellipse.click := {print("clicked ellipse") }
//
//var text := graphics.addText
//text.location := 300@300
//text.content := "Create Graphics"
//text.color := "purple"
//text.click := { print ("clicked text")}
//
//var star := graphics.addPolyStar
//star.location := 200@200
//star.click := { 
//  print "star clicked"
//  graphics.play("note1") 
//}
graphics.draw

