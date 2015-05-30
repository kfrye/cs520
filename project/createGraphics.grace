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
        //console.log("x: "+x.toString()+", y: " + y.toString());
        var bounds = var_obj.getBounds();
        console.log(bounds);
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
      var size = "height=" + var_canvasHeight._value.toString() + ",width=" + var_canvasWidth._value.toString()
      myWindow = window.open("", "_blank", size);
      myWindow.document.title = "Grace Graphics";
      var canvas = myWindow.document.createElement("canvas");
      myWindow.document.body.appendChild(canvas);
      var stage = new createjs.Stage(canvas);
      stage.enableDOMEvents(true);
    ›
    
    method draw {
      for (circles) do { x -> x.draw }
      for (rects) do { x -> x.draw }
      for (polyStars) do { x -> x.draw }
      for (roundRects) do { x -> x.draw }
      for (ellipses) do { x -> x.draw }
      for (texts) do { x -> x.draw }
    }
    
    method addCircle {
      var listener := listener_default
      var listenerIsSet := false
      
      def circle = object {
        inherits shape
        
        var radius is public := 15
        var jscircle

        method click:=(block) {
          listener.click := block
        }
        
        method draw {
          jscircle := native "js" code ‹ 
            if(this.data.jscircle != null) {
              var circle = this.data.jscircle;
              stage.removeChild(circle);
            }
            var circle = new createjs.Shape();
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
              console.log(var_listener);
            }
            stage.addChild(circle);
            stage.update();
            var result = circle;
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
        var jsrect
        var height is public := 15
        var width is public := 15
        
        method click:=(block) {
          listener.click := block
        }
        
        method draw {
          jsrect := native "js" code ‹ 
            // Remove any existing rectangles so that we only draw one
            // per object
            if(this.data.jsrect != null) {
              var rect = this.data.jsrect;
              stage.removeChild(rect);
            }
            var rect = new createjs.Shape();
            var x = this.data.location.data.x._value;
            var y = this.data.location.data.y._value;
            var height = this.data.height._value
            var width = this.data.width._value
            rect.setBounds(x, y, x+width, y+height);
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
            var result = rect;
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
        
        method click:=(block) {
          listener.click := block
        }
        
        method draw {
          native "js" code ‹ 
            var polyStar = new createjs.Shape();
            var x = this.data.location.data.x._value;
            var y = this.data.location.data.y._value;
            var size = this.data.size._value;
            var sides = this.data.sides._value;
            var pointSize = this.data.pointSize._value;
            var color = this.data.color._value;
            var angle = this.data.angle._value;
            polyStar.setBounds(x-size, y-size, 2*size, 2*size);
            console.log(polyStar.getBounds());
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
        var jsRoundRect
        var height is public := 15
        var width is public := 15
        var radius is public := 15
        
        method click:=(block) {
          listener.click := block
        }
        
        method draw {
          jsRoundRect := native "js" code ‹ 
            // Remove any existing rectangles so that we only draw one
            // per object
            if(this.data.jsRoundRect != null) {
              var roundRect = this.data.jsRoundRect;
              stage.removeChild(roundRect);
            }
            var roundRect = new createjs.Shape();
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
              rect.graphics.beginStroke(color).drawRoundRect(x, y, width, height, radius);
            }
            if(var_listener.data.clickIsSet._value == true) {
              callmethod(var_listener, "addListener", [3], stage, roundRect, var_listener);
            }
            stage.addChild(roundRect);
            stage.update();
            var result = roundRect;
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
        var jsEllipse
        var height is public := 15
        var width is public := 15
        
        method click:=(block) {
          listener.click := block
        }
        
        method draw {
          jsEllipse := native "js" code ‹ 
            // Remove any existing ellipses so that we only draw one
            // per object
            if(this.data.jsEllipse != null) {
              var ellipse = this.data.jsEllipse;
              stage.removeChild(ellipse);
            }
            var ellipse = new createjs.Shape();
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
            var result = ellipse;
          ›
        }
      }
      ellipses.add(ellipse)
      ellipse
    }
    
    method addText {
      var listener := listener_default
      
      def text = object {
        
        var location is public
        var color is public := "black"
        var jsText
        var content is public := "Did you forget to set text.content?"
        var font is public := "12px Arial"
        
        method click:=(block) {
          listener.click := block
        }
        
        method draw {
          jsText := native "js" code ‹ 
            // Remove any existing text so that we only draw one
            // per object
            if(this.data.jsText != null) {
              var text = this.data.jsText;
              stage.removeChild(text);
            }
            var x = this.data.location.data.x._value;
            var y = this.data.location.data.y._value;
            var color = this.data.color._value;
            var font = this.data.font._value;
            var content = this.data.content._value;
            var text = new createjs.Text(content, font, color);
            bounds = text.getBounds()
            text.setBounds(bounds.x, bounds.y, bounds.width, bounds.height);
            
            if(var_listener.data.clickIsSet._value == true) {
              callmethod(var_listener, "addListener", [3], stage, text, var_listener);
            }
            stage.addChild(text);
            stage.update();
            var result = text;
          ›
        }
      }
      texts.add(text)
      text
    }
  }
}

var graphics := createGraphics(200,200)
var circle := graphics.addCircle
circle.radius := 10
circle.color := "red"
circle.fill := true
circle.draw
circle.click := { 
  print("clicked circle") 
  circle.color := "blue"
  circle.location := 30@30
  circle.draw
}
//var rect := graphics.addRect
//rect.location := 100@100
//rect.click := { 
//  print("clicked rectangle")
//  circle.location := 100@50
//  circle.color := "red"
//  circle.draw
//}
//
//var roundRect := graphics.addRoundRect
//roundRect.location := 50@50
//roundRect.radius := 5
//roundRect.width := 20
//roundRect.height := 20
//roundRect.color := "blue"
//roundRect.fill := true
//roundRect.draw
//
//roundRect.click := {
//  print("clicked round rect")
//  roundRect.color := "red"
//  roundRect.location := 200@200
//  roundRect.draw
//}
//
//var ellipse := graphics.addEllipse
//ellipse.location := 80@80
//ellipse.width := 10
//ellipse.height := 20
//ellipse.color := "blue"
//ellipse.fill := true
//ellipse.draw
//
//ellipse.click := {
//  print("clicked ellipse")
//}

var text := graphics.addText
text.location := 50@50
text.click := { print ("clicked text")}
var star := graphics.addPolyStar
star.location := 100@100
star.click := { print ("clicked star") }
graphics.draw

