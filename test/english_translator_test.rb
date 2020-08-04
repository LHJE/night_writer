require './test/test_helper'
require './lib/file_reader'
require './lib/file_writer'
require './lib/english_translator'
require './lib/dictionary'

class EnglishTranslatorTest < Minitest::Test

  def test_it_exists
    english_translator = EnglishTranslator.new

    assert_instance_of EnglishTranslator, english_translator
  end

  def test_it_has_attributes
    english_translator = EnglishTranslator.new

    assert_instance_of FileReader, english_translator.reader
    assert_instance_of FileWriter, english_translator.writer
    assert_instance_of Dictionary, english_translator.dictionary
  end

  def test_it_can_read_reader
    english_translator = EnglishTranslator.new
    ARGV[0] = "test_input_writer/message.txt"
    ARGV[1] = "test_output_writer/braille.txt"

    assert_equal "hello world\n", english_translator.reader.read_first_arg
    assert_equal "hello world", english_translator.reader.read_first_arg.chomp
  end

  def test_it_can_print_ending_statement_correctly
    english_translator = EnglishTranslator.new
    ARGV[0] = "test_input_writer/message.txt"
    ARGV[1] = "test_input_writer/message.txt"

    assert_equal "Created 'test_input_writer/message.txt' containing 11 characters", english_translator.output_statement
  end

  def test_it_can_write_with_writer
    english_translator = EnglishTranslator.new
    ARGV[0] = "test_input_writer/message.txt"
    ARGV[1] = "test_output_writer/braille_for_tests.txt"
    new_text = english_translator.reader.read_first_arg.chomp
    english_translator.writer.write(new_text)

    assert_equal "hello world", english_translator.reader.read_second_arg
  end

  def test_translate_to_braille
    english_translator = EnglishTranslator.new
    ARGV[0] = "test_input_writer/message_a_for_tests.txt"
    ARGV[1] = "test_output_writer/braille_a_for_tests.txt"
    new_text = english_translator.reader.read_first_arg.chomp.split("")

    assert_equal [["0.", "..", ".."]], english_translator.translate_to_braille(new_text)
  end

  def test_find_braille_by_row
    english_translator = EnglishTranslator.new
    ARGV[0] = "test_input_writer/message_a_for_tests.txt"
    ARGV[1] = "test_output_writer/braille_a_for_tests.txt"
    new_text = english_translator.reader.read_first_arg.chomp.split("")
    braille_message = english_translator.translate_to_braille(new_text)

    assert_equal [["0."], [".."], [".."]], english_translator.find_braille_by_row(braille_message)
  end

  def test_find_braille_rows_assembled
    english_translator = EnglishTranslator.new
    ARGV[0] = "test_input_writer/message_a_for_tests.txt"
    ARGV[1] = "test_output_writer/braille_a_for_tests.txt"
    new_text = english_translator.reader.read_first_arg.chomp.split("")
    braille_message = english_translator.translate_to_braille(new_text)
    header, *rows = braille_message
    braille_by_row = header.zip(*rows)

    assert_equal ["0.", "..", ".."], english_translator.find_braille_rows_assembled(braille_by_row)
  end

  def test_find_braille_rows_shortened
    english_translator = EnglishTranslator.new
    ARGV[0] = "test_input_writer/message_a_for_tests.txt"
    ARGV[1] = "test_output_writer/braille_a_for_tests.txt"
    new_text = english_translator.reader.read_first_arg.chomp.split("")
    braille_message = english_translator.translate_to_braille(new_text)
    header, *rows = braille_message
    braille_by_row = header.zip(*rows)
    braille_rows_assembled = english_translator.find_braille_rows_assembled(braille_by_row)

    assert_equal [["0."], [".."], [".."]], english_translator.find_braille_rows_shortened(braille_rows_assembled)
  end

  def test_find_transposed_b_message_w_breaks
    english_translator = EnglishTranslator.new
    ARGV[0] = "test_input_writer/message_a_for_tests.txt"
    ARGV[1] = "test_output_writer/braille_a_for_tests.txt"
    new_text = english_translator.reader.read_first_arg.chomp.split("")
    braille_message = english_translator.translate_to_braille(new_text)
    header, *rows = braille_message
    braille_by_row = header.zip(*rows)
    braille_rows_assembled = english_translator.find_braille_rows_assembled(braille_by_row)
    braille_rows_shortened = english_translator.find_braille_rows_shortened(braille_rows_assembled)

    assert_equal ["0.\n", "..\n", "..\n"], english_translator.find_transposed_b_message_w_breaks(braille_rows_shortened)
  end

  def test_find_braille_all_one_line
    english_translator = EnglishTranslator.new
    ARGV[0] = "test_input_writer/message_a_for_tests.txt"
    ARGV[1] = "test_output_writer/braille_a_for_tests.txt"
    new_text = english_translator.reader.read_first_arg.chomp.split("")
    braille_message = english_translator.translate_to_braille(new_text)
    header, *rows = braille_message
    braille_by_row = header.zip(*rows)
    braille_rows_assembled = english_translator.find_braille_rows_assembled(braille_by_row)

    assert_equal ["0....."], english_translator.find_braille_all_one_line(braille_rows_assembled)
  end

  def test_write_a_braille_a_into_a_new_file
    english_translator = EnglishTranslator.new
    ARGV[0] = "test_input_writer/message_a_for_tests.txt"
    ARGV[1] = "test_output_writer/braille_a_for_tests.txt"
    english_translator.read_and_write_english_to_braille

    assert_equal "0.\n..\n..", english_translator.reader.read_second_arg
  end

  def test_write_abc_braille_a_into_a_new_file
    english_translator = EnglishTranslator.new
    ARGV[0] = "test_input_writer/message_abc_for_tests.txt"
    ARGV[1] = "test_output_writer/braille_abc_for_tests.txt"
    english_translator.read_and_write_english_to_braille

    assert_equal "0.0.00\n..0...\n......", english_translator.reader.read_second_arg
  end

  def test_write_print_spaces
    english_translator = EnglishTranslator.new
    ARGV[0] = "test_input_writer/spaces.txt"
    ARGV[1] = "test_output_writer/actual_braille_for_tests.txt"
    english_translator.read_and_write_english_to_braille

    assert_equal "......\n......\n......", english_translator.reader.read_second_arg
  end

  def test_write_hello_world
    english_translator = EnglishTranslator.new
    ARGV[0] = "test_input_writer/message.txt"
    ARGV[1] = "test_output_writer/hello_world_braille_test.txt"
    english_translator.read_and_write_english_to_braille

    assert_equal "0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0...", english_translator.reader.read_second_arg
  end

  def test_write_braille_message_with_capitals
    english_translator = EnglishTranslator.new
    ARGV[0] = "test_input_writer/message_for_tests.txt"
    ARGV[1] = "test_output_writer/capitals_braille_for_tests.txt"
    english_translator.read_and_write_english_to_braille

    assert_equal "...00..0.0..000.0....00.0....00..0.0..\n..00..0.00..0..000..0000.0..00.00.0000\n.0..000.0.....0.0...0.......0...0.0.0.", english_translator.reader.read_second_arg
  end

  def test_write_a_very_long
    english_translator = EnglishTranslator.new
    ARGV[0] = "test_input_writer/long_message.txt"
    ARGV[1] = "test_output_writer/long_braille_for_tests.txt"
    english_translator.read_and_write_english_to_braille

    assert_equal 1544, english_translator.reader.read_second_arg.length
  end

  def test_write_all_characters
    english_translator = EnglishTranslator.new
    ARGV[0] = "test_input_writer/all_characters.txt"
    ARGV[1] = "test_output_writer/all_characters_for_tests.txt"
    english_translator.read_and_write_english_to_braille

    assert_equal 518, english_translator.reader.read_second_arg.length
  end

  def test_write_all_characters_and_numbers
    english_translator = EnglishTranslator.new
    ARGV[0] = "test_input_writer/message_capital_abc_for_tests.txt"
    ARGV[1] = "test_output_writer/braille_capital_abc_for_tests.txt"
    english_translator.read_and_write_english_to_braille

    assert_equal 38, english_translator.reader.read_second_arg.length
  end
end
