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

        if(bounds.contains(x,y)) {
          alert("some object is clicked"); 
          callmethod(var_listener, "click", [0]);
          
        }
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
//    print (self.myshape)
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


factory method basicContainer {
  var myShape is public
  var filler is public
  var color
  var location :=0@0
  var listener is public := listener_default
  
  method setLocation(newLoc) {
    self.location := newLoc
  }
  
  method setBounds(bounds, width, height) {
    native "js" code ‹
      var x = var_bounds.data.x._value;
      var y = var_bounds.data.y._value
      this.data.myShape.setBounds(x, y, var_width._value, var_height._value);
    ›
  }
  
  method move(newX,newY) {
    native "js" code ‹
      this.data.myShape.x = var_newX._value;
      this.data.myShape.y = var_newY._value;
    ›
    
  }
}

factory method shape {
  inherits basicContainer
  var myShape is public := new
  
  method new {
    native "js" code ‹
      var dummyShape = new createjs.Shape();
      return dummyShape;
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
}

factory method container {
  inherits basicContainer
  var myShape is public := new
  method new {
    native "js" code ‹
      var container = new createjs.Container();
      container.x = 100;
      container.y = 100;
      return container;
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
  var size is public := 20
  var sides is public := 5
  var pointSize is public := 2
  var angle is public := -90
  method draw(location', size', sides', pointSize', angle') {
    self.size := size'
    self.angle := angle'
    self.pointSize := pointSize'
    self.angle := angle'
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
  method draw(location', width', height', radius') {
    self.location := location'
    self.height := height'
    self.width := width'
    self.radius:= radius'
   
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
  method draw(location', height', width') {
    self.location := location'
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
  inherits basicContainer
//  var myShape is public := new
  var content is public := "Did you forget to set text.content?"
  var font is public := "12px Arial"
  method new {
    return 0
  }
  method text(location', content', font', color') {
    self.myShape := draw(location', content', font', color')
  }
  method draw(location', content', font', color') {
    self.color := color'
    self.location := location'
    self.content := content'
    self.font := font'
    
    native "js" code ‹
      
      var color = this.data.color._value;
      var x = this.data.location.data.x._value;
      var y = this.data.location.data.y._value;
      var content = this.data.content._value;
      var font = this.data.font._value;
      var text = new createjs.Text(content, font, color);
      text.x = x;
      text.y = y;
      bounds = text.getBounds()
      text.setBounds(x, y, bounds.width, bounds.height);
      return text;
    ›
  }
}

factory method line {
  inherits shape
  var start is public := 0@0
  var end is public := 50@50
  
  method draw(start', end'){
    self.location := start'
    self.start := start'
    self.end := end'
    native "js" code ‹ 
      var startX = this.data.start.data.x._value;
      var startY = this.data.start.data.y._value;
      var endX = this.data.end.data.x._value;
      var endY = this.data.end.data.y._value;
      this.data.myShape.graphics.moveTo(startX, startY);
      this.data.myShape.graphics.lineTo(endX, endY);
    ›
  }
}

factory method customShape {
  var lines := list.empty
  var points := list.empty
  
  method addLine(e){
    lines.add(e)
  }
  
  method addPoint(e){
    points.add(e)
  }
  
  method prepareLines(color){
    if(points.size < 2) then { print("Not enough points in custom shape"); return }
    var current := points.removeFirst
    var prev := current
    var currentLine
    while{!points.isEmpty} do {
      current := points.removeFirst
      
      currentLine := line
      currentLine.start := prev
      currentLine.end := current
      currentLine.beginStroke(color)
      addLine(currentLine)
      
      prev := current
    }
  }
  
  method draw {
    for(lines) do { e -> e.draw(e.start, e.end) }
  }
  
  method move(vector) {
    for(lines) do { e -> e.move(vector.x, vector.y)
                  }
  }
  
  method bindStage(s){
    for(lines) do { e -> s.add(e) }
  }
}
var protoStage := stage(500,500)

//var protoText := text
//protoText.text(150@150 , "Hello cruel world", "12px Arial", "black")
////protoCircle.setDefaultBounds
////protoContainer.add(protoCircle)
////protoCircle.move(100,100)
//protoStage.add(protoText)
////protoStage.add(protoContainer)
////protoStage.addListener(protoText, {print ("test")})
//protoStage.update
//
//var protoContainer := container

//var protoCircle := circle
//protoCircle.beginFill("purple")
//protoCircle.draw(50)
//protoCircle.setDefaultBounds
////protoContainer.add(protoCircle)
////protoCircle.move(100,100)
//protoStage.add(protoCircle)
////protoStage.add(protoContainer)
//protoStage.addListener(protoCircle, {print ("test")})
//protoStage.update
//protoStage.removeChild(protoCircle)
//protoStage.update
//protoCircle.move(150,150)
//protoCircle.beginFill("purple")
//protoCircle.draw(50)
//protoStage.add(protoCircle)
//protoStage.update
//var protoSquare := rect
//protoSquare.beginFill("yellow")
//protoSquare.draw(25, 25)
////protoContainer.add(protoSquare)
//protoSquare.move(150,150)
//protoStage.add(protoSquare)
//protoStage.update

//var protoStar := polyStar
//protoStar.beginFill("orange")
//protoStar.draw(35, 35)
//protoStage.add(protoStar)
//protoStar.move(50,150)
//protoStage.update
//
//var protoRoundSquare := roundRect
//protoRoundSquare.beginFill("blue")
//protoRoundSquare.draw(35, 35)
//protoStage.add(protoRoundSquare)
//protoRoundSquare.move(150,150)
//protoStage.update
//
//var protoEllipse := ellipse
//protoEllipse.beginFill("cyan")
//protoEllipse.draw(35, 35)
//protoStage.add(protoEllipse)
//protoEllipse.move(250,150)
//protoStage.update

var custShape := customShape

//var protoLine := line
//protoLine.beginStroke("black")
//protoLine.start := 40@40
//protoLine.end := 80@80
//lineCol.addLine(protoLine)
//
//var protoLine2 := line
//protoLine2.beginStroke("purple")
//protoLine2.start := 80@80
//protoLine2.end := 150@190
//lineCol.addLine(protoLine2)
//
//var protoLine3 := line
//protoLine3.beginStroke("blue")
//protoLine3.start := 150@190
//protoLine3.end := 350@320
//custShape.addLine(protoLine3)
//
//custShape.draw
//custShape.bindStage(protoStage)
//protoStage.update
//
//custShape.move(50@200)
//custShape.draw
//protoStage.update

custShape.addPoint(40@40)
custShape.addPoint(80@80)
custShape.addPoint(150@190)
custShape.addPoint(350@320)
custShape.prepareLines("red")
custShape.draw
custShape.bindStage(protoStage)
protoStage.update