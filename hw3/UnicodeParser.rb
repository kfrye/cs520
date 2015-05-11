require './Parser'
require './Character'


class UnicodeParser <  Parser
  attr_reader :table

  def initialize(*args)
    @hashTable = Hash.new()
    @table = []
    @unicodeFile = args[0]
    @aliasesFile = args[1]
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
