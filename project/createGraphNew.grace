factory method listener_default {
  var clickBlock := { }
  var clickIsSet := false
  var listenerIsCalled := false
  
  method click {
    clickBlock.apply
    listenerIsCalled := false
  }
  
  method click:=(block) {
    print("clickblock is set ")
    clickIsSet := true
    clickBlock := block
  }
  
  method addListener(stage, obj, listener) {
    native "js" code ‹
      var_stage.on("stagemousedown", function(event) { 
        var x = event.stageX;
        var y = event.stageY;
        var bounds = var_obj.getBounds();
        
        alert("some object is clicked" + x + y); 
        callmethod(var_listener, "click", [0]);
      });
    ›
  }
  
  method test{
    print ("test method")
  }
}

factory method stage(width', height') {
  var mystage := new (width', height')
  var myshape
  method new(width, height) {
    native "js" code ‹
      var width = var_width._value;
      var height = var_height._value;
      var size = "height=" + height.toString() + ",width=" + width.toString()
      myWindow = window.open("", "_blank", size);
      myWindow.document.title = "Grace Graphics";
      
      var canvas = document.createElement("canvas");
      var stage = new createjs.Stage(canvas);
      canvas = stage.canvas;
      canvas.width = width;
      canvas.height = height;
//      stage.on("stagemousedown", function(evt) {
//          alert("stage click");
//});
      myWindow.document.body.appendChild(canvas);
      
      
 
      
      this.stage = stage
      return stage; 
      
    ›
  }
  method add(shape) {
    self.myshape := shape.myShape
    native "js" code ‹
      this.data.mystage.addChild(this.data.myshape);
    ›
  }
  method removeChild(child) {
    self.myshape := child.myShape
    native "js" code ‹
      this.data.mystage.removeChild(this.data.myshape);
    ›
  }
  method removeAllEventListeners {native "js" code ‹ this.data.mystage.removeAllEventListeners(); ›}
  method update {
    native "js" code ‹
      this.data.mystage.update();
    ›
  }
  method addListener(containerTypeObject, block) {
    containerTypeObject.listener.click := block
    var listener := containerTypeObject.listener
    var anObject := containerTypeObject.myShape
    native "js" code ‹
      callmethod(var_listener, "test", [0]);
      callmethod(var_listener, "addListener", [3], this.data.mystage, var_anObject, var_listener);
    ›
  }
}
factory method container {
  var myShape is public := newContainer
  var location :=100@100
  var obj
  method setLocation(newLoc) {
    self.location := newLoc
  }
  method newContainer {
    native "js" code ‹
      var container = new createjs.Container();
      container.x = 100;
      container.y = 100;
      return container;
    ›
  }
  
  method move(newX,newY) {
    native "js" code ‹
      this.data.myShape.x = this.data.myShape.x+var_newX._value;
      this.data.myShape.y = this.data.myShape.y+var_newY._value;
    ›
    
  }
  method add(anObject') {
    var anObject := anObject'.myShape
    self.obj := anObject'.myShape
    native "js" code ‹
      this.data.myShape.addChild(this.data.obj);
    ›
  }
}

factory method drawable {
  var filler is public
  var color is public
  var location :=0@0
  var listener is public := listener_default
  var myShape is public
  
  method setLocation(newLoc) {
    self.location := newLoc
  }
  
  method click:=(block) {
    listener.click := block
  }
}

factory method textDrawable {
  inherits drawable
  myShape := newText
  
  method newText {
      native "js" code ‹
      var text = new createjs.Text("TESTTESTTEST", "12px Arial", "black");
      return text;
    ›
  }
}
factory method shape {
  inherits drawable
  myShape := newShape
  
  method newShape {
    native "js" code ‹
      var shape = new createjs.Shape();
      return shape;
    ›
  }
  method setBounds(bounds, width, height) {
    native "js" code ‹
      var x = var_bounds.data.x._value;
      var y = var_bounds.data.y._value
      this.data.myShape.setBounds(x, y, var_width._value, var_height._value);
    ›
  }
  
  method beginFill(color') {
    self.color := color'
    self.filler := native "js" code ‹
      
      var color = this.data.color._value;
      var filler = this.data.myShape.graphics.beginFill(color);
      return filler;
    ›
  }
  method beginStroke(color') {
    self.color := color'
    self.filler := native "js" code ‹
      
      var color = this.data.color._value;
      var filler = this.data.myShape.graphics.beginStroke(color);
      return filler;
    ›
  }
  method move(newX,newY) {
    native "js" code ‹
      this.data.myShape.x = this.data.myShape.x+var_newX._value;
      this.data.myShape.y = this.data.myShape.y+var_newY._value;
    ›
    
  }
}

