type Node = {
  update(val) -> Done
  new(val:Binding) -> Node
  left -> Node
  setLeft(node:Node) -> Done
  right -> Node
  setRight(node:Node) -> Done
  empty -> Boolean
  asString -> String
  leaf -> Boolean
  emptyLeft -> Boolean
  emptyRight -> Boolean
  createEmptyNode -> Node
} 