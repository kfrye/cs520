method test {
  native "js" code ‹  
    var myWindow = window.open("", "grace", "height=300, width=300");
    myWindow.document.title = "Grace Graphics";
    var canvas = myWindow.document.createElement("canvas");
    myWindow.document.body.appendChild(canvas);
    var stage = new createjs.Stage(canvas);
    var circle = new createjs.Shape();
    circle.x = 50;
    circle.y = 50;
    circle.graphics.beginFill("red").drawCircle(0, 0, 20);
    stage.addChild(circle);
    stage.update();
  › 
}

test