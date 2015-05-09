class Character
  attr_reader :name, :category, :codepoint, :majorCategory
  def initialize(row)
    codeValue = 0
    characterName = 1
    generalCategory = 2
    majorCategory = 3
   
    #puts row[3] 
    @name = row[characterName]
    @category = row[generalCategory]
    @codepoint = row[codeValue]
    @majorCategory = row[majorCategory]
  end
end 

class DataSystem
  attr_reader :codepoints, :names

  def initialize(table)
    codeValue = 0
    characterName = 1
    generalCategory = 2
    majorCategory = 3

    @codepoints = Hash.new();
    @names = Hash.new();
    table.each do |item|
      puts item.size
      char = Character.new(item)
      names[item[codeValue]] = char 
      codepoints[item[characterName]] = char 
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
