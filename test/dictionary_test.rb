require 'minitest/autorun'
require 'minitest/pride'
require './lib/dictionary.rb'

class DictionaryTest < Minitest::Test

  def test_it_exists
    dictionary = Dictionary.new("./data/braille_dictionary.txt")

    assert_instance_of Dictionary, dictionary
  end

  def test_make_dictionary
    dictionary = Dictionary.new("./data/braille_dictionary.txt")

    assert_equal "asdff", dictionary
  end


end
