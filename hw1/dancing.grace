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
  var flag: Number := 0

  
  method onMouseClick(mousePoint) {
    i := 1
    an.while{i < 100} pausing(1000) do {
      x := randomIntFrom(15) to (xDim-30)
      y := randomIntFrom(15) to (yDim-30)
      or := b.origin
      
      if ( flag == 0 ) then {
        b.moveTo(or.x@y)
        a.moveTo(a.origin.x@(yDim-y))
        flag := 1
      } else {
        a.moveTo((xDim-x)@a.origin.y)
        b.moveTo(x@b.origin.y)
        flag := 0
      }
      
    }
  }
  startGraphics
}