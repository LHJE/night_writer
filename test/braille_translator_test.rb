require 'minitest/autorun'
require 'minitest/pride'
require './lib/file_reader'
require './lib/file_writer'
require './lib/braille_translator'
require './lib/dictionary'

class BrailleTranslatorTest < Minitest::Test

  def test_it_exists
    braille_translator = BrailleTranslator.new

    assert_instance_of BrailleTranslator, braille_translator
  end

  def test_it_has_attributes
    braille_translator = BrailleTranslator.new

    assert_instance_of FileReader, braille_translator.reader
    assert_instance_of FileWriter, braille_translator.writer
    assert_instance_of Dictionary, braille_translator.dictionary
  end

  def test_it_can_read_reader
    braille_translator = BrailleTranslator.new
    ARGV[0] = "test_input_reader/braille.txt"
    ARGV[1] = "test_output_reader/message.txt"

    assert_equal "hello world\n", braille_translator.reader.read_first_arg
    assert_equal "hello world", braille_translator.reader.read_first_arg.chomp
  end

  def test_it_can_write_with_writer
    braille_translator = BrailleTranslator.new
    ARGV[0] = "test_input_reader/braille_for_tests.txt"
    ARGV[1] = "test_output_reader/message.txt"
    new_text = braille_translator.reader.read_first_arg.chomp
    braille_translator.writer.write(new_text)

    assert_equal "Just for the test!", braille_translator.reader.read_second_arg
  end

  def test_find_braille_multiple_lines
    braille_translator = BrailleTranslator.new
    ARGV[0] = "test_input_reader/capitals_braille_for_tests.txt"
    ARGV[1] = "test_output_reader/new_message1.txt"
    new_text = braille_translator.reader.read_first_arg.chomp

    assert_equal [["...00..0.0..000.0....00.0....00..0.0..", "..00..0.00..0..000..0000.0..00.00.0000", ".0..000.0.....0.0...0.......0...0.0.0."]], braille_translator.find_braille_multiple_lines(new_text)
  end

  def test_find_untransposed_b_message
    braille_translator = BrailleTranslator.new
    ARGV[0] = "test_input_reader/long_braille_for_tests.txt"
    ARGV[1] = "test_output_reader/new_message2.txt"
    new_text = braille_translator.reader.read_first_arg.chomp
    braille_multiple_lines = braille_translator.find_braille_multiple_lines(new_text)

    assert_equal ["...00.0..0...0..000..0..000..00.....000.0...0.000..0.......000...00...0.000..0...00.0.00...00....00.0.0...000..00000...00...00.00.....000.0.000.0....00.0.0.00..0.0.0.00..0.0..0.00.0...0..00.0..0.......0..00....00..0...0...00..0...0.....0...00..0....0.....0..0...0...00.....0..0...0...00.....0..0...0...0.....00..0....0..00..00.....0..0.....00...0..0........0.....0..0....0..00..0......0..0...0...00....00..0...0...0...0...0...0...00.....0..0...0...0...00..00.....0....0....0..0...0.....0....0....0...0...0...", "..0000..00..0....0.000..0...0.000....0.0.......0.00000....0.0...00.0.....0.000..0000.0.0..00.0..00.000.0..00.00..000..00.0...00..00...0..0.00.0..0..00.0..0..0..0..0...0..0..00000.000..0.0.0..00.00....0...0.....0....0...0..0...0....0.........0...0..00....00..00...0...0....00..00...0...0....00...0..00...0....00...0..0....0..00....00...0.....0..0....00.....0.....00..00..0....0........00..00...0...0....0...00...0..0.......0...0....0....00...0......0....0...0....00....0...0...0....0........00........0...0.00", ".00.....0.0.0...0.0.0.........0.....000.00..0.0.0..0.0...0.......0....0.0....0...0....0....0.....0..0.......0...0.....0.0.............0...0.0.0......00.000.....0.............0.0...0...0...00..0..0...0...0.....00..0...00..00..00..0.....00..00..0...0.0...0.0.0...0...00....00..0...0...000...0.0.0...00..0.....0...00..0...00..0.....00..00....0...0...0.......0.....00..0...0...00..00....00..0...0...000...00..00..00..0...0...0...00..000...0.0.00..000.00..0...00.0..00....00..0...000.0.....0...00....0...00..00..0"], braille_translator.find_untransposed_b_message(braille_multiple_lines)
  end

  def test_translate_to_english
    braille_translator = BrailleTranslator.new
    ARGV[0] = "test_input_reader/capitals_braille_for_tests.txt"
    ARGV[1] = "test_output_reader/new_message3.txt"
    new_text = braille_translator.reader.read_first_arg.chomp
    braille_multiple_lines = braille_translator.find_braille_multiple_lines(new_text)
    untransposed_b_message_w_breaks = braille_translator.find_untransposed_b_message(braille_multiple_lines)

    assert_equal "Just for the test!", braille_translator.translate_to_english(untransposed_b_message_w_breaks)
  end

  def test_slice_two_from_each_string
    braille_translator = BrailleTranslator.new
    ARGV[0] = "test_input_reader/capitals_braille_for_tests.txt"
    ARGV[1] = "test_output_reader/new_message3.txt"
    new_text = braille_translator.reader.read_first_arg.chomp
    braille_multiple_lines = braille_translator.find_braille_multiple_lines(new_text)
    untransposed_b_message_w_breaks = braille_translator.find_untransposed_b_message(braille_multiple_lines)

    assert_equal [".00..0.0..000.0....00.0....00..0.0..", "00..0.00..0..000..0000.0..00.00.0000", "..000.0.....0.0...0.......0...0.0.0."], braille_translator.slice_two_from_each_string(untransposed_b_message_w_breaks)
  end

  def test_english_message_if_long_braille_string
    braille_translator = BrailleTranslator.new
    ARGV[0] = "test_input_reader/capitals_braille_for_tests.txt"
    ARGV[1] = "test_output_reader/new_message3.txt"
    braille = "..00 .... .0.."
    letter = "C"
    braille_array = ["..00..0.", "........", ".0...0.."]

    assert_equal ["C"], braille_translator.english_message_if_long_braille_string(braille_array, letter, braille)
  end

  def test_find_english_message
    braille_translator = BrailleTranslator.new
    ARGV[0] = "test_input_reader/capitals_braille_for_tests.txt"
    ARGV[1] = "test_output_reader/new_message3.txt"
    braille = "...0 ..00 .00."
    letter = "T"
    braille_array = ["...00.0.", "..00....", ".00....."]

    assert_equal [["T"]], braille_translator.find_english_message(braille_array, letter, braille)
  end

  def test_read_and_write_braille_to_english
    braille_translator = BrailleTranslator.new
    ARGV[0] = "test_input_reader/capitals_braille_for_tests.txt"
    ARGV[1] = "test_output_reader/new_message4.txt"
    new_text = braille_translator.reader.read_first_arg.chomp
    new_text = braille_translator.reader.read_first_arg.chomp
    braille_multiple_lines = braille_translator.find_braille_multiple_lines(new_text)
    untransposed_b_message_w_breaks = braille_translator.find_untransposed_b_message(braille_multiple_lines)
    english_message = braille_translator.translate_to_english(untransposed_b_message_w_breaks)
    braille_translator.writer.write(english_message)

    assert_equal "Just for the test!", braille_translator.reader.read_second_arg
  end

  def test_write_a_braille_a_into_a_new_file
    braille_translator = BrailleTranslator.new
    ARGV[0] = "test_input_reader/braille_a_for_tests.txt"
    ARGV[1] = "test_output_reader/message_a_for_tests.txt"
    braille_translator.read_and_write_braille_to_english

    assert_equal "a", braille_translator.reader.read_second_arg
  end

  def test_write_abc_english_into_a_new_file
    braille_translator = BrailleTranslator.new
    ARGV[0] = "test_input_reader/braille_abc_for_tests.txt"
    ARGV[1] = "test_output_reader/message_abc_for_tests.txt"
    braille_translator.read_and_write_braille_to_english

    assert_equal "abc", braille_translator.reader.read_second_arg
  end

  def test_write_abc_english_into_a_new_file
    braille_translator = BrailleTranslator.new
    ARGV[0] = "test_input_reader/braille_capital_abc_for_tests.txt"
    ARGV[1] = "test_output_reader/message_capital_abc_for_tests.txt"
    braille_translator.read_and_write_braille_to_english

    assert_equal "ABC", braille_translator.reader.read_second_arg
  end

  def test_write_abc_english_into_a_new_file
    braille_translator = BrailleTranslator.new
    ARGV[0] = "test_input_reader/braille_capital_cba_for_tests.txt"
    ARGV[1] = "test_output_reader/message_capital_cba_for_tests.txt"
    braille_translator.read_and_write_braille_to_english

    assert_equal "CBA", braille_translator.reader.read_second_arg
  end

  def test_write_spaces
    braille_translator = BrailleTranslator.new
    ARGV[0] = "test_input_reader/actual_braille_for_tests.txt"
    ARGV[1] = "test_output_reader/spaces.txt"
    braille_translator.read_and_write_braille_to_english

    assert_equal "   ", braille_translator.reader.read_second_arg
  end

  def test_write_hello_world
    braille_translator = BrailleTranslator.new
    ARGV[0] = "test_input_reader/hello_world_braille_test.txt"
    ARGV[1] = "test_output_reader/message.txt"
    braille_translator.read_and_write_braille_to_english

    assert_equal "hello world", braille_translator.reader.read_second_arg
  end

  def test_write_braille_message_with_capital_and_symbol
    braille_translator = BrailleTranslator.new
    ARGV[0] = "test_input_reader/capitals_braille_for_tests.txt"
    ARGV[1] = "test_output_reader/message_for_tests.txt"
    braille_translator.read_and_write_braille_to_english

    assert_equal "Just for the test!", braille_translator.reader.read_second_arg
  end

  def test_write_a_very_long_message
    braille_translator = BrailleTranslator.new
    ARGV[0] = "test_input_reader/long_braille_for_tests.txt"
    ARGV[1] = "test_output_reader/long_message.txt"
    braille_translator.read_and_write_braille_to_english

    assert_equal 184, braille_translator.reader.read_second_arg.length
  end

  def test_write_all_characters
    braille_translator = BrailleTranslator.new
    ARGV[0] = "test_input_reader/all_characters_for_tests.txt"
    ARGV[1] = "test_output_reader/all_characters.txt"
    braille_translator.read_and_write_braille_to_english

    assert_equal  " !',-.?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", braille_translator.reader.read_second_arg
  end

  def test_write_all_characters_and_numbers
    braille_translator = BrailleTranslator.new
    ARGV[0] = "test_input_reader/all_characters_and_numbers_for_tests.txt"
    ARGV[1] = "test_output_reader/all_characters_and_numbers.txt"
    braille_translator.read_and_write_braille_to_english

    assert_equal  " !',-.?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890", braille_translator.reader.read_second_arg
  end

  def test_it_can_print_ending_statement_correctly
    braille_translator = BrailleTranslator.new
    ARGV[0] = "test_input_reader/braille.txt"
    ARGV[1] = "test_output_reader/message.txt"

    assert_equal "Created 'test_output_reader/message.txt' containing 11 characters", braille_translator.output_statement
  end
end
