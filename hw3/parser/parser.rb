# Holds the data for each unicode character
class Character
  attr_reader :codepoint, :name, :category, :majorCategory
  def initialize(entries)
    #in total we have 15 entries for each Unicode character
      @codepoint= entries[0].to_sym
      @name= entries[1].to_sym
      @category= entries[2].to_sym
      @majorCategory= entries[2][0].to_sym
#        :canonicalCombiningClasses=> entries[3],
#        :bidirectionalCategory=> entries[4],
#        :characterDecompositionMapping=> entries[5],
#        :decimalDigitValue=> entries[6],
#        :digitValue=> entries[7],
#        :numericValue=> entries[8],
#        :mirrored=> entries[9],
#        :unicode1Name=> entries[10],
#        :commentField=> entries[11],
#        :uppercaseMapping=> entries[12],
#        :lowercaseMapping=> entries[13],
#        :titlecaseMapping=> entries[14]
    return self
  end

  def updateName(newName)
    @name = newName
  end

  def size
    @fields.length
  end

  def each(&block)
    @fields.each(&block)
    self
  end

  def codeValue
    @fields
  end

  def to_s
    if (!@codepoint.nil? && !@name.nil? && !@category.nil? && !@majorCategory.nil?)
      "\""+codepoint+ "\""+"=> [" + "\""+@codepoint+ "\""+","+"\""+@name+ "\""+","+"\""+@category+ "\"" + "," +"\""+ @majorCategory+ "\""+"],"
    else
      return "empty string"
    end
  end
end

# Parses the unicode files and creates a collection of unicode characters
class UnicodeParser
  attr_reader :table, :hashTable
  def initialize(unicodeFile, aliasesFile)
    @hashTable = {}
    @table = []
    @unicodeFile = unicodeFile
    @aliasesFile = aliasesFile
    self.parseUnicode
    self.parseAliases
    @hashTable.each do |key, value|
      @table.push(value)
    end
  end

  def print
    @hashTable.each do |entry|
      puts entry
      break
    end
  end

  def to_s  #very slow since it creates vast string, takes couple minutes to complete
    retVal = ""
    @hashTable.each do |key , val|
      retVal += val.to_s + "\n"
    end
    retVal
  end

  def parseUnicode()
    File.open(@unicodeFile, "r") do |file_handle|
      file_handle.each_line do |server|
        entries =  server.split(';')
        resetEmpty(entries)
        key = entries[0].to_sym
        @hashTable[key] = Character.new(entries)
      end
    end
  end

  # Update the unicode names if needed
  def parseAliases()
    File.open(@aliasesFile, "r") do |file_handle|
      file_handle.each_line do |server|
        entries =  server.split(';')
        resetEmpty(entries)
        key = entries[0].to_sym
        if /#.*/.match(key) or /$^/.match(key) #skip comments and empty lines
          next
        end
        newName = entries[1]
        @hashTable[key].updateName(newName) #update value name
      end
    end
  end

  def resetEmpty(arr)
    arr.map! {|x| x == "" ? nil : x}
  end
end
