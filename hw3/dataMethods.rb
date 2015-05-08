class DataSystem
  attr_reader :codepoints, :names

  def initialize(characters)
    @codepoints = Hash.new();
    @names = Hash.new();
    characters.each do |item|
      names[item[1]] = item
      codepoints[item[0]] = item
    end
  end

  def name(toFind)
    data = codepoints[toFind]
    if data != nil
      data.name
    else  
      nil 
    end
  end

  def character(toFind)
    data = names[toFind]
    if data != nil
      data.codepoint
    else
      nil 
    end
  end

  def majorCategory(toFind)
    data = codepoints[toFind]
    if data != nil
      data.category[0,1]
    else
      nil
    end
  end

  def category(toFind)
    data = codepoints[toFind]
    if data != nil
      data.category
    else  
      nil
    end
  end
end
