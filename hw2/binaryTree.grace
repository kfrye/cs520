import "nodeInterface" as n // binaryTree only knows about the node interface

factory method binaryTree(initialNode:n.Node) {
  inherits enumerable.trait
  
  var root:n.Node := initialNode
  var size':Number := 0
  if(!root.empty) then { countNodes(root) }

  method countNodes(node:n.Node) -> Done is confidential {
    if(node.empty) then { return }
    countNodes(node.left)
    size' := size' + 1
    countNodes(node.right)
  }
  
  method smallestNode (node:n.Node) -> n.Node is confidential {
    if (node.emptyLeft) then { return node }
    return (smallestNode(node.left))
  }
  
  method isEqual(other) -> Boolean {
    abstract
  }
  
  method insert(node:n.Node) -> Number {
    root := insertRecurse(root, node)
    size' := size' + 1
    return size'
  }

  method insertRecurse(node:n.Node, newNode:n.Node) -> n.Node is confidential {
    if(node.empty) then {
      return node.new(newNode)
    }
    var tempNode
    if(newNode < node) then {
      tempNode := insertRecurse(node.left, newNode)
      node.setLeft(tempNode)
    }
    elseif(newNode > node) then {
      tempNode := insertRecurse(node.right, newNode)
      node.setRight(tempNode)
    }
    else {
      node.update(newNode)
      size' := size' - 1
    }
    return node
  }
  
  method nodeExists(node:n.Node) -> Boolean {
    def existingNode = retrieveNode(node)
    !existingNode.empty
  }

  method retrieveNode(node:n.Node) -> n.Node {
    retrieveNodeRecurse(root, node)
  }
  
  method retrieveNodeRecurse(node:n.Node, nodeToFind:n.Node) -> n.Node is confidential {
    if(node.empty) then { node }
    elseif(node.isEqual(nodeToFind)) then { node }
    elseif(nodeToFind < node) then { retrieveNodeRecurse(node.left, nodeToFind) }
    else { retrieveNodeRecurse(node.right, nodeToFind) }
  }
  
  method asString -> String {
    asStringRecurse(root)
  }
  
  method asStringRecurse(node:n.Node) -> String is confidential {
    if (node.empty) then { return "" }
    return (asStringRecurse(node.left) ++ node.asString ++ asStringRecurse(node.right))
  }
  
  method delete (node:n.Node) {
    if (!root.empty) then {
      root := deleteRecurse(root, node)
      size' := size' - 1
    } else { NoSuchObject.raise }
  }

  method deleteRecurse (node:n.Node, nodeToDelete:n.Node) -> n.Node is confidential {
    if (node.empty) then { NoSuchObject.raise } 
    if(nodeToDelete.isEqual(node)) then {
      if (node.leaf) then { return node.createEmptyNode }
      if (node.emptyLeft) then { return node.right }
      if (node.emptyRight ) then { return node.left }
      var tempNode := smallestNode(node.right)
      node.update(tempNode)
      node.setRight(deleteRecurse (node.right, tempNode))
      return node

    }
    elseif(nodeToDelete < node) then { 
      node.setLeft(deleteRecurse(node.left, nodeToDelete)) 
      return node
    }
    else { 
      node.setRight(deleteRecurse(node.right, nodeToDelete)) 
      return node
    }
  }
  
  method size -> Number { size' }
}