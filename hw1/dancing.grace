dialect "objectdraw"
import "dancingBox" as box
import "timer" as timer
import "animation" as an
 
object {
  def xDim = 400
  def yDim = 400
  inherits graphicApplication.size(xDim,yDim)
  
  text.at(10@10) with ("To start dancing click here") on (canvas)
  
  // Create our boxes
  def bob = box.named("Bob", xDim, yDim)
  def alice = box.named("Alice", xDim, yDim)
 
  // Display our boxes
  initializePartners(bob, alice, 30@30)
  
  // Displays our boxes on the canvas
  method initializePartners(partner1:box, partner2:box, location:Point) {
    def startPartner1:Point = location
    def startPartner2:Point = (xDim - startPartner1.x)@startPartner1.y
    partner1.showOn(canvas)
    partner2.showOn(canvas)
    partner1.moveTo(startPartner1)
    partner2.moveTo(startPartner2)
  }
  
  method onMouseClick(mousePoint) {
    //bob.dance
    //alice.dance
    bob.danceWith(alice)
  }
  startGraphics
}