$LOAD_PATH.unshift File.dirname(__FILE__) #add current dir to the path
require './dataMethodsTest'
require './parser/parser'

class UnicodeData

  def initialize
    @data = DataSystem.new(buildData)
  end

  def buildData
    unicodeTable = UnicodeParser.new()
    charArray = Array.new()

    unicodeTable.hashTable.each do |key, value|
      charArray.push(Character.new(unicodeTable.hashTable[key].fields[:@name],
        key, unicodeTable.hashTable[key].fields[:@category]))
    end
    charArray
  end

  def data
    @data
  end
end
