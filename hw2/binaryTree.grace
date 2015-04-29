import "node" as n

class binaryTree {
  inherits enumerable.trait
  
  var root:n.Node := n.emptyNode
  var count' := 0

  method smallestNode (node:n.Node) -> n.Node is confidential {
    if (node.emptyLeft) then { return node }
    return (smallestNode(node.left))
  }
  
  method isEqual(other) {
    var otherList := other.bindings
    while{otherList.hasNext} do {
      if(!pageExists(otherList.next.binding)) then { 
        return false 
      }
    }
    true
  }
  
  
  method insert(obj:Object) -> Number {
    root := insertRecurse(root, obj)
    count' := count' + 1
    return count'
  }

  method insertRecurse(node:n.Node, obj:Object) -> n.Node is confidential {
    if(node.empty) then {
      return n.bookNode.new(obj)
    }
    var tempNode
    if(obj.key < node.key) then {
      tempNode := insertRecurse(node.left, obj)
      node.setLeft(tempNode)
    }
    elseif(obj.key > node.key) then {
      tempNode := insertRecurse(node.right, obj)
      node.setRight(tempNode)
    }
    else {
      node.update(obj)
    }
    return node
  }

  method valueOfKey(obj) -> Unknown {
    valueOfKeyRecurse(root, obj)
  }
  
  method valueOfKeyRecurse(node:n.Node, obj) -> Unknown is confidential {
    if(node.empty) then { NoSuchObject.raise "{obj} not found" }
    elseif(obj == node.key) then { node.value }
    elseif(obj < node.key) then { valueOfKeyRecurse(node.left, obj) }
    else { valueOfKeyRecurse(node.right, obj) }
  }
  
  method pageExists(obj) -> Boolean {
    pageExistsRecurse(root, obj)
  }
  
  method pageExistsRecurse(node:n.Node, obj) is confidential {
    //print("node.binding = {node.binding}")
    //print("obj = {obj}")
    if(node.empty) then { false }
    elseif(obj == node.binding) then { 
      print("found equals")
      true 
      
    }
    elseif(obj.key < node.key) then { 
      print("key is less than")
      pageExistsRecurse(node.left, obj) 
      
    }
    else { 
      print("else")
      pageExistsRecurse(node.right, obj) 
      
    }
  } 
  
  method valueExists(obj) -> Boolean {
    valueExistsRecurse(root, obj)
  }
  
  method valueExistsRecurse(node:n.Node, obj) is confidential {
    if(node.empty) then { false }
    elseif(node.value == obj) then { true }
    elseif(!valueExistsRecurse(node.left, obj)) then {
      valueExistsRecurse(node.right, obj)
    }
    else {true}
  } 

  method keyExists(obj) -> Boolean {
    keyExistsRecurse(root, obj)
  }
  
  method keyExistsRecurse(node:n.Node, obj) -> Boolean is confidential {
    if(node.empty) then { false }
    elseif(obj == node.key) then { true }
    elseif(obj < node.key) then { keyExistsRecurse(node.left, obj) }
    else { keyExistsRecurse(node.right, obj) }
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
      count' := count' - 1
    } else { NoSuchObject.raise }
  }

  method deleteRecurse (node:n.Node, obj:Object) is confidential {
    if (node.empty) then { NoSuchObject.raise } 
    if(obj == node.key) then {
      if (node.leaf) then { return n.emptyNode }
      if (node.emptyLeft) then { return node.right }
      if (node.emptyRight ) then { return node.left }
      var tempNode := smallestNode(node.right)
      node.update(tempNode.binding)
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
  
  
  method size { count' }
}
