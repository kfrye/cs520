factory method createGraphics {
  var stage
  
  stage := native "js" code ‹  
    var myWindow = window.open("", "grace", "height=500, width=500");
    myWindow.document.title = "Grace Graphics";
    var canvas = myWindow.document.createElement("canvas");
    myWindow.document.body.appendChild(canvas);
    var stage = new createjs.Stage(canvas);
    var result = wrapDOMObject(stage);
  ›
   
  method addCircle(id)ofSize(size)ofColor(color)at(location) {
    stage := native "js" code ‹ 
    var stage = unwrapDOMObject(this.data.stage);
    var circle = new createjs.Shape();
    circle.x = var_location.data.x._value;
    circle.y = var_location.data.y._value;
    circle.graphics.beginFill(var_color._value).drawCircle(circle.x, circle.y, var_size._value);
    circle.name = var_id._value;
    stage.addChild(circle);
    stage.update();
    var result = wrapDOMObject(stage);
  ›
  }
  
  method addRect(id)ofWidth(width)ofHeight(height)ofColor(color)at(location) {
    stage := native "js" code ‹
      var stage = unwrapDOMObject(this.data.stage);
      var rect = new createjs.Shape();
      rect.x = var_location.data.x._value;
      rect.y = var_location.data.y._value;
      rect.graphics.beginFill(var_color._value).drawRect(rect.x,rect.y,var_width._value,
                                                         var_height._value);
      rect.name = var_id._value;
      stage.addChild(rect);
      stage.update();
      var result = wrapDOMObject(stage);
    ›
  }
  
  method addPolyStar(id)ofSize(size)withSides(sides)withPointSize(pointSize)withAngle(angle)ofColor(color)at(location) {
    stage := native "js" code ‹
      var stage = unwrapDOMObject(this.data.stage);
      var polyStar = new createjs.Shape();
      polyStar.x = var_location.data.x._value;
      polyStar.y = var_location.data.y._value;
      polyStar.graphics.beginFill(var_color._value).drawPolyStar(polyStar.x,polyStar.y,
                                                    var_size._value,var_sides._value,
                                                    var_pointSize._value, var_angle._value);
      polyStar.name = var_id._value;
      stage.addChild(polyStar);
      stage.update();
      var result = wrapDOMObject(stage);
    ›
  }
  
  method addRoundRect(id)ofWidth(width)ofHeight(height)withRadius(radius)ofColor(color)at(location){
    stage := native "js" code ‹
      var stage = unwrapDOMObject(this.data.stage);
      var roundRect = new createjs.Shape();
      roundRect.x = var_location.data.x._value;
      roundRect.y = var_location.data.y._value;
      roundRect.graphics.beginFill(var_color._value).drawRoundRect(roundRect.x,roundRect.y,var_width._value,
                                                              var_height._value, var_radius._value);
      roundRect.name = var_id._value;
      stage.addChild(roundRect);
      stage.update();
      var result = wrapDOMObject(stage);
    ›
  }
  
  method addEllipse(id)ofWidth(width)ofHeight(height)ofColor(color)at(location){
    stage := native "js" code ‹ 
      var stage = unwrapDOMObject(this.data.stage);
      var ellipse = new createjs.Shape();
      ellipse.x = var_location.data.x._value;
      ellipse.y = var_location.data.y._value;
      ellipse.graphics.beginFill(var_color._value).drawEllipse(ellipse.x, ellipse.y, 
                                                              var_width._value,var_height._value);
      ellipse.name = var_id._value;
      stage.addChild(ellipse);
      stage.update();
      var result = wrapDOMObject(stage);
    ›
  }
  
  method addText(id)withContent(content)ofFont(font)ofColor(color)at(location){
    stage := native "js" code ‹ 
      var stage = unwrapDOMObject(this.data.stage);
      var text = new createjs.Text(var_content._value, var_font._value, var_color._value);
      text.x = var_location.data.x._value;
      text.y = var_location.data.x._value;
      text.name = var_id._value;
      stage.addChild(text);
      stage.update();
      var result = wrapDOMObject(stage);
    ›
  }
}

var test := createGraphics
test.addCircle("test")ofSize(30)ofColor("red")at(30@30)
test.addRect("test2")ofWidth(80)ofHeight(80)ofColor("blue")at(65@65)
test.addPolyStar("test3")ofSize(80)withSides(5)withPointSize(0.6)withAngle(-90)ofColor("red")at(50@50)
test.addRoundRect("test4")ofWidth(80)ofHeight(40)withRadius(10)ofColor("blue")at(20@20)
test.addEllipse("test5")ofWidth(50)ofHeight(100)ofColor("black")at(20@20)
test.addText("textTest")withContent("hello")ofFont("20px Arial")ofColor("black")at(20@20)