class UnicodeBiMap
  attr_reader :codepoints, :names

  def initialize(table)
    @codepoints = table.hashTable
    @names = Hash.new()
    table.table.each do |item|
      @names[item.name] = item
    end
  end

  def name(toFind)
    if codepoints.has_key?(toFind)
      codepoints[toFind].name
    else
      nil
    end
  end

  def character(toFind)
    if names.has_key?(toFind)
      names[toFind].codepoint
    else
      nil
    end
  end

  def majorCategory(toFind)
    if codepoints.has_key?(toFind)
      codepoints[toFind].majorCategory
    else
      nil
    end
  end

  def category(toFind)
    if codepoints.has_key?(toFind)
      codepoints[toFind].category
    else
      nil
    end
  end

  def objByCodepoint(toFind)
    codepoints[toFind]
  end

  def objByName(toFind)
    names[toFind]
  end
end
