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
    if (root.empty) then {
      root := bookNode.new(obj)
    } else {
      var tempNode:Node := root
      while { tempNode.empty != true } do {
        print ("Tree is not empty")
        if (tempNode.value < obj) then {
          if (tempNode.left.empty) then {
            tempNode.setLeft(obj)
            return
          }
          tempNode := tempNode.left
        } 
        else { 
          if (tempNode.value > obj) then {
            print ("Go right")
            if (tempNode.right.empty) then {
              tempNode.setRight(obj)
              return
            }
            tempNode := tempNode.right
          } 
          else {
            print ("Match")
            tempNode.update(obj)
            return
          }
        }
      }
      tempNode := bookNode.new(obj)

    }
  }

  method delete(obj) -> Done {
    
  }

  method get(obj) -> Done {
    
  }

  method exists(obj) -> Boolean {
    
  }
  method recPrint(aNode:Node) {
    if (aNode.empty) then {
      return
    } else {
      print (aNode)
      recPrint(aNode.left)
      recPrint(aNode.right)
    }
  }
  
  method printTree {
    recPrint(root)
  }
  
  method tempPrint {
    print (root)
  }
}

type Node = {
  empty -> Boolean
  update -> Done
  setLeft -> Done
  setRight -> Done
  ==(other:Object) -> Boolean 
  != (other:Object) -> Boolean 
  >= (other:Object) -> Boolean 
  > (other:Object) -> Boolean 
  < (other:Object) -> Boolean 
  <= (other:Object) -> Boolean 
  //[]:= (other:Object) -> Boolean 
}

class bookNode.new(newVal:page) -> Node {
  
  
  var value':=newVal
  var left' := emptyNode.new
  var right' := emptyNode.new
  
  method value {
    value'
  }
  method left {
    left'
  }
  
  method right {
    right'
  }
  
  method empty { false }

  method setLeft (obj) {
    left' := bookNode.new(obj)
  }
  
  method setRight (obj) {
    right' := bookNode.new(obj)
  }
  
  method update (val:page) {
    value' := val
  }
  method == (other:Object) -> Boolean {
    return other == value
  }
  method != (other:Object) -> Boolean {
        return other != value

  }
  method >= (other:Object) -> Boolean {
        return other >= value

  }
  method >  (other:Object) -> Boolean {
      return other > value
  
  }
  method <  (other:Object) -> Boolean {
    return other < value
    
  }
  method <= (other:Object) -> Boolean {
        return other <= value

  }
  //method := (other:Object) -> Boolean {}
  
  method asString {
    value.asString
  }

}

class emptyNode.new -> Node {
  method empty { true }
  method setLeft -> Done {EnvironmentException.raise "The Node is empty"}
  method setRight -> Done {EnvironmentException.raise "The Node is empty"}

  method update -> Done {EnvironmentException.raise "The Node is empty"}
  method ==(other:Object) -> Boolean {EnvironmentException.raise "The Node is empty"}
  method != (other:Object) -> Boolean {EnvironmentException.raise "The Node is empty"}
  method >= (other:Object) -> Boolean {EnvironmentException.raise "The Node is empty"}
  method > (other:Object) -> Boolean {EnvironmentException.raise "The Node is empty"}
  method < (other:Object) -> Boolean {EnvironmentException.raise "The Node is empty"}
  method <= (other:Object) -> Boolean {EnvironmentException.raise "The Node is empty"}


}


factory method page (key'', value'') {

  var key' := key''
  var value' := value''
  method key {
    key'
  }
  method value {
    value'
  }
  method asString {
    "key: {key}, value: {value}"
  }
  method []:=(k, v) -> Done {
    key' := k
    value' := v
  }
  method == (other:page) -> Boolean {
    return (other.key == self.key) 
  }
  method != (other:page) -> Boolean {
    return (other.key != self.key)
  }
  method >= (other:page) -> Boolean {
    return (other.key >= self.key)
  }
  method >  (other:page) -> Boolean {
    return (other.key > self.key)
  }
  method <  (other:Object) -> Boolean {
    return (other.key < self.key)  
  }
  method <= (other:Object) -> Boolean {
    return (other.key <= self.key)
  }
  //method := (other:Object) -> Boolean {}
  
}


var p:= page(10, "test10")
var p9:= page(9, "test9")
var pt:= page(11, "test11")

var treeTest := binaryTree.new
treeTest.insert(p)
p := pt
treeTest.insert(pt)
treeTest.insert(p9)
treeTest.printTree
print ("")
var pr := page(9, "repeat")
treeTest.insert(pr)
treeTest.printTree
//nodeTest.insert(p)
//nodeTest.tempPrint

