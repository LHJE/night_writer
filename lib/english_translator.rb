require './lib/file_reader'
require './lib/file_writer'
require './lib/dictionary'
require 'pry'

class EnglishTranslator

  attr_reader :reader, :writer, :dictionary

  def initialize
    @reader = FileReader.new
    @writer = FileWriter.new
    @dictionary = Dictionary.new("./data/braille_dictionary.txt")
  end

  def output_statement
    message, *braille = ARGV

    p "Created '#{braille.reduce}' containing #{reader.read_second_arg.chomp.length} characters"
  end

  def read_and_write_english_to_english
    new_text = reader.read_first_arg.chomp
    writer.write(new_text)
  end

  def translate_to_braille(new_text)
    braille_message = []
    new_text.each do |character|
      dictionary.dictionary.each do |letter, braille|
        if letter == character
          braille_message << braille.split(" ")
        end
      end
    end
    braille_message
  end

  def find_braille_by_row(braille_message)
    header, *rows = braille_message
    braille_by_row = header.zip(*rows)
    braille_by_row
  end

  def find_braille_rows_assembled(braille_by_row)
    braille_rows_assembled = []
    braille_by_row.each do |character|
      braille_rows_assembled << "#{character.join("")}"
    end
    braille_rows_assembled
  end

  def find_braille_rows_shortened(braille_rows_assembled)
    braille_rows_shortened = braille_rows_assembled.map do |braille_row|
      braille_row.scan(/.{1,80}/).join(" ").split(" ")
    end
    braille_rows_shortened
  end

  def find_transposed_b_message_w_breaks(braille_rows_shortened)
    transposed_b_message_w_breaks = braille_rows_shortened.map do |braille_rows|
      braille_rows.map do |braille_row|
        braille_row.insert(-1, "\n")
      end
    end.transpose.flatten
    transposed_b_message_w_breaks
  end

  def find_braille_all_one_line(transposed_b_message_w_breaks)
    braille_all_one_line = []
    braille_all_one_line << transposed_b_message_w_breaks.join("").delete_suffix("\n")
    braille_all_one_line
  end

  def read_and_write_english_to_braille
    new_text = reader.read_first_arg.chomp.split("")
    braille_message = translate_to_braille(new_text)
    braille_by_row = find_braille_by_row(braille_message)
    braille_rows_assembled = find_braille_rows_assembled(braille_by_row)
    braille_rows_shortened = find_braille_rows_shortened(braille_rows_assembled)
    transposed_b_message_w_breaks = find_transposed_b_message_w_breaks(braille_rows_shortened)
    braille_all_one_line = find_braille_all_one_line(transposed_b_message_w_breaks)
    writer.write(braille_all_one_line.reduce)
  end

end

#turn the below on to use program.  Test won't work if they're on, however.
# night_writer = NightWriter.new
# night_writer.read_and_write_english_to_braille
# night_writer.output_statement
