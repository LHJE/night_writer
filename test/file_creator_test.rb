require 'minitest/autorun'
require 'minitest/pride'
require './lib/file_creator'

class FileCreatorTest < Minitest::Test

  def test_it_exists
    writer = FileCreator.new

    assert_instance_of FileCreator, writer
  end

  def test_it_can_write
    writer = FileCreator.new
    ARGV[1] = "braille.txt"

    assert_equal 1, writer.write
  end

end
