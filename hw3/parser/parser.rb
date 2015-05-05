def resetEmpty(arr)
  arr.map! {|x| x == "" ? nil : x}
end

class TableEntry
  attr_reader :fields
  def initialize(entries)
    #in total we have 15 entries for each Unicode character
    @fields = {
        :codeValue=> entries[0],
        :characterName=> entries[1],
        :generalCategory=> entries[2],
        :canonicalCombiningClasses=> entries[3],
        :bidirectionalCategory=> entries[4],
        :characterDecompositionMapping=> entries[5],
        :decimalDigitValue=> entries[6],
        :digitValue=> entries[7],
        :numericValue=> entries[8],
        :mirrored=> entries[9],
        :unicode1Name=> entries[10],
        :commentField=> entries[11],
        :uppercaseMapping=> entries[12],
        :lowercaseMapping=> entries[13],
        :titlecaseMapping=> entries[14]
    }
    return self
  end

  def updateName(newName)
    @fields[:characterName] = newName
  end

  def to_s
    @fields.to_s
  end

  def size
    @fields.length
  end

  def each(&block)
    @fields.each(&block)
    self
  end
end

class UnicodeParser
  attr_reader :table
  attr_writer :table
  def initialize(unicodeFile, aliasesFile)
    @table = {}
    @unicodeFile = unicodeFile
    @aliasesFile = aliasesFile
    self.parseUnicode
    self.parseAliases
  end

  def print
    @table.each do |entry|
      puts entry
      break
    end
  end

  def to_s  #very slow since it creates vast string, takes couple minutes to complete
    retVal = ""
    @table.each do |key , val|
      retVal += val.to_s + "\n"
    end
    retVal
  end

  def parseUnicode()
    File.open(@unicodeFile, "r") do |file_handle|
      file_handle.each_line do |server|
        entries =  server.split(';')
        resetEmpty(entries)
        key = entries[0]
        @table[key] = TableEntry.new(entries)
      end
    end
  end

  def parseAliases()
    File.open(@aliasesFile, "r") do |file_handle|
      file_handle.each_line do |server|
        entries =  server.split(';')
        resetEmpty(entries)
        key = entries[0]
        if /#.*/.match(key) or /$^/.match(key) #skip comments and empty lines
          next
        end
        newName = entries[1]
        @table[key].updateName(newName) #update value name
      end
    end
  end
end
