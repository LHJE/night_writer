require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_writer'
require './lib/file_reader'
require './lib/file_writer'

class NightWriterTest < Minitest::Test

  def test_it_exists
    night_writer = NightWriter.new

    assert_instance_of NightWriter, night_writer
  end

  def test_it_has_attributes
    night_writer = NightWriter.new
    reader = FileReader.new
    writer = FileWriter.new

    assert_instance_of FileReader, night_writer.reader
    assert_instance_of FileWriter, night_writer.writer
  end

  def test_it_can_read_reader
    night_writer = NightWriter.new
    ARGV[0] = "message.txt"
    ARGV[1] = "braille.txt"

    assert_equal "hello world\n", night_writer.reader.read
    assert_equal "hello world", night_writer.reader.read.chomp
  end

  def test_it_can_print_ending_statement_correctly_with_diff_message
    night_writer = NightWriter.new
    ARGV[0] = "backup_message.txt"
    ARGV[1] = "braille.txt"

    assert_equal "Created 'braille.txt' containing 184 characters", night_writer.output_statement
  end


  def test_it_can_print_ending_statement_correctly
    night_writer = NightWriter.new
    ARGV[0] = "message.txt"
    ARGV[1] = "braille.txt"

    assert_equal "Created 'braille.txt' containing 11 characters", night_writer.output_statement
  end

  def test_it_can_print_ending_statement_correctly_with_diff_message
    night_writer = NightWriter.new
    ARGV[0] = "backup_message.txt"
    ARGV[1] = "braille.txt"

    assert_equal "Created 'braille.txt' containing 184 characters", night_writer.output_statement
  end

end
