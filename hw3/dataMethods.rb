class Character
	attr_reader :name, :codepoint, :category

	def initialize(name, codepoint, category)
		#Each character has these things
		@name = name;
		@codepoint = codepoint
		@category = category
	end

	def to_s
		puts @name + '     ' + @codepoint + '     ' + @category + "\n"
	end
end

class DataSystem
	attr_reader :codepoints, :names

	def initialize(characters)
		@codepoints = Hash.new();
		@names = Hash.new();
		characters.each do |item|
			names[item.name] = item
			codepoints[item.codepoint] = item
		end
	end

	def name(toFind)
		codepoints[toFind].name
	end

	def character(toFind)
		names[toFind].codepoint
	end

	def majorCategory(toFind)
		codepoints[toFind].category[0,1]
	end

	def category(toFind)
		codepoints[toFind].category
	end
end
