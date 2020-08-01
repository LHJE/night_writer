require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_writer'
require './lib/file_reader'

class NightWriterTest < Minitest::Test

  # def test_it_exists
  #   night_writer = NightWriter.new
  #
  #   assert_instance_of NightWriter, night_writer
  # end

  def test_it_can_read_reader
    night_writer = NightWriter.new
    ARGV[0] = "message.txt"
    ARGV[1] = "braille.txt"

    assert_equal "hello world\n", night_writer.reader.read
  end

  def test_it_can_print_ending_statement_correctly
    night_writer = NightWriter.new
    ARGV[0] = "message.txt"
    ARGV[1] = "braille.txt"


    assert_equal "Created 'braille.txt' containing 11 characters", night_writer.output_statement
  end

end
