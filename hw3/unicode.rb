$LOAD_PATH.unshift File.dirname(__FILE__) #add current dir to the path
require './unicodeBiMap'
require './parser/parser'

class Unicode

  def initialize
    @data = UnicodeBiMap.new(buildData)
  end

  def buildData
    unicodeTable = UnicodeParser.new()

    unicodeTable
  end

  def data
    @data
  end
end
