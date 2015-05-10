$LOAD_PATH.unshift File.dirname(__FILE__) #add current dir to the path
require './unicodeBiMap'
require './parser/parser'

class Unicode

  def initialize
    @data = UnicodeBiMap.new(buildData)
  end

  def buildData
    unicodeFile = "./parser/UnicodeData.txt"
    aliasesFile = "./parser/NameAliases.txt"
    unicodeTable = UnicodeParser.new(unicodeFile, aliasesFile)

    unicodeTable
  end

  def data
    @data
  end
end
