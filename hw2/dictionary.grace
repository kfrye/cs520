class dictionary.new -> Dictionary {
    var book := binaryTree
    
    method size -> Number { }
    method isEmpty -> Boolean { }
    method containsKey(k:K) -> Boolean{ }
    method containsValue(v:T) -> Boolean{ }
    method at(key:K)ifAbsent(action:Block0<Unknown>) -> Unknown{ }
    method at(key:K)put(value:T) -> Dictionary<K,T>{ }
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
    method copy -> Dictionary<K,T>{ }
}
