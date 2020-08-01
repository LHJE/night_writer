require 'minitest/autorun'
require 'minitest/pride'
require './data/braille_dictionary.csv'

class DictionaryTest < Minitest::Test

  def test_it_exists
    dictionary = Dictionary.new

    assert_instance_of Dictionary, dictionary
  end




end
