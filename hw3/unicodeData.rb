require './dataMethods'
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

    unicodeTable.table.each do |key, value|
      charArray.push(Character.new(unicodeTable.table[key].fields[:characterName], 
        key, unicodeTable.table[key].fields[:generalCategory]))
    end
    charArray
  end

  def data
    @data
  end
end
