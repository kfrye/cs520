dialect "objectdraw"
import "dancingBox" as box
import "timer" as timer
import "animation" as an

object {
  def xDim = 400
  def yDim = 400
  inherits graphicApplication.size(xDim,yDim)
  

  
  def b = box.named("B", xDim, yDim)
  def a = box.named("A", xDim, yDim)
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
    b.danceWith(a)
  }
  startGraphics
}