dialect "objectdraw"
import "box" as box
import "animation" as an

factory method named(name, floorWidth, floorHeight) {
  inherits box.named(name)
   
  method dance {
    an.while{true} pausing(1000) do{ 
        step
        
    }
  }
  
  method randomMove {
    def x = randomIntFrom(1) to (floorWidth - extent.x)
    def y = randomIntFrom(1) to (floorHeight - extent.y)
    moveTo(x@y)
  }
  
  method step {
    randomMove
  }
  
  method danceWith(partner) {
     an.while{true} pausing(1000) do{ 
        step
        partner.followStep(origin)
    }
    
  }
  
  method followStep(toPoint) {
    moveTo((floorWidth - toPoint.x)@toPoint.y)
  }
}