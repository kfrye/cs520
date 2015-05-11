module ExtHashTrait
  def getAkey(key)
    if key.is_a?(String)
      self.[](key.to_sym)
    else
      self.[](key)
    end
  end
  def contains_key(key)
    if key.is_a?(String)
      self.has_key?(key.to_sym)
    else
      self.has_key?(key)
    end
  end
end
