require './unicode'

unicode = UnicodeData.new
data = unicode.data

puts data.name('003E')
puts data.majorCategory('003E')
puts data.character('GREATER-THAN SIGN')
puts data.category('003E')

puts data.name('FFFF')
