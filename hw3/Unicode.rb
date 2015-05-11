require './UnicodeMap'
require './UnicodeParser'

#Unicode class which holds all the data after being processed
class Unicode

  def initialize
    @data = UnicodeMap.new(buildData)
  end

  def buildData
    unicodeFile = "./UnicodeData.txt"
    aliasesFile = "./NameAliases.txt"
    unicodeTable = UnicodeParser.new(unicodeFile, aliasesFile)

    unicodeTable
  end

  def data
    @data
  end
end
