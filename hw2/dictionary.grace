import "binaryTree" as bt
import "node" as n
 
factory method dictionary<K,T> -> Dictionary<K,T> {
  inherits collectionFactory.trait<T>
   
  method at(k:K)put(v:T) -> Dictionary<K,T> {
    self.empty.at(k)put(v)
  }
  
  method withAll(initialBindings:Collection<Binding<K,T>>) -> Dictionary<K,T> {
    object {
      inherits bt.binaryTree(n.emptyNode)
       
      for (initialBindings) do { b -> at(b.key)put(b.value) }
      
      method at(key:K)put(value:T) -> Dictionary<K,T>{ 
        insert(n.bookNode.new(key::value))
        self
      }
      
      method size -> Number { super.size }
      method isEmpty -> Boolean { (size <= 0) }
      method containsKey(k:K) -> Boolean{ nodeExists(n.bookNode.new(k::"empty")) }
      method containsValue(v:T) -> Boolean{ valueExists(v) }
      method at(key:K)ifAbsent(action:Block0<Unknown>) -> Unknown {
        if(containsKey(key)) then { at(key) }
        else { action.apply }
      }
      method []:=(k:K, v:T) -> Done { 
        at(k)put(v) 
        done
      }
      method at(k:K) -> T { 
        def node = retrieveNode(n.bookNode.new(k::"empty")) 
        node.value
      }
      method [](k:K) -> T { at(k) }
      
      method isEqual(other:dictionary<K,T>) -> Boolean {
        var otherList := other.bindings
        while{otherList.hasNext} do {
          def nextNode = otherList.next
          def foundNode = retrieveNode(nextNode)
          if(foundNode.notEqual(nextNode)) then { return false }
        }
        true
      }
  
      method valueExists(obj:T) -> Boolean {
        def valList = values
        while{valList.hasNext} do {
          if(valList.next == obj) then { return true }
        }
        false
      }
      
      method removeAllKeys(keys:Collection<K>) -> Dictionary<K,T>{ 
        for(keys) do { k ->
          delete(n.bookNode.new(k::"empty"))
        }
        return self
      
      }
      method removeKey(*keys:K) -> Dictionary<K,T>{ removeAllKeys(keys) }
      method removeAllValues(removals:Collection<T>) -> Dictionary<K,T>{
        for (removals) do { v->
          while { valueExists(v) } do {
            findValueAndRemoveKey(root, v)
          }
        }
        return self
      }
     
      method findValueAndRemoveKey (node:n.Node, value:T) -> Done is confidential {
        if (node.empty) then {
          return
        }
        if (node.value == value) then {
          delete(n.bookNode.new(node.key::"empty"))
          return
        }
        
        findValueAndRemoveKey(node.left, value)
        findValueAndRemoveKey(node.right, value)
      }
      
      method removeValue(*removals:T) -> Dictionary<K,T>{ removeAllValues(removals) }
      
      method keys -> Iterator<K>{
        object {
          inherits iterable.trait
          def pageList = bindings
          method havemore { pageList.havemore }
          method hasNext { pageList.havemore }
          method next { pageList.next.key }
        }
      }
      method values -> Iterator<T>{ 
        object {
          inherits iterable.trait
          def pageList = bindings
          method havemore { pageList.havemore }
          method hasNext { pageList.havemore }
          method next { pageList.next.value }
        }
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
            if(currentPos < size) then { true }
            else { false }
          }
          
          method havemore { hasNext }
          
          method next { 
            if (currentPos >= size) then { 
              Exhausted.raise "over {size}"
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
          
          method setNextInTreeRecurse(node) is confidential {
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
      
      method iterator { values }
  
      method keysAndValuesDo(action:Block2<K,T,Done>) -> Done {
        def all = bindings
        while{all.hasNext} do {
          var node := all.next
          action.apply(node.key, node.value)
        }
      }
      
      method keysDo(action:Block1<K,Done>) -> Done {
        def all = bindings
        while{all.hasNext} do {
          var node := all.next
          action.apply(node.key)
        }
      }
      
      method valuesDo(action:Block1<T,Done>) -> Done {
        def all = bindings
        while{all.hasNext} do {
          var node := all.next
          action.apply(node.value)
        }
      }

      method do(action:Block1<T,Done>) -> Done{ valuesDo(action) }
      
      method ==(other:Object) -> Boolean{ 
        match (other)
          case {o:Dictionary ->
             if (self.size != o.size) then {return false}
             return isEqual(o)
          } 
          case {_ ->
             return false
          }
      }

      // Stolen from collectionsPrelude
      method copy -> Dictionary<K,T>{ 
        def newDict = dictionary.empty
        keysAndValuesDo{ k, v ->
          newDict.at(k)put(v)
        }
        newDict
      }

      method asString -> String {
        def returnString = super.asString
        "dict⟬"++ (returnString).substringFrom(1) to (returnString.size - 2) ++ "⟭"
      }
      
      method asDictionary -> Dictionary<K,T> { self }
    }
  }
}