factory method circle {
  inherits shape
  var radius
  method draw(radius') {
    self.radius := radius'
    native "js" code ‹
      var x = this.data.location.data.x._value;
      var y = this.data.location.data.y._value;
      var radius = this.data.radius._value;

      this.data.myShape.graphics.drawCircle(x, y, radius);
      var circle = this.data.myShape;
//      circle.on("click", function(evt) {
//    alert("circle click");
//});
      return circle;
    ›
  }
  method setDefaultBounds {
    super.setBounds(self.location, self.radius*2, self.radius*2)
  }
}

factory method rect {
  inherits shape
  var height
  var width
  method draw(height', width') {
    self.height := height'
    self.width := width'
    native "js" code ‹
      var x = this.data.location.data.x._value;
      var y = this.data.location.data.y._value;
      var height = this.data.height._value
      var width = this.data.width._value
      this.data.myShape.graphics.drawRect(x, y, width, height);
     
    ›

  }
}

factory method polyStar {
  inherits shape
  var height
  var width
  var size is public := 20
  var sides is public := 5
  var pointSize is public := 2
  var angle is public := -90
  method draw(height', width') {
    self.height := height'
    self.width := width'
    native "js" code ‹ 
      var x = this.data.location.data.x._value;
      var y = this.data.location.data.y._value;
      var size = this.data.size._value;
      var sides = this.data.sides._value; 
      var pointSize = this.data.pointSize._value;
      var angle = this.data.angle._value;
      this.data.myShape.graphics.drawPolyStar(x, y, size, sides,pointSize, angle);
    ›
  }
  
}

factory method roundRect {
  inherits shape
  var height
  var width
  var radius is public := 15
  method draw(height', width') {
    self.height := height'
    self.width := width'
   
    native "js" code ‹ 
      var x = this.data.location.data.x._value;
      var y = this.data.location.data.y._value;
      var height = this.data.height._value
      var width = this.data.width._value
      var radius = this.data.radius._value
      this.data.myShape.graphics.drawRoundRect(x, y, width, height, radius);
  ›
  }
}

factory method ellipse {
  inherits shape
  var height
  var width
  var radius is public := 15
  method draw(height', width') {
    self.height := height'
    self.width := width'
    native "js" code ‹ 
      var x = this.data.location.data.x._value;
      var y = this.data.location.data.y._value;
      var height = this.data.height._value
      var width = this.data.width._value
      this.data.myShape.graphics.drawEllipse(x, y, width, height);
    ›
  }
}

factory method text {
  inherits textDrawable
  
  var content is public := "Did you forget to set text.content?"
  var font is public := "12px Arial"
        
  method draw {
    native "js" code ‹ 
      var xVal = this.data.location.data.x._value;
      var yVal = this.data.location.data.y._value;
      var colorVal = this.data.color._value;
      var fontVal = this.data.font._value;
      var content = this.data.content._value;
      
      this.data.myShape.set({text:content, font:fontVal, color:colorVal, x:xVal, y:yVal});
      bounds = this.data.myShape.getBounds();
      this.data.myShape.setBounds(xVal, yVal, bounds.width, bounds.height);
    ›
  }
}



var protoStage := stage(500,500)
//var protoContainer := container

var protoCircle := circle
protoCircle.beginStroke("purple")
protoCircle.draw(50)
protoCircle.setDefaultBounds
//protoContainer.add(protoCircle)
//protoCircle.move(100,100)
protoStage.add(protoCircle)
//protoStage.add(protoContainer)
protoStage.addListener(protoCircle, {print ("test")})
protoStage.update

var protoSquare := rect
protoSquare.beginFill("yellow")
protoSquare.draw(25, 25)
//protoContainer.add(protoSquare)
protoSquare.move(150,150)
protoStage.add(protoSquare)
protoStage.update

var protoStar := polyStar
protoStar.beginFill("orange")
protoStar.draw(35, 35)
protoStage.add(protoStar)
protoStar.move(50,150)
protoStage.update

var protoRoundSquare := roundRect
protoRoundSquare.beginFill("blue")
protoRoundSquare.draw(35, 35)
protoStage.add(protoRoundSquare)
protoRoundSquare.move(150,150)
protoStage.update

var protoEllipse := ellipse
protoEllipse.beginFill("cyan")
protoEllipse.draw(35, 35)
protoStage.add(protoEllipse)
protoEllipse.move(250,150)
protoStage.update

var protoText := text
protoText.content := "Testing"
protoText.color := "red"
protoText.click := {
  print "Text clicked"
}
protoText.draw
protoStage.add(protoText)
protoStage.update
