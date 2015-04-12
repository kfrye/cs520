dialect "objectdraw"
import "dancingBox" as box
import "timer" as timer
import "animation" as an
 
object {
  def xDim = 400
  def yDim = 400
  inherits graphicApplication.size(xDim,yDim)
  
  def bob = box.named("Bob", xDim, yDim)
  def alice = box.named("Alice", xDim, yDim)
 
  bob.showOn(canvas)
  alice.showOn(canvas)
  bob.moveTo(30@30)
  alice.moveTo((xDim - 30)@30)
  text.at(10@10) with ("To start dancing click here") on (canvas)

  
  method onMouseClick(mousePoint) {
    //bob.dance
    //alice.dance
    bob.danceWith(alice)
  }
  startGraphics
}