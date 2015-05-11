require 'active_support/core_ext/hash/indifferent_access'
module ExtHash
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
class UnicodeMap
  attr_reader :codepoints, :names

  #Create our two hashes
  def initialize(table)
    # @codepoints = HashWithIndifferentAccess.new()
    # @names = HashWithIndifferentAccess.new()
    # @codepoints = ExtHash.new()
    # @names      = ExtHash.new()
    @codepoints = Hash.new().extend(ExtHash)
    @names      = Hash.new().extend(ExtHash)

    table.table.each do |item|
      @names[item.name] = item
      @codepoints[item.codepoint] = item
    end
  end

  def name(toFind)
    # toFind = toFind.to_sym if toFind
    if @codepoints.contains_key(toFind)
      @codepoints.getAkey(toFind).name
      #  @codepoints[toFind].name
    else
      nil
    end
  end

  def character(toFind)
    # toFind = toFind.to_sym if toFind
    if @names.contains_key(toFind)
      @names.getAkey(toFind).codepoint
    else
      nil
    end
  end

  def majorCategory(toFind)
    #toFind = toFind.to_sym if toFind
    begin
      @codepoints.getAkey(toFind).majorCategory
    rescue
      nil
    end
    # if @codepoints.has_key?(toFind)
    #   @codepoints[toFind].majorCategory
    # else
    #   nil
    # end
  end

  def category(toFind)
    # toFind = toFind.to_sym if toFind
    if @codepoints.contains_key(toFind)
      @codepoints.getAkey(toFind).category
    else
      nil
    end
  end

  def objByCodepoint(toFind)
    # toFind = toFind.to_sym if toFind
    @codepoints.getAkey(toFind)
  end

  def objByName(toFind)
    # toFind = toFind.to_sym if toFind
    @names.getAkey(toFind)
  end
end
