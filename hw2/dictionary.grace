import "binaryTree" as bt
import "page" as p

factory method dictionary<K,T> {
  inherits collectionFactory.trait<T>
  
  var book' := bt.binaryTree.new
  var count' := 0
  
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
      
      method size -> Number { count }
      
      method isEmpty -> Boolean { }
      method containsKey(k:K) -> Boolean{ book.keyExists(k) }
      method containsValue(v:T) -> Boolean{ book.valueExists(v) }
      method at(key:K)ifAbsent(action:Block0<Unknown>) -> Unknown{ }
  
      method []:=(k:K, v:T) -> Done{ }
      method at(k:K) -> T{ }
      method [](k:K) -> T{ }
      method removeAllKeys(keys:Collection<K>) -> Dictionary<K,T>{ book = bt.binaryTree.new }
      method removeKey(*keys:K) -> Dictionary<K,T>{  }
      method removeAllValues(removals:Collection<T>) -> Dictionary<K,T>{ }
      method removeValue(*removals:T) -> Dictionary<K,T>{ }
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
      method keysDo(action:Block1<K,Done>) -> Done{ }
      method valuesDo(action:Block1<T,Done>) -> Done{ }
      method do(action:Block1<T,Done>) -> Done{ }
      method ==(other:Object) -> Boolean{ book.isEqual(other.book) }
      method copy -> Dictionary<K,T>{ print("this works") }
    }
  }
}

def oneToFive = dictionary.with("one"::1, "two"::2, "three"::3, 
    "four"::4, "five"::5)
//def evens = dictionary.with("two"::2, "four"::4, "six"::6, "eight"::8)
//def empty = dictionary.empty
<<<<<<< HEAD
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
=======
print(oneToFive.count)
print(oneToFive.containsKey("one"))
print(oneToFive.containsValue(1))
>>>>>>> 69fb4b20eaf6879384d435d114e4a246c4cdf441
//oneToFive.copy
//print(evens.count)
//print(empty.count)
