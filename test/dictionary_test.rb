require 'minitest/autorun'
require 'minitest/pride'
require './lib/dictionary.rb'

class DictionaryTest < Minitest::Test

  def test_it_exists
    dictionary = Dictionary.new

    assert_instance_of Dictionary, dictionary
  end




end
