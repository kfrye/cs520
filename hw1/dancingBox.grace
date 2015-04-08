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
  
  method randomMove is confidential {
    moveTo(getRandomPoint)
  }
  
  method getRandomPoint is confidential {
    def x = randomIntFrom(1) to (floorWidth - extent.x)
    def y = randomIntFrom(1) to (floorHeight - extent.y)
    return x@y
  }
  
  method step (p) is confidential {
    //randomMove
    animatedMove(p)
  }
  
  method danceWith(partner) {
    //an.while{true} pausing(1000) do{ 
        def a = getRandomPoint
        step(a)
        
        partner.followStep(a)
    //}
  }
  
  method animatedMove (destination:Point) {
    var t:=trajectory(destination)
    var i:= t.iterator
    an.while{i.havemore} pausing(1) do { 
        moveTo(i.next)
    }
  }
  
  method trajectory (dest:Point) {
    var t:List<Point> := list.empty<Point>
    var from:Number := origin.x
    var to:Number := dest.x
    var s:Number := 1
    if (from > to) then {
      s := -1
    }
    while {from != (to + 1)} do {
      t.add(from@origin.y)
      from := (from + s)
    }
    
    from := origin.y
    to := dest.y
    s := 1
    
    if (from > to) then {
      s := -1
    }

    while {from != (to + 2)} do {
      t.add(dest.x@from)
      from := (from + s)
    }
    return t
  }
  
  method followStep (toPoint) {
    animatedMove((floorWidth -toPoint.x)@toPoint.y)
    //moveTo((floorWidth - toPoint.x)@toPoint.y)
  }
}