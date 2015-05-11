$LOAD_PATH.unshift File.dirname(__FILE__) #add current dir to the path

require 'parser'

class UnicodeParser <  Parser
  attr_reader :table
  def initialize(unicodeFile, aliasesFile)
    @hashTable = Hash.new()
    @table = []
    @unicodeFile = unicodeFile
    @aliasesFile = aliasesFile
    self.parseUnicode
    self.parseAliases


    @hashTable.each do |key, value|
      @table.push(value)
    end
  end

  def to_s
    @hashTable.to_s
  end


  def parseUnicode()
    lines = parse(@unicodeFile, ';')
    @hashTable = Hash[lines.each_with_index.map { |value| [value[0], Character.new(value)] }]
  end

  def parseAliases()
    lines = parse(@aliasesFile, ';')
    lines.each do | line |
      keyPoint = line[0]
      newName = line[1]
      @hashTable[keyPoint].updateName(newName) #update value name
    end
  end
end
