factory method shape {
  var color is public := "black"
  var fill is public := false
  var location is public := 20@20
}

factory method listener_default {
  var clickBlock := { }
  var clickIsSet := false
  
  method click(x, y) {
    print("x: {x}, y:{y}")
    //clickBlock.apply
  }
  
  method click:=(block) {
    clickIsSet := true
    clickBlock := block
  }
}

method createGraphics(canvasHeight, canvasWidth) {
  var listener := listener_default
  
  object {
    var isOpened : Boolean := false
    var id := 0
    var myWindow
    var circles := list.empty
    var rects := list.empty
    
    if(!isOpened) then {
      native "js" code ‹
        var size = "height=" + var_canvasHeight._value.toString() + ",width=" + var_canvasWidth._value.toString()
        myWindow = window.open("", "_blank", size);
        myWindow.document.title = "Grace Graphics";
        var canvas = myWindow.document.createElement("canvas");
        myWindow.document.body.appendChild(canvas);
        var stage = new createjs.Stage(canvas);
        stage.enableDOMEvents(true);
        unwrapDOMObject(stage);
        stage.addEventListener("stagemousedown", function(event) { 
          var x = event.stageX;
          var y = event.stageY;
          console.log(x);
          console.log(y);
          callmethod(var_listener, "click", [2], new GraceNum(x), new GraceNum(y));
        });
      ›
      isOpened := true
    }
    
    method draw {
      for (circles) do { x -> x.draw }
      for (rects) do { x -> x.draw }
    }
    
    method addCircle {
      def circle = object {
        inherits shape
        
        var radius is public := 15
        
        method click:=(block) {
          listener.click := block
        }
        
        method draw {
          native "js" code ‹ 
            unwrapDOMObject(stage);
            var circle = new createjs.Shape();
            var x = this.data.location.data.x._value;
            var y = this.data.location.data.y._value;
            var radius = this.data.radius._value
            var color = this.data.color._value
            if(this.data.fill._value == true) {
              circle.graphics.beginFill(color).drawCircle(x, y, radius);
            }
            else {
              circle.graphics.beginStroke(color).drawCircle(x, y, radius);
            }
            
            
            
            stage.addChild(circle);
            stage.update();
          ›
        }
      }
      circles.add(circle)
      circle
    }
    
     
    method addRect {
      
      def rect = object {
        inherits shape
        
        var height is public := 15
        var width is public := 15
        
        method click:=(block) {
          listener.click := block
        }
        
        method draw {
          native "js" code ‹ 
            var rect = new createjs.Shape();
            var x = this.data.location.data.x._value;
            var y = this.data.location.data.y._value;
            var height = this.data.height._value
            var width = this.data.width._value
            var color = this.data.color._value
            if(this.data.fill._value == true) {
              rect.graphics.beginFill(color).drawRect(x, y, width, height);
            }
            else {
              rect.graphics.beginStroke(color).drawRect(x, y, width, height);
            }
            stage.addChild(circle);
            stage.update();
          ›
        }
      }
      rects.add(circle)
      rect
    }
  //  
  //  method addPolyStar(id)ofSize(size)withSides(sides)withPointSize(pointSize)withAngle(angle)ofColor(color)at(location) {
  //    stage := native "js" code ‹
  //      //var stage = unwrapDOMObject(this.data.stage);
  //      var polyStar = new createjs.Shape();
  //      polyStar.x = var_location.data.x._value;
  //      polyStar.y = var_location.data.y._value;
  //      polyStar.graphics.beginFill(var_color._value).drawPolyStar(polyStar.x,polyStar.y,
  //                                                    var_size._value,var_sides._value,
  //                                                    var_pointSize._value, var_angle._value);
  //      polyStar.name = var_id._value;
  //      stage.addChild(polyStar);
  //      stage.update();
  //      //var result = wrapDOMObject(stage);
  //    ›
  //  }
  //  
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
circle.click := { print("clicked") }
graphics.draw

