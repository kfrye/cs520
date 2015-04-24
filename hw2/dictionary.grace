import "binaryTree" as bt
import "page" as p

factory method dictionary<K,T> {
  inherits collectionFactory.trait<T>
  
  var book := bt.binaryTree.new
  var count' := 0
  
  method withAll(initialBindings:Collection<Binding<K,T>>) -> Dictionary<K,T> {
    object {
      inherits enumerable.trait
      
      for (initialBindings) do { b -> at(b.key)put(b.value) }
      
      method at(key:K)put(value:T) -> Dictionary<K,T>{ 
        count' := book.insert(p.page(key,value))
        self
      }
      
      method count { count' }
      
      method size -> Number { count }
      
      method isEmpty -> Boolean { }
      method containsKey(k:K) -> Boolean{ }
      method containsValue(v:T) -> Boolean{ }
      method at(key:K)ifAbsent(action:Block0<Unknown>) -> Unknown{ }
  
      method []:=(k:K, v:T) -> Done{ }
      method at(k:K) -> T{ }
      method [](k:K) -> T{ }
      method removeAllKeys(keys:Collection<K>) -> Dictionary<K,T>{ }
      method removeKey(*keys:K) -> Dictionary<K,T>{ }
      method removeAllValues(removals:Collection<T>) -> Dictionary<K,T>{ }
      method removeValue(*removals:T) -> Dictionary<K,T>{ }
      method keys -> Iterator<K>{ }
      method values -> Iterator<T>{ }
      method bindings -> Iterator<Binding<K,T>>{ }
      method keysAndValuesDo(action:Block2<K,T,Done>) -> Done{ }
      method keysDo(action:Block1<K,Done>) -> Done{ }
      method valuesDo(action:Block1<T,Done>) -> Done{ }
      method do(action:Block1<T,Done>) -> Done{ }
      method ==(other:Object) -> Boolean{ }
      method copy -> Dictionary<K,T>{ print("this works") }
    }
  }
}

def oneToFive = dictionary.with("one"::1, "two"::2, "three"::3, 
    "four"::4, "five"::5)
//def evens = dictionary.with("two"::2, "four"::4, "six"::6, "eight"::8)
//def empty = dictionary.empty
print(oneToFive.count)
oneToFive.copy
//print(evens.count)
//print(empty.count)