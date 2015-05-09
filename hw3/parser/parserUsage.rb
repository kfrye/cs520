###
###
###
### Parser Usage Example
###
###
###
###

$LOAD_PATH.unshift File.dirname(__FILE__) #add current dir to the path
require 'parser'

currdir = Dir.getwd #current dir
unicodeFile =currdir + "/UnicodeData.txt"
aliasesFile =currdir + "/NameAliases.txt"

#parser creates dictionary "table", key - codeValue, value - dictionary of entries
p = UnicodeParser.new(unicodeFile, aliasesFile)

p.hashTable.each do | row |
  puts row
end
