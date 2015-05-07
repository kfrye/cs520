require 'minitest/autorun'
require './unicodeData'

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

  def test_badcodepoint_name
    assert_nil(@data.name('FFFF'))
  end

  def test_badcodepoint_majorCategory
    assert_nil(@data.majorCategory('FFFF'))
  end

  def test_badcodepoint_category
    assert_nil(@data.category('FFFF'))
  end

  def test_badcodepoint_character
    assert_nil(@data.category('BAD NAME'))
  end

  def test_nil_input
    assert_nil(@data.name(nil))
  end
end

