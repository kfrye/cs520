type Book = {
  insert(obj) -> Done

  delete(obj) -> Done

  get(obj) -> Done

  exists(obj) -> Boolean
  
}

class binaryTree.new -> Book {
  var root:Node := emptyNode.new
  
  method helloWorld {
    print("hello world")
  }

  method insert(obj:Object) -> Done {
    var tempNode:Node
    if (root.empty) then {
      root := bookNode.new(obj)
    }
    if (root <= obj) then {
      if (root.left.empty) then {
        root.left := bookNode.new(obj)
      }
      
    }
  }

  method delete(obj) -> Done {
    
  }

  method get(obj) -> Done {
    
  }

  method exists(obj) -> Boolean {
    
  }
  
  method tempPrint {
    print (root)
  }
}

type Node = {
  empty -> Boolean
  ==(other:Object) -> Boolean 
  != (other:Object) -> Boolean 
  >= (other:Object) -> Boolean 
  > (other:Object) -> Boolean 
  < (other:Object) -> Boolean 
  <= (other:Object) -> Boolean 
  //:= (other:Object) -> Boolean 
}

class bookNode.new(newVal:page) -> Node {
  
  def noNode = object { 
    
    def asString is readable = "empty Book"
    method empty{ true }
  }
  
  var value:=newVal
  var left := noNode
  var right := noNode
  
  method empty { false }

  
  
  method ==(other:Object) -> Boolean {}
  method != (other:Object) -> Boolean {}
  method >= (other:Object) -> Boolean {}
  method > (other:Object) -> Boolean {}
  method < (other:Object) -> Boolean {}
  method <= (other:Object) -> Boolean {}
  //method := (other:Object) -> Boolean {}
  
  method asString {
    value.asString
  }

}

class emptyNode.new -> Node {
  method empty { true }
  method ==(other:Object) -> Boolean {EnvironmentException.raise "The Node is empty"}
  method != (other:Object) -> Boolean {EnvironmentException.raise "The Node is empty"}
  method >= (other:Object) -> Boolean {EnvironmentException.raise "The Node is empty"}
  method > (other:Object) -> Boolean {EnvironmentException.raise "The Node is empty"}
  method < (other:Object) -> Boolean {EnvironmentException.raise "The Node is empty"}
  method <= (other:Object) -> Boolean {EnvironmentException.raise "The Node is empty"}


}


factory method page (key', value') {

  var key := key'
  var value := value'
  
  method asString {
    "key: {key}, value: {value}"
  }
  method []:=(k, v) -> Done { 
     
    key := k
    value := v
   }
}


var p:= page(10, "test")


var treeTest := binaryTree.new
treeTest.insert(p)
treeTest.tempPrint
//nodeTest.insert(p)
//nodeTest.tempPrint

