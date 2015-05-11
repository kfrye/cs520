# Holds the data for each unicode character
class Character
  attr_reader :codepoint, :name, :category, :majorCategory
  def initialize(entries)
      @codepoint= entries[0]
      @name= entries[1]
      @category= entries[2]
      @majorCategory= @category[0].to_sym
    return self
  end

  def updateName(newName)
    @name = newName
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

  def parse(file)
    lines = []
    File.open(file, "r") do |file_handle|
      file_handle.each_line do |server|
        entries =  server.split(';')
        resetEmpty(entries)
        arrayToSym(entries)
        lines.push(entries)
      end
    end
    lines

  end

  def skipComments(lines)
    ret = []
    lines.each do |key|
      if /#.*/.match(key) or /$^/.match(key) #skip comments and empty lines
        next
      end
      ret.push(key)
    end
  end
  #Perform first run through the base unicode file
  def parseUnicode()
    lines = parse(@unicodeFile)
    @hashTable = Hash[lines.each_with_index.map { |value| [value[0], Character.new(value)] }]
  end

  # Update the unicode names if needed
  def parseAliases()
    File.open(@aliasesFile, "r") do |file_handle|
      file_handle.each_line do |server|
        entries =  server.split(';')
        resetEmpty(entries)
        arrayToSym(entries)

        key = entries[0].to_sym
        if /#.*/.match(key) or /$^/.match(key) #skip comments and empty lines
          next
        end
        newName = entries[1].to_sym
        @hashTable[key].updateName(newName) #update value name
      end
    end
  end

  def resetEmpty(arr)
    arr.map! {|x| x == "" ? nil : x}
  end

  def arrayToSym(arr)
    arr.map! {|x| x == nil ? nil : x.to_sym}
  end
end
