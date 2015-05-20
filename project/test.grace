method test {
  
  var stage := native "js" code ‹  
    var myWindow = window.open("", "grace", "height=300, width=300");
    myWindow.document.title = "Grace Graphics";
    var canvas = myWindow.document.createElement("canvas");
    myWindow.document.body.appendChild(canvas);
    var stage = new createjs.Stage(canvas);
    var circle = new createjs.Shape();
    
    circle.x = 50;
    circle.y = 50;
    circle.graphics.beginFill("red").drawCircle(0, 0, 20);
    circle.name = "circle1";
    stage.addChild(circle);
    
    var circle2 = new createjs.Shape();
    circle2.x = 100;
    circle2.y = 50;
    circle2.graphics.beginFill("blue").drawCircle(0, 0, 20);
    stage.addChild(circle2);
    
    stage.update();
    var result = wrapDOMObject(stage);
  › 
  print "test"
  native "js" code ‹ 
    var stage = unwrapDOMObject(var_stage);
    var circle = stage.getChildByName("circle1");
    stage.removeChild(circle);
    stage.update();
  ›
}

test