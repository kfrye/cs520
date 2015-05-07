require 'minitest/autorun'
require './unicode'

class UnicodeTest < MiniTest::Test
  def setup
    unicode = UnicodeData.new
    @data = unicode.data
  end

  def test_greaterthan_nameByCode
    assert_equal(@data.name('003E'), 'GREATER-THAN SIGN')
  end

  def test_greaterthan_majorCategory
    assert_equal(@data.majorCategory('003E'), 'S')
  end

  def test_greaterthan_character
    assert_equal(@data.character('GREATER-THAN SIGN'), '003E')
  end

  def test_greaterthan_category
    assert_equal(@data.category('003E'), 'Sm')
  end

  def test_badcode_name
    assert_nil(@data.name('FFFF'))
  end
end

