factory method stage {

  method st { return mystage}
  var mystage := new (500, 500)
  var myshape

  method new(width, height) {
    native "js" code ‹
      var width = var_width._value;
      var height = var_height._value;
      var size = "height=" + height.toString() + ",width=" + width.toString()
      myWindow = window.open("", "_blank", size);
      myWindow.document.title = "Grace Graphics";
      var canvas = myWindow.document.createElement("canvas");
      canvas.width = width;
      canvas.height = height;
      myWindow.document.body.appendChild(canvas);
      var stage = new createjs.Stage(canvas);
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
  method update {
    native "js" code ‹
      this.data.mystage.update();
    ›
  }
}
factory method shape {
  var myShape is public := newShape
  var filler is public
  var color
  var location :=0@0
  method setLocation(newLoc) {
    self.location := newLoc
  }
  method newShape {
    native "js" code ‹
            var circle = new createjs.Shape();
            return circle;
          ›
  }
  method setBounds(xB, yB, width, height) {
    native "js" code ‹
            this.data.myShape.setBounds(var_xB, var_yB, var_width, var_height);
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
            return circle;
          ›
  }
}

factory method square {
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

var protoStage := stage
var protoCircle := circle
protoCircle.beginFill("purple")
protoCircle.draw(50)
protoStage.add(protoCircle)
protoCircle.move(100,100)
protoStage.update

var protoCircle1 := circle
protoCircle1.beginFill("red")
protoCircle1.draw(50)
protoStage.add(protoCircle1)
protoCircle1.move(150,150)
protoStage.update

var protoSquare := square
protoSquare.beginFill("green")
protoSquare.draw(25, 25)
protoStage.add(protoSquare)
protoSquare.move(50,50)
protoStage.update

