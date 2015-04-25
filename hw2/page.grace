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
  []:=(other:page) -> Done
}

class page (key':Object, value':Object) -> Page {
  method empty -> Boolean { false }
  method notEmpty -> Boolean { !empty }
  method key { 
    return key' 
  }
  method value { value' }
  method copy -> Page { page(key, value) }
  method asString { "key: {key}, value: {value}" }
  method == (other:page) ->   Boolean { (self.key == other.key) }
  method != (other:page) ->   Boolean { (self.key != other.key) }
  method >= (other:page) ->   Boolean { (self.key >= other.key) }
  method >  (other:page) ->   Boolean { (self.key >  other.key) }
  method <  (other:Object) -> Boolean { (self.key <  other.key) }
  method <= (other:Object) -> Boolean { (self.key <= other.key) }
  method []:=(other:page) -> Done { 
    self.key := other.key
    self.value := other.value }
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
  method []:=(other:page) -> Done { EnvironmentException.raise "The Page is empty" }
}