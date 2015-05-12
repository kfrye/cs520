module ExtHashTrait
  def getAkey(key)
    self.[](key.to_sym)
  end

  def contains_key(key)
    self.has_key?(key.to_sym)
  end
end
