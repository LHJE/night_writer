require 'minitest/autorun'
require 'minitest/pride'
require './lib/file_reader'
require './lib/file_writer'
require './lib/night_writer'

class NightWriterTest < Minitest::Test

  def test_it_exists
    night_writer = NightWriter.new

    assert_instance_of NightWriter, night_writer
  end

  def test_it_has_attributes
    night_writer = NightWriter.new

    assert_instance_of FileReader, night_writer.reader
    assert_instance_of FileWriter, night_writer.writer
    assert_instance_of Dictionary, night_writer.dictionary
  end

  def test_it_can_read_reader
    night_writer = NightWriter.new
    ARGV[0] = "message.txt"
    ARGV[1] = "braille.txt"

    assert_equal "hello world\n", night_writer.reader.read_first_arg
    assert_equal "hello world", night_writer.reader.read_first_arg.chomp
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

  def test_it_can_write_with_writer
    night_writer = NightWriter.new
    ARGV[0] = "message.txt"
    ARGV[1] = "braille_for_tests.txt"

    new_text = "Just for the test!"

    night_writer.writer.write(new_text)

    assert_equal "Just for the test!", night_writer.reader.read_second_arg
  end

  def test_read_from_one_write_to_another
    night_writer = NightWriter.new
    ARGV[0] = "message.txt"
    ARGV[1] = "braille.txt"

    night_writer.read_and_write

    assert_equal "hello world", night_writer.reader.read_second_arg
  end

  def test_read_from_one_write_to_another_different
    night_writer = NightWriter.new
    ARGV[0] = "message_for_tests.txt"
    ARGV[1] = "braille_for_tests.txt"

    night_writer.read_and_write

    assert_equal "Just for the test!", night_writer.reader.read_second_arg
  end

end
