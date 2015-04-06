dialect "objectdraw"
import "box" as box
import "timer" as timer
import "animation" as an

object {
  def xDim = 400
  def yDim = 400
  inherits graphicApplication.size(xDim,yDim)
  

  
  def b = box.named("B")
  def a = box.named("A")
  b.showOn(canvas)
  a.showOn(canvas)
  b.moveTo(30@30)
  a.moveTo((xDim-30)@(yDim - 30))
  var x
  var y
  var p
  var or
  var i: Number := 1
  var j: Number := 1
  var t: Number := 10
  //method onMousePress(mousePoint) {
  //  text.at(180@200) with ("I'm touched") on (canvas)
  //}
  
  //method onMouseRelease(mousePoint) {
  //  canvas.clear
  //}
  
  method onMouseClick(mousePoint) {
    print "{mousePoint.x}"
    i := 1
    j := 1
    an.while{i < 100} pausing(1000) do {
      x := randomIntFrom(1) to (xDim)
      y := randomIntFrom(1) to (yDim)
      or := b.origin
      b.moveTo(or.x@y)
   
      
      a.moveTo(a.origin.x@(yDim-y))
      an.while{j < t } pausing(1000)do{ 
        j := j + 1
      }
      
      a.moveTo((xDim-x)@a.origin.y)
      b.moveTo(x@y)
      i := i + 1
      j := 1
      an.while{j < t } pausing(1000)do{ 
        j := j + 1
      }
      j := 1
      
    }
  }
  startGraphics
}