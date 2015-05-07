require 'dataMethods'
require 'parser/parser'

$LOAD_PATH.unshift File.dirname(__FILE__) #add current dir to the path

currdir = Dir.getwd #current dir
unicodeFile =currdir + "/parser/UnicodeData.txt"
aliasesFile =currdir + "/parser/NameAliases.txt"

p = UnicodeParser.new(unicodeFile, aliasesFile)

characterArray = Array.new()


p.table.each do |key, value|
	characterArray.push(Character.new(p.table[key].fields[:characterName], key, p.table[key].fields[:generalCategory]))
end

s = DataSystem.new(characterArray)

puts s.name('003E')
puts s.majorCategory('003E')
puts s.category('003E')
puts s.character('GREATER-THAN SIGN')