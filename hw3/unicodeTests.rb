require 'minitest/autorun'
require './UnicodeMap'
require './staticData'

class UnicodeTest < Minitest::Unit::TestCase
  def setup
    @data = UnicodeMap.new($table)
  end

  def test_greaterthan_nameByCode
    assert_equal(@data.name('003E'), :'GREATER-THAN SIGN')
  end

  def test_greaterthan_majorCategory
    assert_equal(@data.majorCategory('003E'), :'S')
  end

  def test_greaterthan_character
    assert_equal(@data.character('GREATER-THAN SIGN'), :'003E')
  end

  def test_greaterthan_category
    assert_equal(@data.category('003E'), :'Sm')
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

  def test_object_equality
    obj = @data.objByCodepoint('003E')
    obj2 = @data.objByName('GREATER-THAN SIGN')
    assert_equal(obj.object_id, obj2.object_id)
  end

  def test_symbol_equality_by_name
    obj1 = @data.objByCodepoint('003E')
    assert_equal(obj1.name.object_id, @data.names.key(obj1).object_id)
  end

  def test_symbol_equality_by_codepoint
    obj1 = @data.objByCodepoint('003E')
    assert_equal(obj1.codepoint.object_id, @data.codepoints.key(obj1).object_id)
  end

  def test_complete_memory_by_name
    @data.names.each do |key, value|
      assert_equal(value.name.object_id, key.object_id)
    end
  end

  def test_complete_memory_by_codepoint
    @data.codepoints.each do |key, value|
      assert_equal(value.codepoint.object_id,  key.object_id)
    end
  end

  def integrity_test
    $table.each do | i |
      keyCode = i[0]
      assert_equal(i[1], @data.name(i[0]))
    end
  end
end

