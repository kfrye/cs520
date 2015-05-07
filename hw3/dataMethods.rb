class Character
  attr_reader :name, :codepoint, :category

  def initialize(name, codepoint, category)
    #Each character has these things
    @name = name;
    @codepoint = codepoint
    @category = category
  end

  def to_s
    puts @name + '     ' + @codepoint + '     ' + @category + "\n"
  end
end

class DataSystem
  attr_reader :codepoints, :names

  def initialize(characters)
    @codepoints = Hash.new();
    @names = Hash.new();
    characters.each do |item|
      names[item.name] = item
      codepoints[item.codepoint] = item
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
