require './dataMethodsTest'
require './parser/parser'

class UnicodeData

  def initialize
    @data = DataSystem.new(buildData)
  end

  def buildData
    unicodeFile = "./parser/UnicodeData.txt"
    aliasesFile = "./parser/NameAliases.txt"
    unicodeTable = UnicodeParser.new(unicodeFile, aliasesFile)
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
