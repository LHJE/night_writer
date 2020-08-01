require 'minitest/autorun'
require 'minitest/pride'
require './lib/file_creator'

class FileCreatorTest < Minitest::Test

  def test_it_exists
    creator = FileCreator.new

    assert_instance_of FileCreator, creator
  end

  def test_it_can_write
    creator = FileCreator.new
    ARGV[1] = "braille.txt"

    assert_equal 1, creator.write
  end

end
