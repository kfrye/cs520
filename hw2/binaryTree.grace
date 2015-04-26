import "page" as p

type Book = {
  insert(obj) -> Number
  delete(obj) -> Done
  get(obj) -> Unknown
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
      inherits iterable.trait
      
      var currentNode' := root
      var currentPos' := 0
      var prevNode
      var triggerPrev
      
      method iterator {
        setNextInTree
        resetCurrent
        self
      }
      
      method current { currentNode' }
      method currentPos { currentPos' }
      method resetCurrent {
        currentPos' := 0
        currentNode' := getFirstNode(root)
      }
      
      method getFirstNode(node:Node) -> Node {
        if(node.left.empty) then { node }
        else { getFirstNode(node.left) }
      }
      
      method getLastNode(node:Node) -> Node {
        if(node.right.empty) then { node }
        else { getLastNode(node.right) }
      }
      
      method setNextInTree {
        prevNode := getFirstNode(root)
        triggerPrev := false
        setNextInTreeRecurse(root)
      }
      
      method setNextInTreeRecurse(node:Node) {
        if(node.empty) then { return }
        setNextInTreeRecurse(node.left)
        if(node == prevNode) then {
          triggerPrev := true
        }
        elseif(triggerPrev == true) then {
          prevNode.setNext(node)
          prevNode := node
        }
        setNextInTreeRecurse(node.right)
      }
      
      method isEqual(other:Book) {
        var otherList := other.iterator
        
        while{otherList.hasNext} do {
          if(!pageExists(otherList.next.page)) then { 
            return false 
          }
        }
        true
      }
      
      method keysAndValuesDo(action) {
        def all = iterator
        while{all.hasNext} do {
          var node := all.next
          action.apply(node.key, node.value)
        }
      }
      
      method keysDo(action) {
        def all = iterator
        while{all.hasNext} do {
          var node := all.next
          action.apply(node.key)
        }
      }
      
      method valuesDo(action) {
        def all = iterator
        while{all.hasNext} do {
          var node := all.next
          action.apply(node.value)
        }
      }
      
      method traverseList(node:Node) {
        if(node.empty) then { return }
        traverseList(node.left)
        
        print(node.key)
        traverseList(node.right)
      }
      
      method hasNext { 
        if(currentPos' < count) then { true }
        else { false }
      }
      
      method havemore { hasNext }
      
      method next { 
        if(currentPos' != 0) then { currentNode' := currentNode'.next }
        currentPos' := currentPos' + 1
        return currentNode'
      }
      
      method getRoot { root } // used for debugging only. Erase when done
      
      method listAll {
        var pageList := list.empty
        listNode(root, pageList)
      }
      
      method listNode(node:Node, pageList) {
        if(node.empty) then { return pageList }
        listNode(node.left, pageList)
        pageList.add(node.page)
        listNode(node.right, pageList)
        return pageList
      }
      
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
    
      method get(obj) -> Unknown {
        getNode(root, obj)
      }
      
      method getNode(node:Node, obj) -> Unknown {
        if(node.empty) then { Exception.raise "{obj} not found" }
        elseif(obj == node.key) then { node.value }
        elseif(obj < node.key) then { getNode(node.left, obj) }
        else { getNode(node.right, obj) }
      }
      
      method pageExists(obj:p.Page) -> Boolean {
        pageExistsRecurse(root, obj)
      }
      
      method pageExistsRecurse(node:Node, obj:p.Page) {
        if(node.empty) then { false }
        elseif(obj == node.page) then { true }
        elseif(obj.key < node.key) then { pageExistsRecurse(node.left, obj) }
        else { pageExistsRecurse(node.right, obj) }
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
        def all = iterator
        def bookCopy = binaryTree.new
        while{all.hasNext} do { bookCopy.insert(all.next.page.copy) }
        bookCopy
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
  copyValue -> p.Page
}

class bookNode.new(newVal:p.Page) -> Node {
  var left' := emptyNode
  var right' := emptyNode
  var page' := newVal
  var next' := emptyNode
  
  method page { page' }
  method value { page.value }
  method key { page.key }
  method left { left' }
  method setLeft(node:Node) { left' := node }
  method right { right' }
  method setRight(node:Node) { right' := node }
  method next { next' }
  method setNext(node:Node) { 
    next' := node 
  }
  method empty { page.empty }
  method update (val:p.Page) { page' := val }
  method asString { "booknode with page: {value}"}
  method copyValue { page.copy }
}

class emptyNode -> Node {
  method empty { true }
  method left { emptyNode }
  method right { emptyNode }
  method asString { "An empty node" }
  method copyValue { p.emptyPage }
  method next { Exception.raise "There is no next node" }
  method page { p.emptyPage }
}

//test script
//var p10:= p.page(10, "test10")
//var p9:= p.page(9, "test9")
//var p11:= p.page(11, "test11")
//var p8:= p.page(8, "test8")
//var p12 := p.page(12, "test12")
//var treeTest := binaryTree.new
//treeTest.insert(p10)
//treeTest.insert(p8)
//treeTest.insert(p11)
//treeTest.insert(p9)
//treeTest.printTree
//var treeCopy := binaryTree.new
//treeCopy.insert(p10.copy)
//treeCopy.insert(p9.copy)
//treeCopy.insert(p11.copy)
//treeCopy.printTree

//print(treeCopy.isEqual(treeTest))
//treeTest.insert(p12)
//treeTest.setNextInTree

//def fNode = treeTest.getFirstNode(treeTest.getRoot)
//print(fNode.next)
//treeTest.getFirstNode
//print(treeTest.getLastNode(treeTest.getRoot))
//treeTest.traverseList(treeTest.getRoot)
//treeTest.resetCurrent
//var l := treeTest.iterator
//print(l.next)
//print(l.next)
//print(l.next)
//print(l.next)
//print(l.next)
//print(l.next)
//print(l.current)
//print(treeTest.current)
//print("Current pos: {treeTest.currentPos}")
//print(treeTest.hasNext)
//print(treeTest.next)
//print("Current pos: {treeTest.currentPos}")
//print(treeTest.hasNext)
//print(treeTest.next)
//print("Current pos: {treeTest.currentPos}")
//print(treeTest.hasNext)
//print(treeTest.getRoot)
//print(treeTest.getRoot.left.next)
//treeTest.printTree

//print(treeTest.keyExists(9))
//print(treeTest.valueExists("test9"))
//print(treeTest.get(11))
//print(treeTest.listAll)
//def witness = list<Number>.with(1, 2, 3, 4, 5, 6)
//print(witness)
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
