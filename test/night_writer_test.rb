require 'minitest/autorun'
require 'minitest/pride'
require './lib/file_reader'
require './lib/file_writer'
require './lib/night_writer'
require './lib/dictionary'

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
    ARGV[0] = "test_input/message.txt"
    ARGV[1] = "test_output/braille.txt"

    assert_equal "hello world\n", night_writer.reader.read_first_arg
    assert_equal "hello world", night_writer.reader.read_first_arg.chomp
  end

  def test_it_can_print_ending_statement_correctly_with_diff_message
    night_writer = NightWriter.new
    ARGV[0] = "test_input/backup_message.txt"
    ARGV[1] = "test_output/braille.txt"

    assert_equal "Created 'braille.txt' containing 184 characters", night_writer.output_statement
  end


  def test_it_can_print_ending_statement_correctly
    night_writer = NightWriter.new
    ARGV[0] = "test_input/message.txt"
    ARGV[1] = "test_output/braille.txt"

    assert_equal "Created 'test_output/braille.txt' containing 11 characters", night_writer.output_statement
  end

  def test_it_can_print_ending_statement_correctly_with_diff_message
    night_writer = NightWriter.new
    ARGV[0] = "test_input/long_message.txt"
    ARGV[1] = "test_output/braille.txt"

    assert_equal "Created 'test_output/braille.txt' containing 184 characters", night_writer.output_statement
  end

  def test_it_can_write_with_writer
    night_writer = NightWriter.new
    ARGV[0] = "test_input/message.txt"
    ARGV[1] = "test_output/braille_for_tests.txt"

    new_text = "Just for the test!"

    night_writer.writer.write(new_text)

    assert_equal "Just for the test!", night_writer.reader.read_second_arg
  end

  def test_read_from_one_write_to_another
    night_writer = NightWriter.new
    ARGV[0] = "test_input/message.txt"
    ARGV[1] = "test_output/braille.txt"

    night_writer.read_and_write_english_to_english

    assert_equal "hello world", night_writer.reader.read_second_arg
  end

  def test_read_from_one_write_to_another_different
    night_writer = NightWriter.new
    ARGV[0] = "test_input/message_for_tests.txt"
    ARGV[1] = "test_output/braille_for_tests.txt"

    night_writer.read_and_write_english_to_english

    assert_equal "Just for the test!", night_writer.reader.read_second_arg
  end

  def test_translate_to_braille
    night_writer = NightWriter.new
    ARGV[0] = "test_input/message_a_for_tests.txt"
    ARGV[1] = "test_output/braille_a_for_tests.txt"
    new_text = night_writer.reader.read_first_arg.chomp.split("")

    assert_equal [["0.", "..", ".."]], night_writer.translate_to_braille(new_text)
  end

  def test_find_braille_rows_assembled
    night_writer = NightWriter.new
    ARGV[0] = "test_input/message_a_for_tests.txt"
    ARGV[1] = "test_output/braille_a_for_tests.txt"
    new_text = night_writer.reader.read_first_arg.chomp.split("")
    braille_message = night_writer.translate_to_braille(new_text)
    header, *rows = braille_message
    braille_by_row = header.zip(*rows)

    assert_equal ["0.\n", "..\n", "..\n"], night_writer.find_braille_rows_assembled(braille_by_row)
  end



  def test_write_a_braille_a_into_a_new_file

    night_writer = NightWriter.new
    ARGV[0] = "test_input/message_a_for_tests.txt"
    ARGV[1] = "test_output/braille_a_for_tests.txt"

    night_writer.read_and_write_english_to_braille

    assert_equal "0.\n..\n..", night_writer.reader.read_second_arg
  end

  def test_write_ab_braille_a_into_a_new_file
    night_writer = NightWriter.new
    ARGV[0] = "test_input/message_abc_for_tests.txt"
    ARGV[1] = "test_output/braille_abc_for_tests.txt"

    night_writer.read_and_write_english_to_braille

    assert_equal "0.0.00\n..0...\n......", night_writer.reader.read_second_arg
  end

  def test_write_print_spaces
    night_writer = NightWriter.new
    ARGV[0] = "test_input/spaces.txt"
    ARGV[1] = "test_output/actual_braille_for_tests.txt"

    night_writer.read_and_write_english_to_braille

    assert_equal "......\n......\n......", night_writer.reader.read_second_arg
  end

  def test_write_hello_world
    night_writer = NightWriter.new
    ARGV[0] = "test_input/message.txt"
    ARGV[1] = "test_output/hello_world_braille_test.txt"

    night_writer.read_and_write_english_to_braille

    assert_equal "0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0...", night_writer.reader.read_second_arg
  end

  def test_write_braille_message_with_capitals
    night_writer = NightWriter.new
    ARGV[0] = "test_input/message_for_tests.txt"
    ARGV[1] = "test_output/capitals_braille_for_tests.txt"

    night_writer.read_and_write_english_to_braille

    assert_equal "...00..0.0..000.0....00.0....00..0.0..\n..00..0.00..0..000..0000.0..00.00.0000\n.0..000.0.....0.0...0.......0...0.0.0.", night_writer.reader.read_second_arg
  end

  def test_write_a_very_long
    night_writer = NightWriter.new
    ARGV[0] = "test_input/long_message.txt"
    ARGV[1] = "test_output/long_braille_for_tests.txt"

    night_writer.read_and_write_english_to_braille

    assert_equal 1526, night_writer.reader.read_second_arg.length
  end

end
