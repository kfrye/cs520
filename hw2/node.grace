type Node = {
  update(val) -> Done
  value -> Unknown
  key -> Unknown
  left -> Node
  setLeft(node:Node) -> Done
  right -> Node
  setRight(node:Node) -> Done
  next -> Node
  setNext(node:Node) -> Done
  empty -> Boolean
  asString -> String
  leaf -> Boolean
  emptyLeft -> Boolean
  emptyRight -> Boolean
  hash -> Number
}

factory method bookNode<K,T> -> Binding<K,T> {
  method new(newVal:Binding<K,T>) {
    object {
      inherits binding.key(newVal.key)value(newVal.value)
      var left':Node := emptyNode
      var right':Node := emptyNode
      var next':Node := emptyNode
      var key':K := newVal.key
      var value':T := newVal.value
      
      method < (other) { self.key < other.key }
      method > (other) { self.key > other.key }
      method isEqual(other) { self.key == other.key }
      method update (val) { 
        key' := val.key
        value' := val.value
      }
      method value { value' }
      method key { key' }
      method left { left' }
      method setLeft(node:Node) { left' := node }
      method right { right' }
      method setRight(node:Node) { right' := node }
      method next { next' }
      method setNext(node:Node) { next' := node }
      method empty { false }
      method asString { "{key}::{value}, " }
      method leaf { return (left.empty && right.empty)}
      method emptyLeft { return (left.empty) }
      method emptyRight { return (right.empty) }
      method hash { (key.hash * 1021) + value.hash }
    }
  }
}

class emptyNode -> Node {
  method empty { true }
  method left { emptyNode }
  method right { emptyNode }
  method asString { "An empty node" }
  method next { Exception.raise "There is no next node" }
  method binding { NoSuchObject.raise }
  method update (val) { NoSuchObject.raise }
  method value { NoSuchObject.raise }
  method key { NoSuchObject.raise }
  method setLeft(node:Node) { NoSuchObject.raise }
  method setRight(node:Node) { NoSuchObject.raise }
  method setNext(node:Node) { NoSuchObject.raise }
  method leaf { NoSuchObject.raise }
  method emptyLeft { true }
  method emptyRight { true }
  method hash { NoSuchObject.raise }
  method new(newVal) { bookNode.new(newVal) }
}