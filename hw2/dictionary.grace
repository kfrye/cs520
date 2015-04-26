import "binaryTree" as bt
import "page" as p

factory method dictionary<K,T> {
  inherits collectionFactory.trait<T>
  
  var book' := bt.binaryTree.new
  var count' := 0
  method at(k:K)put(v:T) {
            self.empty.at(k)put(v)
  }
  
  method withAll(initialBindings:Collection<Binding<K,T>>) -> Dictionary<K,T> {
    object {
      inherits enumerable.trait
      
      for (initialBindings) do { b -> at(b.key)put(b.value) }
      
      method book { book' }
      method at(key:K)put(value:T) -> Dictionary<K,T>{ 
        count' := book.insert(p.page(key,value))
        self
      }
      
      method count { count' }
      
      method size -> Number { book.size }
      
      method isEmpty -> Boolean { }
      method containsKey(k:K) -> Boolean{ book.keyExists(k) }
      method containsValue(v:T) -> Boolean{ book.valueExists(v) }
      
      method at(key:K)ifAbsent(action:Block0<Unknown>) -> Unknown {
        if(containsKey(key)) then { at(key) }
        else { action.apply }
      }
      method []:=(k:K, v:T) -> Done { 
        at(k)put(v) 
        done
      }
      method at(k:K) -> T { book.get(k) }
      method [](k:K) -> T{ book.get(k) }
      method removeAllKeys(keys:Collection<K>) -> Dictionary<K,T>{ 
        for(keys) do { k ->
          book.removeKey(k)
        }
        return self
      
      }
      method removeKey(*keys:K) -> Dictionary<K,T>{ removeAllKeys(keys) }
      method removeAllValues(removals:Collection<T>) -> Dictionary<K,T>{
        for (removals) do { v->
          //print ("removing {v}")
          book.removeValue(v)
        }
        return self
      }
      method removeValue(*removals:T) -> Dictionary<K,T>{ removeAllValues(removals) }
      method keys -> Iterator<K>{
        object {
          inherits iterable.trait
          def pageList = book.iterator
          method havemore { pageList.havemore }
          method hasNext { pageList.havemore }
          method next { pageList.next.key }
        }
      }
      method values -> Iterator<T>{ 
        object {
          inherits iterable.trait
          def pageList = book.iterator
          method havemore { pageList.havemore }
          method hasNext { pageList.havemore }
          method next { pageList.next.value }
        }
      }
      method bindings -> Iterator<Binding<K,T>>{ book.iterator }
      method keysAndValuesDo(action:Block2<K,T,Done>) -> Done{ book.keysAndValuesDo(action) }
      method keysDo(action:Block1<K,Done>) -> Done{ book.keysDo(action) }
      method valuesDo(action:Block1<T,Done>) -> Done{ book.valuesDo(action) }
      method do(action:Block1<T,Done>) -> Done{ valuesDo(action) }
      method ==(other:Object) -> Boolean{ book.isEqual(other.book) }
      method copy -> Dictionary<K,T>{ print("this works") }
      method asString {
        def returnString = book.asString
        "dict⟬"++ (returnString).substringFrom(1) to (returnString.size - 2) ++ "⟭"
        
      }
    }
  }
}

def oneToFive = dictionary.with("one"::1, "two"::2, "three"::3, 
    "four"::4, "five"::5)
//def evens = dictionary.with("two"::2, "four"::4, "six"::6, "eight"::8)
//def empty = dictionary.empty
//print(oneToFive.count)
//print(oneToFive.containsKey("one"))
//print(oneToFive.containsValue(1))
//print(oneToFive.at("four"))
//def l = oneToFive.values
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
//print(oneToFive.keys.next)
<<<<<<< HEAD
//oneToFive.copy
//print(evens.count)
//print(empty.count)
=======
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
>>>>>>> 500d5e71760de6894a7bca8d089048fb2457056d
