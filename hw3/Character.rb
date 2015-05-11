require 'ArrayUtilitiesTrait'

# Holds the data for each unicode character
class Character
  include ArrayUtilitiesTrait
  attr_reader :codepoint, :name, :category, :majorCategory
  def initialize(entries)
    entries = resetEmpty(entries)
    entries.push(entries[2][0])
    entries = arrayToSym(entries)
    @codepoint= entries[0]
    @name= entries[1]
    @category= entries[2]
    @majorCategory= entries[-1]
    return self
  end

  def updateName(newName)
    @name = newName.to_sym
  end

  def to_s
    if (!@codepoint.nil? && !@name.nil? && !@category.nil? && !@majorCategory.nil?)
      "[" + "\""+@codepoint.to_s + "\""+","+"\""+@name.to_s + "\""+","+"\""+@category.to_s + "\"" + "," +"\""+ @majorCategory.to_s + "\""+"],"
    else
      return "empty string"
    end
  end
end
