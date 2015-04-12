import "objectdraw" as od
import "box" as box
import "animation" as an

factory method named(name, floorWidth, floorHeight) {
  inherits box.named(name)
  
  // Dances on the canvas by itself
  method dance {
    an.while{true} pausing(1000) do{ 
        step
    }
  }
  
  method randomMove is confidential {
    moveTo(getRandomPoint)
  }
  
  method getRandomPoint is confidential {
    def x = od.randomIntFrom(extent.x) to (floorWidth - extent.x)
    def y = od.randomIntFrom(1) to (floorHeight - extent.y)
    return x@y
  }
  
  // Color can be set after the object is drawn on the canvas
  method setColor(color) {
    myRect.color := color
  }
  
  // Draws the object on the canvas. Uses a random color
  method showOn(canvas) {
        if (myRect == noRect) then {
            myRect := od.framedRect.at(origin) size(extent.x, extent.y) on (canvas)
            myRect.color := randomColor
        }
        myRect.visible := true
    }
  
  // Gets a random color
  method randomColor is confidential {
    od.color .r (randomChannel) g (randomChannel) b (randomChannel)
  }
  
  // Gets a random number used for the 3 color channels
  method randomChannel is confidential {
    od.randomIntFrom(1) to (254)
  }
  
  // Moves to the next point in the dance floor
  method step (p) is confidential {
    animatedMove(p)
  }
  
  // Dances with another dancingBox
  method danceWith(partner) {
    def delay = calculateAnimationDelay
    an.while{true} pausing(delay) do{ 
        def a = getRandomPoint
        step(a)
        
        partner.followStep(a)
    }
  }
  
  // In order to synchronize the box movements, a delay needs to be added to the dance
  // The value of 3 was determined through trial and error
  method calculateAnimationDelay {
    (floorWidth + floorHeight) * 3
  }
  
  // Moves to the next calculated point on the dance floor by moving to each point
  // in between the origin and it
  method animatedMove (destination:Point) {
    var t:=trajectory(destination)
    var i:= t.iterator
    an.while{i.havemore} pausing(1) do { 
        moveTo(i.next)
    }
  }
  
  // Creates a list of points to animate the next move
  method trajectory (dest:Point) {
    var t:List<Point> := list.empty<Point>
    var from:Number := origin.x
    var to:Number := dest.x
    var stepDir:Number := 1
    
    // Check if we have to move backwards
    if (from > to) then {
      stepDir := -1
    }
    
    // Create set of points for moving horizontally
    while {from != (to + 1)} do {
      t.add(from@origin.y)
      from := (from + stepDir)
    }
    
    from := origin.y
    to := dest.y
    stepDir := 1
    
    if (from > to) then {
      stepDir := -1
    }

    // Create set of points for moving vertically
    while {from != (to + 2)} do {
      t.add(dest.x@from)
      from := (from + stepDir)
    }
    return t
  }
  
  // Tell box where its dance partner is moving
  method followStep (toPoint) {
    animatedMove((floorWidth -toPoint.x)@toPoint.y)
  }
}