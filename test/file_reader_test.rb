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
    ARGV[0] = "test_input_reader/message.txt"
    ARGV[1] = "test_input_writer/message.txt"

    assert_equal "Well hello 2 you!\n", reader.read_first_arg
  end

  def test_it_can_read_second_arg
    # skip
    reader = FileReader.new
    ARGV[0] = "test_input_writer/message.txt"
    ARGV[1] = "test_input_writer/message.txt"

    assert_equal "hello world\n", reader.read_second_arg
  end

  def test_puts_message
    reader = self
    ARGV[0] = "message.tx"
    ARGV[1] = "braille.txt"
    def read_first_arg_test
      filename = ARGV[0]
      other_file = ARGV[1]
      if filename == nil || other_file == nil || filename[-4..-1] != ".txt" || other_file[-4..-1] != ".txt"
        p ""
        p "Please put in two arguments after running the file:"
        p "1) the file from which you'd like to read"
        p "2) the file to which you'd like to write"
        p "* the first file must already exist, and end with '.txt'"
      else
        p "it didn't work"
      end
    end

    assert_equal "* the first file must already exist, and end with '.txt'", reader.read_first_arg_test
  end
end
