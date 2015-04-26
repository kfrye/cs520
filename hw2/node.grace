type Node = {
  binding -> Binding
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

class bookNode.new(newVal) -> Node {
  var left' := emptyNode
  var right' := emptyNode
  var next' := emptyNode
  var key' := newVal.key
  var value' := newVal.value
  method binding { key::value }
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
}