import "page" as p

type Book = {
  insert(obj) -> Number
  delete(obj) -> Done
  get(obj) -> Done
  exists(obj) -> Boolean
}

class binaryTree.new -> Book {
  var root:Node := emptyNode
  var count := 0
  
  method insert(obj:Object) -> Number {
    root := insertNode(root, obj)
    count := count + 1
    return count
  }
  
  method insertNode(node:Node, obj:Object) -> Dictionary {
    if(node.empty) then {
      return bookNode.new(obj)
    }
    
    var tempNode
    if(node.value < obj) then {
      tempNode := insertNode(node.left, obj)
      node.setLeft(tempNode)
    }
    elseif(node.value > obj) then {
      tempNode := insertNode(node.right, obj)
      node.setRight(tempNode)
    }
    else {
      node.update(obj)
    }
    return node
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
  method asString {"A binary tree"}
}

type Node = {
  empty -> Boolean
  left -> Node
  right -> Node
}

class bookNode.new(newVal:p.Page) -> Node {
  var value':=newVal
  var left' := emptyNode
  var right' := emptyNode
  
  method value { value' }
  method left { left' }
  method setLeft(leftNode:Node) { left' := leftNode }
  method right { right' }
  method setRight(rightNode:Node) { right' := rightNode }
  method empty { value'.empty }
  method update (val:p.Page) { value' := val }
  method asString { "booknode with page: {value}"}
}

class emptyNode -> Node {
  method empty { true }
  method left { emptyNode }
  method right { emptyNode }
  method asString { "An empty node" }
}



//test script
var pg:= p.page(10, "test10")
var p9:= p.page(9, "test9")
var pt:= p.page(11, "test11")

var treeTest := binaryTree.new
treeTest.insert(pg)
treeTest.insert(pt)
treeTest.insert(p9)
treeTest.printTree
//print ("")
var pr := p.page(9, "repeat")
treeTest.insert(pr)
treeTest.printTree
//nodeTest.insert(p)
//nodeTest.tempPrint
