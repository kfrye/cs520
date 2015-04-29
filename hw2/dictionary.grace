import "binaryTree" as bt
import "node" as n

factory method dictionary<K,T> {
  inherits collectionFactory.trait<T>
   
  method at(k:K)put(v:T) {
    self.empty.at(k)put(v)
  }
  
  method withAll(initialBindings:Collection<Binding<K,T>>) -> Dictionary<K,T> {
    object {
      inherits bt.binaryTree(n.emptyNode)
       
      for (initialBindings) do { b -> at(b.key)put(b.value) }
      
      method at(key:K)put(value:T) -> Dictionary<K,T>{ 
        //book.insert(key::value)
        insert(n.bookNode.new(key::value))
        self
      }
      
      method size -> Number { super.size }
      
      method isEmpty -> Boolean { (size > 0) }
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
        def node = retrieveNode(n.bookNode.new(k, "empty")) 
        node.value
      }
      method [](k:K) -> T{ at(k) }
      
      method valueExists(obj) -> Boolean {
        def valList = values
        while{valList.hasNext} do {
          if(valList.next == obj) then { return true }
        }
        false
      }
      
      method removeAllKeys(keys:Collection<K>) -> Dictionary<K,T>{ 
        for(keys) do { k ->
          delete(k)
        }
        return self
      
      }
      method removeKey(*keys:K) -> Dictionary<K,T>{ removeAllKeys(keys) }
      method removeAllValues(removals:Collection<T>) -> Dictionary<K,T>{
        for (removals) do { v->
          //removeValue(v)
          while { valueExists(v) } do {
            findValueAndRemoveKey(root, v)
          }
        }
        return self
      }
     
      method findValueAndRemoveKey (node, value:Object) is confidential {
        if (node.empty) then {
          return
        }
        if (node.value == value) then {
          delete(node.key)
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
  
      method keysAndValuesDo(action) {
        def all = bindings
        while{all.hasNext} do {
          var node := all.next
          action.apply(node.key, node.value)
        }
      }
      
      method keysDo(action) {
        def all = bindings
        while{all.hasNext} do {
          var node := all.next
          action.apply(node.key)
        }
      }
      
      method valuesDo(action) {
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

      method asString {
        def returnString = super.asString
        "dict⟬"++ (returnString).substringFrom(1) to (returnString.size - 2) ++ "⟭"
      }
      
      method asDictionary { self }
    }
  }
}
//def empty = dictionary.empty
//empty.at"two"put(2)
//def copye = dictionary.empty
//copye.at"two"put(2)
//print(copye)
//print(empty)
//print(empty == copye)
//assert (evens) shouldBe (dictionary.at"two"put(2))
//empty.do {each -> print ("emptySet.do did with {each}")}

//def evens = dictionary.with("two"::2, "four"::4, "six"::6, "eight"::8)
//evens.map{x -> x + 1}.onto(set)


//def oneToFive = dictionary.with("one"::1, "two"::2, "three"::3, 
//    "four"::4, "five"::5)
//print(oneToFive == dictionary.with("one"::1, "two"::2, "three"::3,
//                "four"::4, "five"::5))
//print(oneToFive.bindingss.onto(set))
//def oneToFiveCopy = oneToFive.copy 
//def evens = dictionary.with("two"::2, "four"::4, "six"::6, "eight"::8)
//def empty = dictionary.empty
//print(oneToFive)
//print(oneToFive.containsKey("one"))
//print(oneToFive.containsValue(1))
//print(oneToFive.at("four"))
//var l := oneToFive.values

//print(l.current)
//print(l.next)
//print(l.next)
//print(l.next)
//print(l.next)
//print(l.next)
//print(l.hasNext)
//print(l.next)
//while{l.hasNext} do {
//  print(l.next)
//}
//print(oneToFive.count)
//print(oneToFive.containsKey("one"))
//print(oneToFive.containsValue(1))

//oneToFive.removeValue(1)
//print (oneToFive)
//print(oneToFive.size)
//oneToFive.copy
//print(evens.count)
//print(empty.count)
//def evens = dictionary.with("two"::2, "four"::4, "six"::6, "eight"::8)
//print (evens) 
//print (evens.containsKey("six"))
//evens.removeValue(4)
//print (evens.containsKey("six"))
//print(evens)

