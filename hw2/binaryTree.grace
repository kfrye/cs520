dialect "page"

type Book = {
  insert(obj) -> Number
  delete(obj) -> Done
  get(obj) -> Done
  valueExists(obj) -> Boolean
  keyExists(obj) -> Boolean
}

factory method binaryTree {
  var root:Node := emptyNode
  var count' := 0
  
  method copy(oldRoot:Node) -> Book {
    var newTree := binaryTree.new
    newTree.copyRoot(oldRoot)
    return newTree
  }
  
  method new -> Book {
    object {
      method insert(obj:Object) -> Number {
        root := insertNode(root, obj)
        count' := count + 1
        return count
      }
      
      method count { count' }
  
      method insertNode(node:Node, obj:Object) -> Node {
        if(node.empty) then {
          return bookNode.new(obj)
        }
        
        var tempNode
        if(node.page < obj) then {
          tempNode := insertNode(node.left, obj)
          node.setLeft(tempNode)
        }
        elseif(node.page > obj) then {
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
      
      method valueExists(obj) -> Boolean {
        valueExistsNode(root, obj)
      }
      
      method valueExistsNode(node:Node, obj) {
        if(node.empty) then { false }
        elseif(node.value == obj) then { true }
        elseif(!valueExistsNode(node.left, obj)) then {
          valueExistsNode(node.right, obj)
        }
        else {true}
      }
    
      method keyExists(obj) -> Boolean {
        keyExistsNode(root, obj)
      }
      
      method keyExistsNode(node:Node, obj) -> Boolean {
        if(node.empty) then { false }
        elseif(obj == node.key) then { true }
        elseif(obj < node.key) then { keyExistsNode(node.left, obj) }
        else { keyExistsNode(node.right, obj) }
      }
      
      method copy -> Book {
        binaryTree.copy(root)
      }
      
      method copyRoot(oldRoot:Node) -> Done {
        root := bookNode.new(oldRoot.copyValue)
        copyNode(root, oldRoot)
      }
      
      method copyNode(newNode:Node, oldNode:Node) -> Node {
        if(oldNode.empty) then { return newNode }
        count' := count + 1
        def newLeft = bookNode.new(oldNode.left.copyValue)
        newNode.setLeft(copyNode(newLeft, oldNode.left))
        def newRight = bookNode.new(oldNode.right.copyValue)
        newNode.setRight(copyNode(newRight, oldNode.right))
        return newNode
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
        print("Printing a tree...")
        recPrint(root)
      }
      
      method tempPrint {
        print (root)
      }
      method asString {"A binary tree"}
    }
  }
  
}

type Node = {
  empty -> Boolean
  left -> Node
  right -> Node
  copyValue -> Page
}

class bookNode.new(newVal:Page) -> Node {
  var left' := emptyNode
  var right' := emptyNode
  var page' := newVal
  
  method page { page' }
  method value { page.value }
  method key { page.key }
  method left { left' }
  method setLeft(leftNode:Node) { left' := leftNode }
  method right { right' }
  method setRight(rightNode:Node) { right' := rightNode }
  method empty { page.empty }
  method update (val:Page) { page' := val }
  method asString { "booknode with page: {value}"}
  method copyValue { page.copy }
}

class emptyNode -> Node {
  method empty { true }
  method left { emptyNode }
  method right { emptyNode }
  method asString { "An empty node" }
  method copyValue { emptyPage }
}



//test script
var pg:= page(10, "test10")
var p9:= page(9, "test9")
var pt:= page(11, "test11")

var treeTest := binaryTree.new
treeTest.insert(pg)
//treeTest.copy
treeTest.insert(pt)
treeTest.insert(p9)
//treeTest.printTree

print(treeTest.keyExists(9))
print(treeTest.valueExists("test9"))
//var treeCopy := treeTest.copy
//treeCopy.printTree
//print(treeCopy.count)
//treeTest.printTree
//binaryTree.copy(emptyNode)
//print ("")
//var pr := p.page(9, "repeat")
//treeTest.insert(pr)
//treeTest.printTree
//nodeTest.insert(p)
//nodeTest.tempPrint
