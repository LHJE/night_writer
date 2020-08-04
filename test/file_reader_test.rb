require './test/test_helper'
require './lib/file_reader'

class FileReaderTest < Minitest::Test

  def test_it_exists
    reader = FileReader.new

    assert_instance_of FileReader, reader
  end

  def test_it_can_read_first_arg
    reader = FileReader.new
    ARGV[0] = "test_input_reader/message.txt"
    ARGV[1] = "test_input_writer/message.txt"

    assert_equal "Well hello 2 you!\n", reader.read_first_arg
  end

  def test_it_can_read_second_arg
    reader = FileReader.new
    ARGV[0] = "test_input_writer/message.txt"
    ARGV[1] = "test_input_writer/message.txt"

    assert_equal "hello world\n", reader.read_second_arg
  end
end
