factory method eventListener {
  var clickBlock := { }
  
  method click {
    clickBlock.apply
  } 
  
  method click:=(block) {
    clickBlock := block
  }
  
  method addListener(stage, obj, listener) {
    native "js" code ‹
      var_stage.on("stagemousedown", function(event) { 
        var x = event.stageX;
        var y = event.stageY;
        var bounds = var_obj.getBounds();
        if(bounds.contains(x,y)) {
          callmethod(var_listener, "click", [0]);
        }
      });
    ›
  }
}

factory method stage(width', height') {
  var mystage := new (width', height')
  var createJsGraphics
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
      myWindow.document.body.appendChild(canvas);
      this.stage = stage
      return stage; 
    ›
  }
  method add(shape) {
    self.createJsGraphics := shape.createJsGraphics
    native "js" code ‹
      this.data.mystage.addChild(this.data.createJsGraphics);
    ›
  }
  method removeChild(shape) {
    self.createJsGraphics := shape.createJsGraphics
    native "js" code ‹
      this.data.mystage.removeChild(this.data.createJsGraphics);
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
    var anObject := containerTypeObject.createJsGraphics
    native "js" code ‹
      callmethod(var_listener, "addListener", [3], this.data.mystage, var_anObject, var_listener);
    ›
  }
}

factory method commonGraphics{
  var createJsGraphics is public
  var color
  var location :=0@0
  var listener is public := eventListener
  
  method setLocation(newLoc) {
    self.location := newLoc
  }
  
  method setBounds(bounds, width, height) {
    native "js" code ‹
      var x = var_bounds.data.x._value;
      var y = var_bounds.data.y._value
      this.data.createJsGraphics.setBounds(x, y, var_width._value, var_height._value);
    ›
  }
  
  method move(newX,newY) {
    native "js" code ‹
      this.data.createJsGraphics.x = var_newX._value;
      this.data.createJsGraphics.y = var_newY._value;
    ›
  }
}

factory method shape {
  inherits commonGraphics

  createJsGraphics := new
  
  method new {
    native "js" code ‹
      return new createjs.Shape();
    ›
  }

  method clear {
    native "js" code ‹
      this.data.createJsGraphics.graphics.clear();
    ›
  }
  method beginFill(color') {
    self.color := color'
    native "js" code ‹
      var color = this.data.color._value;
      this.data.createJsGraphics.graphics.beginFill(color);
    ›
  }
  method beginStroke(color') {
    self.color := color'
    native "js" code ‹
      var color = this.data.color._value;
      this.data.createJsGraphics.graphics.beginStroke(color);
    ›
  }
}

factory method container {
  inherits commonGraphics

  createJsGraphics := new
  method new {
    native "js" code ‹
      return new createjs.Container();
    ›
  }

  method add(anObject') {
    var anObject := anObject'.createJsGraphics
    native "js" code ‹
      this.data.createJsGraphics.addChild(this.data.obj);
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

      this.data.createJsGraphics.graphics.drawCircle(x, y, radius);
      var circle = this.data.createJsGraphics;
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
  method draw(height', width', location') {
    self.height := height'
    self.width := width'
    native "js" code ‹
      var x = this.data.location.data.x._value;
      var y = this.data.location.data.y._value;
      var height = this.data.height._value
      var width = this.data.width._value
      this.data.createJsGraphics.graphics.drawRect(x, y, width, height);
    ›
  }
}

factory method polyStar {
  inherits shape
  var size is public := 20
  var sides is public := 5
  var pointSize is public := 2
  var angle is public := -90
  method draw(size', sides', pointSize', angle') {
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
      this.data.createJsGraphics.graphics.drawPolyStar(x, y, size, sides,pointSize, angle);
    ›
  }
}

factory method roundRect {
  inherits shape
  var height
  var width
  var radius is public := 15
  method draw(width', height', radius') {
    self.height := height'
    self.width := width'
    self.radius:= radius'
   
    native "js" code ‹ 
      var x = this.data.location.data.x._value;
      var y = this.data.location.data.y._value;
      var height = this.data.height._value
      var width = this.data.width._value
      var radius = this.data.radius._value
      this.data.createJsGraphics.graphics.drawRoundRect(x, y, width, height, radius);
  ›
  }
}

factory method ellipse {
  inherits shape
  var height
  var width
  method draw(width', height') {
    self.height := height'
    self.width := width'
    native "js" code ‹ 
      var x = this.data.location.data.x._value;
      var y = this.data.location.data.y._value;
      var height = this.data.height._value
      var width = this.data.width._value
      this.data.createJsGraphics.graphics.drawEllipse(x, y, width, height);
    ›
  }
}

factory method text {
  inherits commonGraphics

  var content is public := "Did you forget to set text.content?"
  var font is public := "12px Arial"
  method new {
    return 0
  }
  // This is necessary so that Grace waits for the Javascript part of the
  // innerDraw to return before continuing
  method draw(content', font', color') {
    self.createJsGraphics := innerDraw(content', font', color')
  }
  method innerDraw(content', font', color') is confidential {
    self.color := color'
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
      this.data.createJsGraphics.graphics.moveTo(startX, startY);
      this.data.createJsGraphics.graphics.lineTo(endX, endY);
    ›
  }
}

factory method customShape {
  inherits shape
  var points := list.empty
  var stroke;
  var current;
  var leftMost;
  var rightMost;
  var topMost;
  var bottomMost;
  
  method addPoint(p){
    calcBounds(p)
    points.add(p)
  } 
  method calcBounds(p) is confidential {
    if(points.isEmpty) then {
      topMost := p.y
      bottomMost := p.y
      leftMost := p.x
      rightMost := p.x
    } else {
      if(p.x < leftMost) then { leftMost := p.x }
      if(p.x > rightMost) then { rightMost := p.x }
      if(p.y < topMost) then { topMost := p.y }
      if(p.y > bottomMost) then {bottomMost := p.y}
    }
  }
  method draw(stroke', fill'){
    if(points.size < 2) then { print("Not enough points in custom shape"); return }
    
    self.current := points.first
    self.stroke := stroke';
    self.color := fill';
    
    native "js" code ‹
        var color = this.data.color._value;
        var stroke = this.data.stroke._value;
        var startX = this.data.current.data.x._value;
        var startY = this.data.current.data.y._value;
        this.data.createJsGraphics.graphics.beginFill(color);
        this.data.createJsGraphics.graphics.beginStroke(stroke);
        this.data.createJsGraphics.graphics.moveTo(startX, startY);
      ›
    for(points) do {x ->
      current := x
      native "js" code ‹ 
        var endX = this.data.current.data.x._value;
        var endY = this.data.current.data.y._value;
        this.data.createJsGraphics.graphics.lineTo(endX, endY);
      ›
    }
    native "js" code ‹
      this.data.createJsGraphics.graphics.closePath()
    ›
  }
  
  method setBounds {
    var bounds := leftMost@topMost
    super.setBounds(bounds, rightMost - leftMost, bottomMost - topMost)
  }
}