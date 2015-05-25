import "timer" as timer
import "dom" as dom

factory method shape(location: Point, id) {
  
  var _color := "black"
  var _fill := false
  
  method color(c:String) {
    _color := c
  }
  
  method fill(f:Boolean) {
    _fill := f
  }
}

factory method createGraphics(height, width) {
  var isOpened : Boolean := false
  var id := 0
  var myWindow
  var circles := list.empty
  
  if(!isOpened) then {
    native "js" code ‹
      wrapDOMObject(var_height)
      var size = "height=" + var_height._value.toString() + ",width=" + var_width._value.toString()
      myWindow = window.open("", "_blank", size);
      myWindow.document.title = "Grace Graphics";
      var canvas = myWindow.document.createElement("canvas");
      myWindow.document.body.appendChild(canvas);
      var stage = new createjs.Stage(canvas);
      stage.enableDOMEvents(true);
    ›
    isOpened := true
  }
  
  method draw {
    for (circles) do { x -> x.draw }
  }
  
  method addCircleAt(location) {
    var common := shape(location, id)
    def circle = object {
      method color:=(c) {
        common.color(c)
      }
      method fill:=(f) {
        common.fill(f)
      }
      
      method draw {
        native "js" code ‹ 
          unwrapDOMObject(stage);
          var circle = new createjs.Shape();
          circle.x = var_location.data.x._value;
          circle.y = var_location.data.y._value;
          if(var_common.data._fill._value == true) {
            circle.graphics.beginFill(var_common.data._color._value).drawCircle(5, 5, 10);
          }
          else {
            circle.graphics.beginStroke(var_common.data._color._value).drawCircle(5, 5, 10);
          }
          circle.addEventListener("click", function(event) { callmethod(var_clicker, "click", [0])});
          stage.addChild(circle);
          stage.update();
        ›
      }
    }
    circles.add(circle)
    circle
  }
  
   
//  method addRect(id)ofWidth(width)ofHeight(height)ofColor(color)at(location) {
//    stage := native "js" code ‹
//      //var stage = unwrapDOMObject(this.data.stage);
//      var rect = new createjs.Shape();
//      rect.x = var_location.data.x._value;
//      rect.y = var_location.data.y._value;
//      rect.graphics.beginFill(var_color._value).drawRect(rect.x,rect.y,var_width._value,
//                                                         var_height._value);
//      rect.name = var_id._value;
//      stage.addChild(rect);
//      stage.update();
//      //var result = wrapDOMObject(stage);
//    ›
//  }
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

var graphics := createGraphics(200,200)
var circle := graphics.addCircleAt(30@30)
circle.color := "red"
circle.fill := true
graphics.draw

