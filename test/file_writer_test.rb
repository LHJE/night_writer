require 'minitest/autorun'
require 'minitest/pride'
require './lib/file_writer'

class FileWriterTest < Minitest::Test

  def test_it_exists
    writer = FileWriter.new

    assert_instance_of FileWriter, writer
  end

  def test_it_can_write
    writer = FileWriter.new
    ARGV[1] = "test_output_writer/braille.txt"
    new_text = "Well hello back!"

    writer.write(new_text)

    assert_equal 16, writer.write(new_text)
  end

end
