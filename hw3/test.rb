#This file is for screwing around with data. Don't turn it in with
#the assignment

require './unicodeData'

unicode = UnicodeData.new
data = unicode.data
puts data
puts data.name('003E')
puts data.majorCategory('003E')
puts data.character('GREATER-THAN SIGN')
puts data.category('003E')

puts data.name('FFFF')
puts data.name(nil)
