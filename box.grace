import "objectdraw" as od

method named(name) {
  object {
    var origin is readable := 0@0
    var heading is public := 0
    var extent is public := defaultExtent
    def noRect = object { 
        inherits Singleton.new
        def asString is readable = "noRect"
        method moveTo { }
        method visible:=(_) { }
    }
    var myRect := noRect
   
    method defaultExtent {
        20@20
    }
    
    method turnBy(degrees) {
        heading := heading + degrees
    }
    
    method showOn(canvas) {
        if (myRect == noRect) then {
            myRect := od.framedRect.at(origin) size(extent.x, extent.y) on (canvas)
        }
        myRect.visible := true
    }
    
    method hide {
        myRect.visible := false
    }
    
    method moveTo(location:Point) {
        origin := location
        myRect.moveTo(origin)
    }
    
    method moveBy(increment:Point) {
        moveTo(origin + increment)
    }
    
    
    
    method growBy(increment:Point) {
        extent := extent + increment
        myRect.setSize(extent.x, extent.y)
    }
    
    method asString {
        "a box named {name}"
    }
    
  }
}