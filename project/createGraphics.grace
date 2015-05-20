factory method createGraphics {
  var stage
  
  stage := native "js" code ‹  
    var myWindow = window.open("", "grace", "height=300, width=300");
    myWindow.document.title = "Grace Graphics";
    var canvas = myWindow.document.createElement("canvas");
    myWindow.document.body.appendChild(canvas);
    var stage = new createjs.Stage(canvas);
    var result = wrapDOMObject(stage);
  ›
   
  method addCircle(id)ofSize(size)ofColor(color)at(location) {
    def x = location.x
    def y = location.y
    stage := native "js" code ‹ 
    var stage = unwrapDOMObject(this.data.stage);
    var circle = new createjs.Shape();
    circle.x = var_location.data.y._value;
    circle.y = var_location.data.x._value;
    circle.graphics.beginFill(var_color._value).drawCircle(0, 0, var_size._value);
    circle.name = var_id._value;
    stage.addChild(circle);
    stage.update();
    var result = wrapDOMObject(stage);
  ›
  }
}

var test := createGraphics
test.addCircle("test")ofSize(30)ofColor("red")at(30@30)