type Page = {
  empty -> Boolean
  notEmpty -> Boolean
  key -> Done 
  value -> Done
  == (other:page) -> Boolean 
  != (other:page) -> Boolean 
  >= (other:page) -> Boolean
  >  (other:page) -> Boolean 
  <  (other:Object) -> Boolean 
  <= (other:Object) -> Boolean 
}

class page (key', value') -> Page {
  method empty -> Boolean { false }
  method notEmpty -> Boolean { !empty }
  method key { key' }
  method value { value' }
  method copy -> Page { page(key, value) }
  method asString { "key: {key}, value: {value}" }
  method == (other:page) -> Boolean { (other.key == self.key) }
  method != (other:page) -> Boolean { (other.key != self.key) }
  method >= (other:page) -> Boolean { (other.key >= self.key) }
  method >  (other:page) -> Boolean { (other.key > self.key) }
  method <  (other:Object) -> Boolean { (other.key < self.key) }
  method <= (other:Object) -> Boolean { (other.key <= self.key) }
}

class emptyPage -> Page {
  method empty -> Boolean { true }
  method notEmpty -> Boolean { false }
  method key -> Done {EnvironmentException.raise "The Page is empty"}
  method value -> Done {EnvironmentException.raise "The Page is empty"}
  method == (other:page) -> Boolean {EnvironmentException.raise "The Page is empty"}
  method != (other:page) -> Boolean {EnvironmentException.raise "The Page is empty"}
  method >= (other:page) -> Boolean {EnvironmentException.raise "The Page is empty"}
  method >  (other:page) -> Boolean {EnvironmentException.raise "The Page is empty"}
  method <  (other:Object) -> Boolean {EnvironmentException.raise "The Page is empty"}
  method <= (other:Object) -> Boolean {EnvironmentException.raise "The Page is empty"}
}