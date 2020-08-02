require 'minitest/autorun'
require 'minitest/pride'
require './lib/file_reader'
require './lib/file_writer'
require './lib/night_reader'
require './lib/dictionary'

class NightReaderTest < Minitest::Test

  def test_it_exists
    night_reader = NightReader.new

    assert_instance_of NightReader, night_reader
  end

  def test_it_has_attributes
    night_reader = NightReader.new

    assert_instance_of FileReader, night_reader.reader
    assert_instance_of FileWriter, night_reader.writer
    assert_instance_of Dictionary, night_reader.dictionary
  end

  def test_it_can_read_reader
    night_reader = NightReader.new
    ARGV[0] = "test_input_reader/braille.txt"
    ARGV[1] = "test_output_reader/message.txt"

    assert_equal "hello world\n", night_reader.reader.read_first_arg
    assert_equal "hello world", night_reader.reader.read_first_arg.chomp
  end

  def test_it_can_print_ending_statement_correctly
    night_reader = NightReader.new
    ARGV[0] = "test_input_reader/braille.txt"
    ARGV[1] = "test_output_reader/message.txt"

    assert_equal "Created 'test_output_reader/message.txt' containing 11 characters", night_reader.output_statement
  end
  #
  def test_it_can_print_ending_statement_correctly_with_diff_message
    night_reader = NightReader.new
    ARGV[0] = "test_input_reader/braille.txt"
    ARGV[1] = "test_output_reader/backup_message.txt"

    assert_equal "Created 'test_output_reader/backup_message.txt' containing 11 characters", night_reader.output_statement
  end

  def test_it_can_write_with_writer
    night_reader = NightReader.new
    ARGV[0] = "test_input_reader/braille_for_tests.txt"
    ARGV[1] = "test_output_reader/message.txt"

    new_text = "Just for the test!"

    night_reader.writer.write(new_text)

    assert_equal "Just for the test!", night_reader.reader.read_second_arg
  end

  def test_read_from_one_write_to_another
    night_reader = NightReader.new
    ARGV[0] = "test_input_reader/braille.txt"
    ARGV[1] = "test_output_reader/message.txt"

    night_reader.read_and_write_english_to_english

    assert_equal "hello world", night_reader.reader.read_second_arg
  end

  def test_read_from_one_write_to_another_different
    night_reader = NightReader.new
    ARGV[0] = "test_input_reader/braille_for_tests.txt"
    ARGV[1] = "test_output_reader/message_for_tests.txt"

    night_reader.read_and_write_english_to_english

    assert_equal "Just for the test!", night_reader.reader.read_second_arg
  end

  def test_read_and_write_braille_to_braille
    night_reader = NightReader.new
      ARGV[0] = "test_input_reader/braille_a_for_tests.txt"
      ARGV[1] = "test_output_reader/message_a_for_tests.txt"

    night_reader.read_and_write_braille_to_braille

    assert_equal "0.\n..\n..", night_reader.reader.read_second_arg
  end

  def test_translate_to_english
    skip #not working now that we're doing more than one character
    night_reader = NightReader.new
    ARGV[0] = "test_input_reader/braille_a_for_tests.txt"
    ARGV[1] = "test_output_reader/message_a_for_tests.txt"
    new_text = night_reader.reader.read_first_arg.chomp

    assert_equal "a", night_reader.translate_to_english(new_text)
  end
  #
  # def test_find_braille_rows_assembled
  #   night_reader = NightReader.new
  #   ARGV[0] = "test_input_reader/braille_a_for_tests.txt"
  #   ARGV[1] = "test_output_reader/message_a_for_tests.txt"
  #   new_text = night_reader.reader.read_first_arg.chomp.split("")
  #   braille_message = night_reader.translate_to_braille(new_text)
  #   header, *rows = braille_message
  #   braille_by_row = header.zip(*rows)
  #
  #   assert_equal ["0.", "..", ".."], night_reader.find_braille_rows_assembled(braille_by_row)
  # end
  #
  # def test_find_braille_rows_shortened
  #   night_reader = NightWriter.new
  #   ARGV[0] = "test_input_reader/braille_a_for_tests.txt"
  #   ARGV[1] = "test_output_reader/message_a_for_tests.txt"
  #   new_text = night_reader.reader.read_first_arg.chomp.split("")
  #   braille_message = night_reader.translate_to_braille(new_text)
  #   header, *rows = braille_message
  #   braille_by_row = header.zip(*rows)
  #   braille_rows_assembled = night_reader.find_braille_rows_assembled(braille_by_row)
  #
  #   assert_equal [["0."], [".."], [".."]], night_reader.find_braille_rows_shortened(braille_rows_assembled)
  # end
  #
  # def test_find_transposed_b_message_w_breaks
  #   night_reader = NightWriter.new
  #   ARGV[0] = "test_input_reader/braille_a_for_tests.txt"
  #   ARGV[1] = "test_output_reader/message_a_for_tests.txt"
  #   new_text = night_reader.reader.read_first_arg.chomp.split("")
  #   braille_message = night_reader.translate_to_braille(new_text)
  #   header, *rows = braille_message
  #   braille_by_row = header.zip(*rows)
  #   braille_rows_assembled = night_reader.find_braille_rows_assembled(braille_by_row)
  #   braille_rows_shortened = night_reader.find_braille_rows_shortened(braille_rows_assembled)
  #
  #   assert_equal ["0.\n", "..\n", "..\n"], night_reader.find_transposed_b_message_w_breaks(braille_rows_shortened)
  # end

  # def test_find_braille_all_one_line
  #   night_reader = NightReader.new
  #   ARGV[0] = "test_input_reader/braille_a_for_tests.txt"
  #   ARGV[1] = "test_output_reader/message_a_for_tests.txt"
  #   new_text = night_reader.reader.read_first_arg.chomp.split("")
  #   braille_message = night_reader.translate_to_braille(new_text)
  #   header, *rows = braille_message
  #   braille_by_row = header.zip(*rows)
  #   braille_rows_assembled = night_reader.find_braille_rows_assembled(braille_by_row)
  #
  #   assert_equal ["0....."], night_reader.find_braille_all_one_line(braille_rows_assembled)
  # end
  #
  def test_write_a_braille_a_into_a_new_file
    # skip #this works, but skipping to work on "abc"
    night_reader = NightReader.new
    ARGV[0] = "test_input_reader/braille_a_for_tests.txt"
    ARGV[1] = "test_output_reader/message_a_for_tests.txt"

    night_reader.read_and_write_braille_to_english

    assert_equal "a", night_reader.reader.read_second_arg
  end
  #
  def test_write_abc_english_into_a_new_file
    # skip #this works, but skipping to work on "hello world"
    night_reader = NightReader.new
    ARGV[0] = "test_input_reader/braille_abc_for_tests.txt"
    ARGV[1] = "test_output_reader/message_abc_for_tests.txt"

    night_reader.read_and_write_braille_to_english

    assert_equal "abc", night_reader.reader.read_second_arg
  end

  def test_write_abc_english_into_a_new_file
    # skip #this works, but skipping to work on "hello world"
    night_reader = NightReader.new
    ARGV[0] = "test_input_reader/braille_capital_abc_for_tests.txt"
    ARGV[1] = "test_output_reader/message_capital_abc_for_tests.txt"

    night_reader.read_and_write_braille_to_english

    assert_equal "ABC", night_reader.reader.read_second_arg
  end

  def test_write_abc_english_into_a_new_file
    # skip #this works, but skipping to work on "hello world"
    night_reader = NightReader.new
    ARGV[0] = "test_input_reader/braille_capital_cba_for_tests.txt"
    ARGV[1] = "test_output_reader/message_capital_cba_for_tests.txt"

    night_reader.read_and_write_braille_to_english

    assert_equal "CBA", night_reader.reader.read_second_arg
  end

  def test_write_print_spaces
    # skip ##this works, but skipping to work on others
    night_reader = NightReader.new
    ARGV[0] = "test_input_reader/actual_braille_for_tests.txt"
    ARGV[1] = "test_output_reader/spaces.txt"

    night_reader.read_and_write_braille_to_english

    assert_equal "   ", night_reader.reader.read_second_arg
  end

  def test_write_hello_world
    # skip
    night_reader = NightReader.new
    ARGV[0] = "test_input_reader/hello_world_braille_test.txt"
    ARGV[1] = "test_output_reader/message.txt"

    night_reader.read_and_write_braille_to_english

    assert_equal "hello world", night_reader.reader.read_second_arg
  end
  #
  def test_write_braille_message_with_capitals
    night_reader = NightReader.new
    ARGV[0] = "test_input_reader/capitals_braille_for_tests.txt"
    ARGV[1] = "test_output_reader/message_for_tests.txt"

    night_reader.read_and_write_braille_to_english

    assert_equal "Just for the test!", night_reader.reader.read_second_arg
  end
  #
  def test_write_a_very_long
    night_reader = NightReader.new
    ARGV[0] = "test_input_reader/long_braille_for_tests.txt"
    ARGV[1] = "test_output_reader/long_message.txt"

    night_reader.read_and_write_braille_to_english

    assert_equal 184, night_reader.reader.read_second_arg.length
  end
  #
  def test_write_all_characters
    night_reader = NightReader.new
    ARGV[0] = "test_input_reader/all_characters_for_tests.txt"
    ARGV[1] = "test_output_reader/all_characters.txt"

    night_reader.read_and_write_braille_to_english

    assert_equal  " !',-.?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", night_reader.reader.read_second_arg
  end

  def test_write_all_characters_and_numbers
    night_reader = NightReader.new
    ARGV[0] = "test_input_reader/all_characters_and_numbers_for_tests.txt"
    ARGV[1] = "test_output_reader/all_characters_and_numbers.txt"

    night_reader.read_and_write_braille_to_english

    assert_equal  " !',-.?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890", night_reader.reader.read_second_arg
  end

end
