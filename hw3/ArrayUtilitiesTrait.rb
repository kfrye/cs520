module ArrayUtilitiesTrait
  def resetEmpty(arr)
    arr.map! {|x| x == "" ? nil : x}
  end

  def arrayToSym(arr)
    arr.map! {|x| x == nil ? nil : x.to_sym}
  end
end
