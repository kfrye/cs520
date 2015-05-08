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

    unicodeTable.table
  end

  def data
    @data
  end
end

p = UnicodeData.new()