import "node" as n

factory method binaryTree {
  var root:n.Node := n.emptyNode
  var count' := 0
  
  method new {
    object {
      
      method iterator { 
        bindings
      }
      
      method bindings {
        object {
          inherits iterable.trait
          
          var currentNode := smallestNode(root)
          var currentPos := 0
          var prevNode
          var triggerPrev
          
          setNextInTree
          self
          
          method hasNext { 
            if(currentPos < count') then { true }
            else { false }
          }
          
          method havemore { hasNext }
          
          method next { 
            if (currentPos >= count') then { 
              Exhausted.raise "over {count'}"
            }
            if(currentPos != 0) then { currentNode := currentNode.next }
            currentPos := currentPos + 1
            return currentNode
          }
            
          method setNextInTree is confidential {
            prevNode := smallestNode(root)
            triggerPrev := false
            setNextInTreeRecurse(root)
          }
          
          method setNextInTreeRecurse(node:n.Node) is confidential {
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
        }
      }
      
      method smallestNode (node:n.Node) -> n.Node is confidential {
        if (node.emptyLeft) then { return node }
        return (smallestNode(node.left))
      }
      
      method isEqual(other) {
        var otherList := other.iterator
        while{otherList.hasNext} do {
          if(!pageExists(otherList.next.binding)) then { 
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
        if(node.empty) then { false }
        elseif(obj == node.binding) then { true }
        elseif(obj.key < node.key) then { pageExistsRecurse(node.left, obj) }
        else { pageExistsRecurse(node.right, obj) }
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
      
      method removeKey (obj:Object) {
        if (!root.empty) then {
          root := removeKeyRecurse(root, obj)
          count' := count' - 1
        } else { NoSuchObject.raise }
      }

      method removeKeyRecurse (node:n.Node, obj:Object) is confidential {
        if (node.empty) then { NoSuchObject.raise } 
        if(obj == node.key) then {
          if (node.leaf) then { return n.emptyNode }
          if (node.emptyLeft) then { return node.right }
          if (node.emptyRight ) then { return node.left }
          var tempNode := smallestNode(node.right)
          node.update(tempNode.binding)
          node.setRight(removeKeyRecurse (node.right, tempNode.key))
          return node

        }
        elseif(obj < node.key) then { 
          node.setLeft(removeKeyRecurse(node.left, obj)) 
          return node
        }
        else { 
          node.setRight(removeKeyRecurse(node.right, obj)) 
          return node
        }
      }
      
      method removeValue (obj:Object) {
        while { valueExists(obj) } do {
          findValueAndRemoveKey(root, obj)
        }
      }
      
      method findValueAndRemoveKey (node, value:Object) is confidential {
        if (node.empty) then {
          return
        }
        if (node.value == value) then {
          removeKey(node.key)
          return
        }
        
        findValueAndRemoveKey(node.left, value)
        findValueAndRemoveKey(node.right, value)
      }
      method size { count' }
    }
  }
}
