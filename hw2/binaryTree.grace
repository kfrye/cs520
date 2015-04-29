import "node" as n

factory method binaryTree(initialNode:n.Node) {
  inherits enumerable.trait
  
  var root:n.Node := initialNode
  var size' := 0
  if(!root.empty) then { countNodes(root) }

  method countNodes(node:n.Node) -> Done {
    if(node.empty) then { return }
    countNodes(node.left)
    size' := size' + 1
    countNodes(node.right)
  }
  
  method smallestNode (node:n.Node) -> n.Node is confidential {
    if (node.emptyLeft) then { return node }
    return (smallestNode(node.left))
  }
  
  method isEqual(other) {
    var otherList := other.bindings
    while{otherList.hasNext} do {
      def tempNode = 
      if(!nodeExists(otherList.next)) then { 
        return false 
      }
    }
    true
  }
  
  method insert(obj:Object) -> Number {
    root := insertRecurse(root, obj)
    size' := size' + 1
    return size'
  }

  method insertRecurse(node:n.Node, obj:Object) -> n.Node is confidential {
    if(node.empty) then {
      return node.new(obj)
    }
    var tempNode
    if(obj < node) then {
      tempNode := insertRecurse(node.left, obj)
      node.setLeft(tempNode)
    }
    elseif(obj > node) then {
      tempNode := insertRecurse(node.right, obj)
      node.setRight(tempNode)
    }
    else {
      node.update(obj)
      size' := size' - 1
    }
    return node
  }
  
  method nodeExists(obj) -> Boolean {
    def node = retrieveNode(obj)
    !node.empty
  }

  method retrieveNode(obj) -> n.Node {
    retrieveNodeRecurse(root, obj)
  }
  
  method retrieveNodeRecurse(node:n.Node, obj) -> n.Node is confidential {
    if(node.empty) then { node }
    elseif(node.isEqual(obj)) then { node }
    elseif(obj < node) then { retrieveNodeRecurse(node.left, obj) }
    else { retrieveNodeRecurse(node.right, obj) }
  }
  
  method asString {
    asStringRecurse(root)
  }
  
  method asStringRecurse(node:n.Node) is confidential {
    if (node.empty) then { return "" }
    return (asStringRecurse(node.left) ++ node.asString ++ asStringRecurse(node.right))
  }
  
  method delete (obj:Object) {
    if (!root.empty) then {
      root := deleteRecurse(root, obj)
      size' := size' - 1
    } else { NoSuchObject.raise }
  }

  method deleteRecurse (node:n.Node, obj:Object) is confidential {
    if (node.empty) then { NoSuchObject.raise } 
    if(obj == node.key) then {
      if (node.leaf) then { return n.emptyNode }
      if (node.emptyLeft) then { return node.right }
      if (node.emptyRight ) then { return node.left }
      var tempNode := smallestNode(node.right)
      node.update(tempNode)
      node.setRight(deleteRecurse (node.right, tempNode.key))
      return node

    }
    elseif(obj < node.key) then { 
      node.setLeft(deleteRecurse(node.left, obj)) 
      return node
    }
    else { 
      node.setRight(deleteRecurse(node.right, obj)) 
      return node
    }
  }
  
  method size { size' }
}

//def p1 = n.bookNode.new(1::"one")
//def p2 = n.bookNode.new(2::"two")
//def p3 = n.bookNode.new(3::"three")
//def p4 = n.bookNode.new(4::"four")
//def p5 = n.bookNode.new(5::"five")
//def p12 = n.bookNode.new(1::"repeat")
//def list = binaryTree(p1)
//list.insert(p2)
//list.insert(p3)
//list.insert(p4)
//list.insert(p5)
//list.insert(p12)
//print(list)
//print(list.size)
//print(list.nodeExists(n.bookNode.new(5::"no")))
//print(list.countNodes)