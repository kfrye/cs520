require './ExtHashTrait'
class UnicodeMap
  attr_reader :codepoints, :names

  #Create our two hashes
  def initialize(table)
    @codepoints = Hash.new().extend(ExtHashTrait)
    @names      = Hash.new().extend(ExtHashTrait)

    table.each do |item|
      @names[item.name] = item
      @codepoints[item.codepoint] = item
    end
  end



  def name(toFind)
    if @codepoints.contains_key(toFind)
      @codepoints.getAkey(toFind).name
    else
      nil
    end
  end

  def character(toFind)
    if @names.contains_key(toFind)
      @names.getAkey(toFind).codepoint
    else
      nil
    end
  end

  def majorCategory(toFind)
    begin
      @codepoints.getAkey(toFind).majorCategory
    rescue
      nil
    end
  end

  def category(toFind)
    if @codepoints.contains_key(toFind)
      @codepoints.getAkey(toFind).category
    else
      nil
    end
  end

  def objByCodepoint(toFind)
    @codepoints.getAkey(toFind)
  end

  def objByName(toFind)
    @names.getAkey(toFind)
  end
end
