type Book = {
  insert(obj) -> Done

  delete(obj) -> Done

  get(obj) -> Done

  exists(obj) -> Boolean
  
}

class binaryTree.new -> Book {
  var root:Node := bookNode.new(emptyPage)

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
  ==(other:Object) -> Boolean 
  != (other:Object) -> Boolean 
  >= (other:Object) -> Boolean 
  > (other:Object) -> Boolean 
  < (other:Object) -> Boolean 
  <= (other:Object) -> Boolean 
}

class bookNode.new(newVal:Page) -> Node {
  var value':=newVal
  
  // Set left/right to a temp object. This prevents never-ending recursive initialization
  def noPage = object {
    method empty { true }
  }
  var left' := noPage
  var right' := noPage
  
  method value { value' }
  
  method left { 
    // If left is using a temp object, set it to a "real" empty object
    if(left' == noPage) then { left' := bookNode.new(emptyPage) }
    left' 
  }
  method right { 
    // If right is using a temp object, set it to a "real" empty object
    if(right' == noPage) then { right' := bookNode.new(emptyPage) }
    right' 
  }
  method empty { 
    if(value'.empty) then { true }
    else { false } 
  }
  method update (val:Page) { value' := val }
  method == (other:Object) -> Boolean { other == value }
  method != (other:Object) -> Boolean { other != value }
  method >= (other:Object) -> Boolean { other >= value }
  method >  (other:Object) -> Boolean { other > value }
  method <  (other:Object) -> Boolean { other < value }
  method <= (other:Object) -> Boolean { other <= value }
  method asString { value.asString }
}

type Page = {
  empty -> Boolean
  notEmpty -> Boolean
  key -> Done 
  value -> Done
  == (other:page) -> Boolean 
  != (other:page) -> Boolean 
  >= (other:page) -> Boolean
  >  (other:page) -> Boolean 
  <  (other:Object) -> Boolean 
  <= (other:Object) -> Boolean 
}

class page (key', value') -> Page {
  method empty -> Boolean { false }
  method notEmpty -> Boolean { !empty }
  method key {
    key'
  }
  method value {
    value'
  }
  method asString {
    "key: {key}, value: {value}"
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
}

class emptyPage -> Page {
  method empty -> Boolean { true }
  method notEmpty -> Boolean { false }
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
print ("")
var pr := page(9, "repeat")
treeTest.insert(pr)
treeTest.printTree
//nodeTest.insert(p)
//nodeTest.tempPrint
