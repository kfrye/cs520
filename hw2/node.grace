import "nodeInterface" as n

factory method bookNode<K,T> {
  method new(newVal:Binding<K,T>) -> n.Node {
    object {
      inherits binding.key(newVal.key)value(newVal.value)
      var left':n.Node := emptyNode
      var right':n.Node := emptyNode
      var next':n.Node := emptyNode
      var key':K := newVal.key
      var value':T := newVal.value
      
      method < (other:n.Node) { self.key < other.key }
      method > (other:n.Node) { self.key > other.key }
      // Can't use != here because it messes up set.onto.
      // binding does not define !=, so we need to create a method
      // for comparing keys/values for inequality
      method notEqual (other:n.Node) {
        match (other)
            case {o:Binding -> (key != o.key) || (value != o.value) }
            case {_ -> return false }
      }
      // Checks equality by key
      // == checks equality by key/pair and is inherited from binding
      method isEqual(other:n.Node) { self.key == other.key }
      method update (val:Binding<K,T>) { 
        key' := val.key
        value' := val.value
      }
      method value -> T { value' }
      method key -> K { key' }
      method left -> n.Node { left' }
      method setLeft(node:n.Node) -> Done { left' := node }
      method right -> n.Node { right' }
      method setRight(node:n.Node) -> Done { right' := node }
      method next -> n.Node { next' }
      method setNext(node:n.Node) -> Done { next' := node }
      method empty -> Boolean { false }
      method asString -> String { "{key}::{value}, " }
      method leaf -> Boolean { return (left.empty && right.empty)}
      method emptyLeft -> Boolean { return (left.empty) }
      method emptyRight -> Boolean { return (right.empty) }
      method createEmptyNode -> n.Node { emptyNode }
    }
  }
}

class emptyNode -> n.Node {
  method empty -> Boolean { true }
  method left -> n.Node { emptyNode }
  method right -> n.Node { emptyNode }
  method asString -> String { "An empty node" }
  method next { Exception.raise "There is no next node" }
  method binding { NoSuchObject.raise }
  method update (val) { NoSuchObject.raise }
  method value { NoSuchObject.raise }
  method key { NoSuchObject.raise }
  method setLeft(node:n.Node) { NoSuchObject.raise }
  method setRight(node:n.Node) { NoSuchObject.raise }
  method setNext(node:n.Node) { NoSuchObject.raise }
  method leaf { NoSuchObject.raise }
  method emptyLeft -> Boolean { true }
  method emptyRight -> Boolean { true }
  method new(newVal:Binding) -> n.Node { bookNode.new(newVal) }
  method createEmptyNode -> n.Node { self }
  method notEqual(other) -> Boolean { true }
}