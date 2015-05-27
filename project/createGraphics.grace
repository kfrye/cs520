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
            circle.setBounds(x - radius, y - radius, x + radius, y + radius);
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
        
        var size is public := 40
        var sides is public := 5
        var pointSize is public := 0.5
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
            var left = 
            polyStar.setBounds(x-size/2, y-size/2, x+size/2, y+size/2);
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

  //  method addRoundRect(id)ofWidth(width)ofHeight(height)withRadius(radius)ofColor(color)at(location){
  //    stage := native "js" code ‹
  //      //var stage = unwrapDOMObject(this.data.stage);
  //      var roundRect = new createjs.Shape();
  //      roundRect.x = var_location.data.x._value;
  //      roundRect.y = var_location.data.y._value;
  //      roundRect.graphics.beginFill(var_color._value).drawRoundRect(roundRect.x,roundRect.y,var_width._value,
  //                                                              var_height._value, var_radius._value);
  //      roundRect.name = var_id._value;
  //      stage.addChild(roundRect);
  //      stage.update();
  //      //var result = wrapDOMObject(stage);
  //    ›
  //  }
  //  
  //  method addEllipse(id)ofWidth(width)ofHeight(height)ofColor(color)at(location){
  //    stage := native "js" code ‹ 
  //      //var stage = unwrapDOMObject(this.data.stage);
  //      var ellipse = new createjs.Shape();
  //      ellipse.x = var_location.data.x._value;
  //      ellipse.y = var_location.data.y._value;
  //      ellipse.graphics.beginFill(var_color._value).drawEllipse(ellipse.x, ellipse.y, 
  //                                                              var_width._value,var_height._value);
  //      ellipse.name = var_id._value;
  //      stage.addChild(ellipse);
  //      stage.update();
  //      //var result = wrapDOMObject(stage);
  //    ›
  //  }
  }
  
}

var graphics := createGraphics(200,200)
var circle := graphics.addCircle
circle.radius := 10
circle.color := "red"
circle.fill := true
circle.draw
//circle.color := "blue"
//circle.update
circle.click := { 
  print("clicked circle") 
  circle.color := "blue"
  circle.location := 30@30
  circle.draw
}
var rect := graphics.addRect
rect.location := 100@100
rect.click := { 
  print("clicked rectangle")
  circle.location := 100@50
  circle.color := "red"
  circle.draw
}
//var star := graphics.addPolyStar
//star.location := 0@0
//star.click := { print ("clicked star") }
graphics.draw

