type Book = {
  insert(obj) -> Done

  delete(obj) -> Done

  get(obj) -> Done

  exists(obj) -> Boolean
  
}

class binaryTree.new -> Book {
  var root:Node := bookNode.new(emptyPage)
  method helloWorld {
    print("hello world")
  }

  method insert(obj:Object) -> Done {
    insertNode(root, obj)
  }
  
  method insertNode(node:Node, obj:Object) -> Done {
    if(node.empty) then {
      node.update(obj)
    }
    else {
      if(node.value < obj) then {
        insertNode(node.left, obj)
      }
      else {
        if(node.value > obj) then {
          insertNode(node.right, obj)
        }
        else {
          node.update(obj)
        }
      }
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

class bookNode.new(newVal:Page) -> Node {
  
  
  var value':=newVal
  var left'
  var right'
  var isEmpty := true
  
  method value {
    value'
  }
  
  method left {
    if(empty) then { EnvironmentException.raise "The Node is empty" }
    else {left'}
  }
  
  method right {
    if(empty) then { EnvironmentException.raise "The Node is empty" }
    else {right'}
  }
  
  method empty { isEmpty }

  method setLeft (obj) {
    left' := bookNode.new(obj)
  }
  
  method setRight (obj) {
    right' := bookNode.new(obj)
  }
  
  method update (val:Page) {
    value' := val
    isEmpty := val.empty
    left' := bookNode.new(emptyPage)
    right' := bookNode.new(emptyPage)
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

type Page = {
  empty -> Boolean
  key -> Done 
  value -> Done
  == (other:page) -> Boolean 
  != (other:page) -> Boolean 
  >= (other:page) -> Boolean
  >  (other:page) -> Boolean 
  <  (other:Object) -> Boolean 
  <= (other:Object) -> Boolean 
}

class page (key'', value'') -> Page {

  var key' := key''
  var value' := value''
  
  method empty -> Boolean { false }
  method key {
    key'
  }
  method value {
    value'
  }
  method asString {
    "key: {key}, value: {value}"
  }
  //method []:=(k, v) -> Done {
  //  key' := k
 //   value' := v
  //}
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

class emptyPage -> Page {
  method empty -> Boolean { true }
  method key -> Done {EnvironmentException.raise "The Page is empty"}
  method value -> Done {EnvironmentException.raise "The Page is empty"}
  method == (other:page) -> Boolean {EnvironmentException.raise "The Page is empty"}
  method != (other:page) -> Boolean {EnvironmentException.raise "The Page is empty"}
  method >= (other:page) -> Boolean {EnvironmentException.raise "The Page is empty"}
  method >  (other:page) -> Boolean {EnvironmentException.raise "The Page is empty"}
  method <  (other:Object) -> Boolean {EnvironmentException.raise "The Page is empty"}
  method <= (other:Object) -> Boolean {EnvironmentException.raise "The Page is empty"}
}


var p:= page(10, "test10")
var p9:= page(9, "test9")
var pt:= page(11, "test11")

var treeTest := binaryTree.new
treeTest.insert(p)
treeTest.insert(pt)
treeTest.insert(p9)
treeTest.printTree
//print ("")
//var pr := page(9, "repeat")
//treeTest.insert(pr)
//treeTest.printTree
//nodeTest.insert(p)
//nodeTest.tempPrint

