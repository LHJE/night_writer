require './lib/file_reader'
require './lib/file_writer'
require './lib/dictionary'
require 'pry'

class NightWriter

  attr_reader :reader, :writer, :dictionary

  def initialize
    @reader = FileReader.new
    @writer = FileWriter.new
    @dictionary = Dictionary.new("./data/braille_dictionary.txt")
  end

  def output_statement
    message, *braille = ARGV

    p "Created '#{braille.reduce}' containing #{reader.read_first_arg.chomp.length} characters"
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

  def find_braille_rows_assembled(braille_by_row)
    braille_rows_assembled = []
    braille_by_row.each do |character|
      braille_rows_assembled << "#{character.join("")}\n"
    end
    braille_rows_assembled
  end

  def read_and_write_english_to_braille
    new_text = reader.read_first_arg.chomp.split("")
    braille_message = translate_to_braille(new_text)
    header, *rows = braille_message
    braille_by_row = header.zip(*rows)
    braille_rows_assembled = find_braille_rows_assembled(braille_by_row)
    braille_all_one_line = []
    braille_all_one_line << braille_rows_assembled.join("").delete_suffix("\n")
    writer.write(braille_all_one_line.reduce)
  end

end

#this below isn't gonna work I don't think
# ARGV[0] = "message.txt"
# ARGV[1] = "braille.txt"
night_writer = NightWriter.new
# night_writer.output_statement
