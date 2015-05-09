require 'minitest/autorun'
require './unicode'

class UnicodeTest < Minitest::Unit::TestCase
  def setup
    unicode = Unicode.new
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

  def test_object_equality
    obj = @data.objByCodepoint('003E')
    obj2 = @data.objByName('GREATER-THAN SIGN')
    assert_equal(obj.object_id, obj2.object_id)
  end
end

