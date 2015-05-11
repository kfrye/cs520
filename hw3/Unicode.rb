require './UnicodeMap'

#Unicode class which holds all the data after being processed
class Unicode

  def initialize(table)
    @data = UnicodeMap.new(table)
  end

  def data
    @data
  end
end
