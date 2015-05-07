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
    characterArray = Array.new()

    unicodeTable.table.each do |key, value|
      characterArray.push(Character.new(unicodeTable.table[key].fields[:characterName], 
        key, unicodeTable.table[key].fields[:generalCategory]))
    end
    characterArray
  end

  def data
    @data
  end
end
#puts s.name('003E')
#puts s.majorCategory('003E')
#puts s.category('003E')
#puts s.character('GREATER-THAN SIGN')
