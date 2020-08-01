require 'minitest/autorun'
require 'minitest/pride'
require './lib/file_reader'

class FileReaderTest < Minitest::Test

  def test_it_exists
    reader = FileReader.new

    assert_instance_of FileReader, reader
  end

  def test_it_can_read_first_arg
    reader = FileReader.new
    ARGV[0] = "message.txt"

    assert_equal "hello world\n", reader.read_first_arg
  end

  def test_it_can_read_second_arg
    reader = FileReader.new
    ARGV[0] = "braille_for_tests.txt"

    assert_equal "Just for the test!", reader.read_first_arg
  end


end
