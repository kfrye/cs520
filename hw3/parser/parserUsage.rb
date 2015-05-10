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


#parser creates dictionary "table", key - codeValue, value - dictionary of entries
p = UnicodeParser.new()

p.hashTable.each do | row, value |
  puts value.to_s
end
#puts p.table
